-- Local patch for obsidian.nvim's YAML frontmatter key parser.
--
-- lua/obsidian/yaml/parser.lua defines
--   local YAML_KEY_REGEX = "([a-zA-Z0-9_-()/]+[a-zA-Z0-9_()/ -]*)"
-- ASCII-only, and matched with string.find (no ^ anchor), so a key with any
-- accented byte is truncated to its ASCII tail: `raça: Elfo` is stored as
-- `a = "Elfo"` and `região: Norte` as `o = "Norte"`.
--
-- Consequence for this vault: every property keyed with accents (raça in 69
-- notes, região in 10) reads as missing from obsidian.nvim's cache, and
-- everything built on that cache — including the dataview fences rendered by
-- obsidian-query.nvim — shows "-" in those columns.
--
-- The fix is one character class (allow bytes 128-255). Applied idempotently at
-- startup, before obsidian.nvim loads. When it lands, the on-disk note cache is
-- dropped so rows are re-indexed with the real keys.
--
-- An upstream issue/PR is owed; once obsidian.nvim ships the fix this module
-- becomes a no-op (the pattern below will no longer match).

local M = {}

-- literal source line to look for (plain find, not a Lua pattern)
local OLD = 'local YAML_KEY_REGEX = "([a-zA-Z0-9_-()/]+[a-zA-Z0-9_()/ -]*)"'
-- replacement keeps the byte escapes as TEXT (\128) so the written file stays readable
local NEW =
  'local YAML_KEY_REGEX = "([a-zA-Z0-9_-()/\\128-\\255]+[a-zA-Z0-9_()/ \\128-\\255]*)"'

local function parser_path()
  return table.concat({
    vim.fn.stdpath("data"),
    "lazy",
    "obsidian.nvim",
    "lua",
    "obsidian",
    "yaml",
    "parser.lua",
  }, "/")
end

---@return boolean patched true when the file was rewritten by this call
function M.apply()
  local path = parser_path()
  if vim.fn.filereadable(path) == 0 then
    return false -- plugin not installed (yet)
  end

  local lines = vim.fn.readfile(path)
  local hit ---@type integer?
  for i, line in ipairs(lines) do
    if line:find(OLD, 1, true) then
      hit = i
      break
    end
  end
  if not hit then
    return false -- already patched, or upstream changed the line
  end

  lines[hit] = NEW
  local ok = vim.fn.writefile(lines, path) == 0
  if not ok then
    vim.notify("obsidian-patch: failed to write " .. path, vim.log.levels.ERROR)
    return false
  end

  -- keys change shape, so the persisted index is now wrong: drop it
  local cache = vim.fn.stdpath("cache") .. "/obsidian.nvim"
  if vim.fn.isdirectory(cache) == 1 then
    vim.fn.delete(cache, "rf")
  end

  vim.notify(
    "obsidian.nvim: patched YAML key parser (accented frontmatter keys); cache reset",
    vim.log.levels.INFO
  )
  return true
end

return M

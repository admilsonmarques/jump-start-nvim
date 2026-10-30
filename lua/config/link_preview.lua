-- Floating preview of the Obsidian link under the cursor.
--
-- obsidian.nvim has no peek/hover command (only <CR> to follow plus pickers with
-- preview), so this resolves the target through the vault cache and shows the
-- note in a float.
--
-- Two details matter:
--   * markview skips `buftype=nofile` buffers (`preview.ignore_buftypes`), which
--     is what vim.lsp.util.open_floating_preview creates — so the float uses a
--     normal buffer and the window is opened by hand, letting markview render it.
--   * the frontmatter block is dropped: raw YAML in a peek window is noise.
local M = {}

---Resolve a link target to a note path inside the workspace.
---Handles "Note", "folder/Note", "Note#heading" and alias matches.
---@param target string
---@return string?
local function resolve_target(target)
  if target == nil or target == "" then
    return nil
  end
  local name = target:gsub("#.*$", ""):gsub("%.md$", "")
  if name == "" then
    return nil
  end

  local root = _G.Obsidian and Obsidian.dir and tostring(Obsidian.dir)
  local ok, cache = pcall(require, "obsidian.cache")
  if ok and cache.is_enabled() then
    for path, row in pairs(cache.notes.all()) do
      if root == nil or vim.startswith(path, root .. "/") then
        local base = vim.fn.fnamemodify(path, ":t:r")
        if base:lower() == name:lower() then
          return path
        end
        for _, alias in ipairs(row.aliases or {}) do
          if tostring(alias):lower() == name:lower() then
            return path
          end
        end
      end
    end
  end

  if root then
    local hits = vim.fn.globpath(root, "**/" .. vim.fn.escape(name, "*?[{`'\" ") .. ".md", false, true)
    if #hits == 1 then
      return hits[1]
    end
  end
  return nil
end

---Link under the cursor: { raw, target, kind } or nil.
---@return table?
local function link_at_cursor()
  local ok, api = pcall(require, "obsidian.api")
  if not ok or not api.cursor_link then
    return nil
  end
  local got, link, kind, _, ref = pcall(api.cursor_link)
  if not got or link == nil then
    return nil
  end
  if kind == "image" or (ref and ref.embed) then
    return nil -- embedded images/notes have their own rendering
  end
  return { raw = (ref and ref.raw) or link, target = (ref and ref.target) or link, kind = kind }
end

---Note body without the frontmatter block.
---@param path string
---@return string[]
local function note_lines(path)
  local lines = vim.fn.readfile(path, "", 600)
  if lines[1] == "---" then
    for i = 2, math.min(#lines, 200) do
      if lines[i] == "---" then
        return vim.list_slice(lines, i + 1)
      end
    end
  end
  return lines
end

---@param focus boolean enter the float (markview renders on attach either way)
---@return integer? win
local function open_float(lines, title, focus)
  local buf = vim.api.nvim_create_buf(false, false)
  vim.bo[buf].buftype = "" -- markview ignores nofile buffers
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "markdown"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = math.max(40, math.floor(vim.o.columns * 0.72))
  local height = math.min(#lines, math.max(10, math.floor(vim.o.lines * 0.7)))
  local win = vim.api.nvim_open_win(buf, focus, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    title = " " .. title .. " ",
    title_pos = "center",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
  })
  vim.wo[win].conceallevel = 2
  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true

  -- close on q/<Esc>; a non-focused peek also closes as soon as the cursor moves
  for _, lhs in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", lhs, function()
      pcall(vim.api.nvim_win_close, win, true)
    end, { buffer = buf, nowait = true, desc = "Close preview" })
  end
  if not focus then
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      once = true,
      desc = "Close link preview",
      callback = function()
        pcall(vim.api.nvim_win_close, win, true)
      end,
    })
  end
  return win
end

---Open the preview for the link under the cursor.
---@param opts? { focus?: boolean }
---@return boolean handled
function M.preview(opts)
  opts = opts or {}
  local link = link_at_cursor()
  if not link then
    return false
  end
  local path = resolve_target(link.target)
  if not path or vim.fn.filereadable(path) == 0 then
    return false
  end
  open_float(note_lines(path), vim.fn.fnamemodify(path, ":t:r"), opts.focus == true)
  return true
end

---Install the buffer-local preview bindings (markdown buffers only).
---@param bufnr integer
function M.attach(bufnr)
  -- K: focused peek (q/<Esc> closes); falls back to the normal K
  vim.keymap.set("n", "K", function()
    if M.preview({ focus = true }) then
      return
    end
    vim.api.nvim_feedkeys("K", "n", false)
  end, { buffer = bufnr, desc = "Preview link under cursor" })

  vim.keymap.set("n", "<leader>op", function()
    M.preview({ focus = true })
  end, { buffer = bufnr, desc = "Preview link under cursor" })

  -- hover: CursorHold runs in normal mode only, after 'updatetime' (300ms)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup("obsidian_link_preview_" .. bufnr, { clear = true }),
    desc = "Peek the link under the cursor",
    callback = function()
      if vim.fn.pumvisible() == 1 or vim.fn.mode() ~= "n" then
        return
      end
      M.preview()
    end,
  })
end

return M

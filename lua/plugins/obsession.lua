-- [nfnl] fnl/plugins/obsession.fnl
local _local_1_ = require("config.utils")
local autocmd = _local_1_.autocmd
local augroup = _local_1_.augroup
local function skip_obsession_3f()
  local fname = vim.fn.expand("%:t")
  return (("" ~= vim.bo.buftype) or string.match(fname, "^%.git") or (fname == "COMMIT_EDITMSG") or (fname == "MERGE_MSG"))
end
local function start_obsession()
  if not skip_obsession_3f() then
    return vim.cmd("Obsession")
  else
    return nil
  end
end
local function _3_()
  return vim.cmd("Obsession")
end
local function _4_()
  return autocmd("VimEnter", {group = augroup("obsession-autostart", {clear = true}), desc = "Keep Session.vim fresh so tmux-resurrect can restore this pane after a crash", callback = start_obsession})
end
return {{"tpope/vim-obsession", keys = {{"<leader>xo", _3_, mode = "n", desc = "Toggle Obsession (session tracking)"}}, config = _4_, lazy = false}}

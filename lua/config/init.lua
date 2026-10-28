-- [nfnl] fnl/config/init.fnl
vim.api.nvim_command("command! -nargs=1 -complete=help H help <args> | silent only")
local function _1_()
  return vim.cmd("if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif")
end
vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", group = vim.api.nvim_create_augroup("LastPosition", {clear = true}), callback = _1_})
vim.o.autoread = true
local function _2_()
  return vim.cmd("silent! checktime")
end
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold"}, {pattern = "*", group = vim.api.nvim_create_augroup("AutoChecktime", {clear = true}), callback = _2_})
local function _3_()
  return vim.hl.on_yank({higroup = "IncSearch", timeout = 300})
end
vim.api.nvim_create_autocmd("TextYankPost", {group = vim.api.nvim_create_augroup("yank_highlight", {}), pattern = "*", callback = _3_})
return {}

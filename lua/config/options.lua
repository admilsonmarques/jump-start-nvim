-- [nfnl] fnl/config/options.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local icons = require("config.icons")
local _local_2_ = require("config.utils")
local g = _local_2_.g
local opt = _local_2_.opt
vim.opt["wrap"] = false
vim.opt["spell"] = true
vim.opt["list"] = true
g("loaded_netrw", 1)
g("loaded_netrwPlugin", 1)
local fillchars = ("foldopen:" .. core.get(icons.ui, "FolderOpen") .. ",foldclose:" .. core.get(icons.ui, "Folder") .. ",foldsep:" .. core.get(icons.ui, "LineDots") .. ",fold: ")
vim.opt["foldcolumn"] = "1"
vim.opt["foldlevel"] = 99
vim.opt["foldlevelstart"] = 99
vim.opt["foldenable"] = true
vim.opt["foldnestmax"] = 1
vim.opt["laststatus"] = 3
vim.opt["guicursor"] = "n-v-c:block-blinkwait400-blinkon400-blinkoff400,i-ci-ve:ver25-blinkwait300-blinkon300-blinkoff300,r-cr:hor20,o:hor50"
local options = {completeopt = "menuone,noselect,preview", ignorecase = true, smartcase = true, clipboard = "unnamedplus", cmdheight = 2, conceallevel = 1, fileencoding = "utf-8", hlsearch = true, mouse = "a", pumheight = 10, showmode = true, showtabline = 2, smartindent = true, splitbelow = true, splitright = true, termguicolors = true, timeoutlen = 100, updatetime = 300, expandtab = true, shiftwidth = 2, tabstop = 2, cursorline = true, number = true, numberwidth = 4, signcolumn = "yes", scrolloff = 8, sidescrolloff = 8, guifont = "MesloLGF_NF:h17", fillchars = fillchars, backup = false, relativenumber = false, swapfile = false, wrap = false, writebackup = false}
for key, value in pairs(options) do
  vim.opt[key] = value
end
return nil

-- [nfnl] fnl/plugins/whichkey.fnl
local opts
local function _1_(ctx)
  return vim.list_contains({"d", "y"}, ctx.operator)
end
opts = {preset = "modern", sort = {"alphanum"}, expand = 0, spec_plugin = true, notify = true, triggers = {{"<auto>", mode = "nxso"}}, defer = _1_, plugins = {marks = {enabled = true}, registers = {enabled = true}, spelling = {enabled = true, suggestions = 20}, presets = {text_objects = true, z = true, g = false, motions = false, nav = false, operators = false}}, win = {border = "rounded", padding = {1, 2}}, layout = {width = {min = 20, max = 50}, spacing = 3}, show_help = true, show_keys = true, disable = {ft = {"TelescopePrompt"}, bt = {"terminal", "help"}}}
local spec = {{"<leader>q", "<CMD>bd<CR>", desc = "Quit buffer", mode = "n"}, {"<leader>d", group = "Diagnostic"}, {"<leader>f", group = "Find"}, {"<leader>g", group = "Git"}, {"<leader>h", group = "Harpoon"}, {"<leader>r", group = "Replace"}, {"<leader>T", group = "Themes"}, {"<leader>t", group = "Telekasten"}, {"<leader>x", group = "Settings"}, {"<leader>z", group = "Folds"}, {"<localleader>r", group = "Request"}, {"<localleader>x", group = "Diagnostics"}}
local function _2_()
  vim.g["mapleader"] = " "
  vim.g["maplocalleader"] = ","
  vim.opt["timeout"] = true
  vim.opt["timeoutlen"] = 300
  return nil
end
local function _3_()
  local wk = require("which-key")
  wk.setup(opts)
  return wk.add(spec)
end
return {{"folke/which-key.nvim", event = "VeryLazy", init = _2_, config = _3_}}

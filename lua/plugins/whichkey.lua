-- [nfnl] Compiled from fnl/plugins/whichkey.fnl by https://github.com/Olical/nfnl, do not edit.
local plugins = {spelling = {enabled = true, suggestions = 20}, presets = {text_objects = true, z = true, g = false, motions = false, nav = false, operators = false}, marks = false, registers = false}
local keys = {{"<leader>q", "<CMD>bd<CR>", mode = "n", desc = "Quit tab"}}
local leader_mappings = {d = {name = "Diagnostic"}, f = {name = "Find"}, g = {name = "Git"}, h = {name = "Harpoon"}, r = {name = "Replace"}, T = {name = "Themes"}, t = {name = "Telekasten"}, x = {name = "Settings"}, z = {name = "Folds"}}
local local_leader_mappings = {r = {name = "Request"}}
local opts = {preset = "modern", sort = {"alphanum"}, expand = 0, plugins = plugins}
local function _1_()
  vim.opt["timeout"] = true
  vim.opt["timeoutlen"] = 300
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(leader_mappings, {prefix = "<leader>"})
  return wk.register(local_leader_mappings, {prefix = "<localleader>"})
end
return {{"folke/which-key.nvim", keys = keys, init = _1_, event = false}}

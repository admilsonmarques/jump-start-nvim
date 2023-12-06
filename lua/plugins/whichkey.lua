-- [nfnl] Compiled from fnl/plugins/whichkey.fnl by https://github.com/Olical/nfnl, do not edit.
local plugins = {spelling = {enabled = true, suggestions = 20}, presets = {nav = false, text_objects = false, operators = false, motions = false, g = false, z = false}, marks = false, registers = false}
local keys = {{"<leader>q", "<CMD>q<CR>", mode = "n", desc = "Quit tab"}}
local leader_mappings = {d = {name = "Diagnostic"}, f = {name = "Find"}, g = {name = "Git"}, h = {name = "Harpoon"}, r = {name = "Replace"}, T = {name = "Themes"}, t = {name = "Telekasten"}, x = {name = "Settings"}, z = {name = "Folds"}}
local local_leader_mappings = {r = {name = "Request"}}
local function _1_()
  vim.opt["timeout"] = true
  vim.opt["timeoutlen"] = 300
  local wk = require("which-key")
  wk.setup({plugins = plugins})
  wk.register(leader_mappings, {prefix = "<leader>"})
  return wk.register(local_leader_mappings, {prefix = "<localleader>"})
end
return {{"folke/which-key.nvim", keys = keys, init = _1_, event = false}}

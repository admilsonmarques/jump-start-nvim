-- [nfnl] Compiled from fnl/plugins/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local function get_list()
  local harpoon = require("harpoon")
  return harpoon.list(harpoon)
end
local function toggle_quick_menu()
  local harpoon = require("harpoon")
  local list = harpoon.list(harpoon)
  local ui = harpoon.ui
  return ui.toggle_quick_menu(ui, list)
end
local function append()
  local list = get_list()
  return list.append(list)
end
local function get_list_element(index)
  local list = get_list()
  return list.select(list, index)
end
local keys
local function _1_()
  return append()
end
local function _2_()
  return toggle_quick_menu()
end
local function _3_()
  return get_list_element(1)
end
local function _4_()
  return get_list_element(2)
end
local function _5_()
  return get_list_element(3)
end
local function _6_()
  return get_list_element(4)
end
keys = {{"<leader>ha", _1_, mode = "n", desc = "Append Harpoon"}, {"<leader>hh", _2_, mode = "n", desc = "Harpoon Menu"}, {"<leader>h1", _3_, mode = "n", desc = "Harpoon 1st"}, {"<leader>h2", _4_, mode = "n", desc = "Harpoon 2nd"}, {"<leader>h3", _5_, mode = "n", desc = "Harpoon 3rd"}, {"<leader>h4", _6_, mode = "n", desc = "Harpoon 4th"}}
local function _7_()
  local harpoon = require("harpoon")
  return harpoon.setup(harpoon)
end
return {{"ThePrimeagen/harpoon", dependencies = {"nvim-lua/plenary.nvim"}, branch = "harpoon2", keys = keys, config = _7_}}

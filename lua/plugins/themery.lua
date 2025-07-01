-- [nfnl] fnl/plugins/themery.fnl
local themes = {"rose-pine", "rose-pine-moon", "rose-pine-main", "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-moon", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha", "dracula", "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus", "rose-pine-dawn", "tokyonight-day", "catppuccin-latte", "dracula-soft"}
local styles = {comments = {italic = true}, keywords = {italic = true}, functions = {bold = true}, variables = {italic = false}, sidebars = "transparent", floats = "transparent"}
local tokyonight_config
local function _1_(hl)
  hl.CursorLineNr = {fg = "#99a0c7"}
  hl.LineNr = {fg = "#586085"}
  return nil
end
tokyonight_config = {style = "moon", styles = styles, transparent = true, transparent_background = true, dim_inactive = true, terminal_colors = true, on_highlights = _1_}
local keys = {{"<leader>TT", "<CMD>Themery<CR>", desc = "Themery"}}
local function _2_()
  local theme = require("tokyonight")
  return theme.setup(tokyonight_config)
end
local function _3_()
  local themery = require("themery")
  return themery.setup({themes = themes, livePreview = true})
end
return {{"folke/tokyonight.nvim", priority = 1000, config = _2_, lazy = false}, {"rose-pine/neovim", name = "rose-pine", priority = 1000, lazy = false}, {"catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false}, {"Mofiqul/dracula.nvim", name = "dracula", priority = 1000, lazy = false}, {"rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000, lazy = false}, {"zaldih/themery.nvim", keys = keys, config = _3_, lazy = false}}

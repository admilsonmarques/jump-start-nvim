-- [nfnl] fnl/plugins/themery.fnl
local function entry(name, bg, _3fextra)
  return {name = name, colorscheme = name, before = ("vim.o.background = '" .. bg .. "'" .. (_3fextra or ""))}
end
local rose_pine_auto = "; require('rose-pine').setup({variant = 'auto'})"
local themes = {entry("rose-pine", "dark", rose_pine_auto), "rose-pine-moon", "rose-pine-main", entry("tokyonight", "dark"), "tokyonight-night", "tokyonight-storm", "tokyonight-moon", entry("catppuccin-frappe", "dark"), entry("catppuccin-macchiato", "dark"), entry("catppuccin-mocha", "dark"), "dracula", entry("kanagawa", "dark"), entry("kanagawa-wave", "dark"), entry("kanagawa-dragon", "dark"), entry("kanagawa-lotus", "light"), "rose-pine-dawn", "tokyonight-day", entry("catppuccin-latte", "light"), "dracula-soft", {name = "OneDark (dark)", colorscheme = "onedark", before = "vim.o.background = 'dark'; require('onedark').setup({style = 'dark'})"}, {name = "OneDark (light)", colorscheme = "onedark", before = "vim.o.background = 'light'; require('onedark').setup({style = 'light'})"}, "github_light", "github_light_default", "github_light_high_contrast", "github_light_colorblind", "github_light_tritanopia"}
local styles = {comments = {italic = true}, keywords = {italic = true}, functions = {bold = true}, variables = {italic = false}, sidebars = "dark", floats = "dark"}
local tokyonight_config
local function _1_(hl)
  if (vim.o.background == "dark") then
    hl.CursorLineNr = {fg = "#99a0c7"}
    hl.LineNr = {fg = "#586085"}
    return nil
  else
    return nil
  end
end
tokyonight_config = {style = "moon", styles = styles, transparent_background = true, dim_inactive = true, terminal_colors = true, on_highlights = _1_, transparent = false}
local keys = {{"<leader>TT", "<CMD>Themery<CR>", desc = "Themery"}}
local function _3_()
  local theme = require("tokyonight")
  theme.setup(tokyonight_config)
  local function _4_()
    return theme.setup(tokyonight_config)
  end
  return vim.api.nvim_create_autocmd("ColorSchemePre", {pattern = "tokyonight*", callback = _4_})
end
local function _5_()
  local themery = require("themery")
  return themery.setup({themes = themes, livePreview = true})
end
return {{"folke/tokyonight.nvim", priority = 1000, config = _3_, lazy = false}, {"rose-pine/neovim", name = "rose-pine", priority = 1000, lazy = false}, {"catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false}, {"Mofiqul/dracula.nvim", name = "dracula", priority = 1000, lazy = false}, {"rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000, lazy = false}, {"navarasu/onedark.nvim", name = "onedark", priority = 1000, lazy = false}, {"projekt0n/github-nvim-theme", name = "github", priority = 1000, lazy = false}, {"zaldih/themery.nvim", keys = keys, config = _5_, lazy = false}}

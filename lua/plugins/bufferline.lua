-- [nfnl] Compiled from fnl/plugins/bufferline.fnl by https://github.com/Olical/nfnl, do not edit.
local offset = {{filetype = "undotree", text = "Undotree", highlight = "PanelHeading", padding = 1}, {filetype = "NvimTree", text = "Explorer", highlight = "PanelHeading", padding = 1}, {filetype = "DiffviewFiles", text = "Diff View", highlight = "PanelHeading", padding = 1}, {filetype = "flutterToolsOutline", text = "Flutter Outline", highlight = "PanelHeading", padding = 1}, {filetype = "packer", text = "Packer", highlight = "PanelHeading", padding = 1}}
local opts = {options = {mode = "buffers", numbers = "none", close_command = "", right_mouse_command = "vert sbuffer %d", left_mouse_command = "buffer %d", middle_mouse_command = nil, indicator = {icon = "\226\150\142", style = "icon"}, close_icon = "\239\128\141", buffer_close_icon = "\239\153\149", modified_icon = "\226\151\143", left_trunc_marker = "\239\130\168", right_trunc_marker = "\239\130\169", truncate_names = true, diagnostics = "nvim_lsp", offset = offset, color_icons = true, show_buffer_icons = true, show_buffer_close_icons = true, persist_buffer_sort = true, separator_style = "thin", hover = {enable = true, delay = 100, reveal = {"close"}}, sort_by = "directory"}}
local keys = {{"<S-l>", "<CMD>BufferLineCycleNext<CR>", mode = "n", desc = "Next Tab"}, {"<S-h>", "<CMD>BufferLineCyclePrev<CR>", mode = "n", desc = "Previous Tab"}}
local function _1_()
  local bufferline = require("bufferline")
  return bufferline.setup(opts)
end
return {{"akinsho/bufferline.nvim", version = "*", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_, keys = keys, lazy = false}}

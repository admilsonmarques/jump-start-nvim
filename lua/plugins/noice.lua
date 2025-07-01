-- [nfnl] fnl/plugins/noice.fnl
local lsp = {override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true}, hover = {enabled = false}, signature = {enabled = false}}
local presets = {bottom_search = true, command_palette = true, long_message_to_split = true, inc_rename = false, lsp_doc_border = false}
local opts = {lsp = lsp, presets = presets}
local keys = {{"<leader>rn", "<CMD>Noice<CR>", mode = "n", desc = "Notifications"}}
local function _1_()
  local noice = require("noice")
  return noice.setup(opts)
end
return {{"folke/noice.nvim", event = "VeryLazy", dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, keys = keys, config = _1_}}

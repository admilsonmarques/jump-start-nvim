-- [nfnl] fnl/plugins/noice.fnl
local opts = {cmdline = {enabled = true, view = "cmdline_popup"}, messages = {enabled = true, view = "notify"}, lsp = {override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true}}, presets = {command_palette = true, long_message_to_split = true, bottom_search = false}}
return {{"folke/noice.nvim", event = "VeryLazy", opts = opts, dependencies = {"MunifTanjim/nui.nvim"}}}

-- [nfnl] fnl/plugins/transparent.fnl
local keys = {{"<leader>Tt", "<CMD>TransparentToggle<CR>", mode = "n", desc = "Transparency"}}
return {{"xiyaowong/transparent.nvim", keys = keys, lazy = false}}

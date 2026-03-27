-- [nfnl] fnl/plugins/gitdiff.fnl
local keys = {{"<leader>gd", "<cmd>DiffviewOpen<CR>", mode = "n", desc = "Diff Open"}, {"<leader>gD", "<cmd>DiffviewClose<CR>", mode = "n", desc = "Diff Close"}}
return {{"sindrets/diffview.nvim", keys = keys}}

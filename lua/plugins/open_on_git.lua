-- [nfnl] Compiled from fnl/plugins/open_on_git.fnl by https://github.com/Olical/nfnl, do not edit.
local keys = {{"<leader>go", "<CMD>OpenInGHFile<CR>", mode = "n", desc = "Open on file"}, {"<leader>gl", "<CMD>OpenInGHFileLines<CR>", mode = "n", desc = "Open on line"}, {"<leader>gr", "<CMD>OpenInGHRepo<CR>", mode = "n", desc = "Open Repo"}}
return {{"almo7aya/openingh.nvim", keys = keys, lazy = false}}

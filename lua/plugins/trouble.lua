-- [nfnl] fnl/plugins/trouble.fnl
local nkeys = {{"<leader>dd", "<cmd>TroubleToggle<cr>", desc = "Trouble Toggle"}}
return {{"folke/trouble.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, cmd = {"TroubleToggle", "Trouble"}, keys = nkeys, opts = {use_diagnostic_signs = true}}}

-- [nfnl] Compiled from fnl/plugins/undotree.fnl by https://github.com/Olical/nfnl, do not edit.
local keys = {{"<leader>u", "<CMD>UndotreeToggle<CR>", mode = "n", desc = "UndoTree"}}
return {{"mbbill/undotree", keys = keys}}

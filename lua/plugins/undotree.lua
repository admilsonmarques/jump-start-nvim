-- [nfnl] fnl/plugins/undotree.fnl
local keys = {{"<leader>u", "<CMD>UndotreeToggle<CR>", mode = "n", desc = "UndoTree"}}
return {{"mbbill/undotree", keys = keys}}

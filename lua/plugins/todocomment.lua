-- [nfnl] fnl/plugins/todocomment.fnl
local keys
local function _1_()
  return require("todo-comments").jump_next()
end
local function _2_()
  return require("todo-comments").jump_prev()
end
keys = {{"]t", _1_, mode = "n", desc = "Next Todo"}, {"[t", _2_, mode = "n", desc = "Prev Todo"}, {"<leader>fT", "<cmd>TodoTelescope<CR>", mode = "n", desc = "Find Todos"}}
return {{"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, event = {"BufReadPost", "BufNewFile"}, cmd = {"TodoTrouble", "TodoTelescope"}, keys = keys, config = true}}

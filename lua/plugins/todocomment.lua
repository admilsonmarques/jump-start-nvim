-- [nfnl] fnl/plugins/todocomment.fnl
return {{"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {}, cmd = {"TodoTrouble", "TodoTelescope"}, event = {"BufReadPost", "BufNewFile"}, config = true}}

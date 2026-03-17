(local keys [{1 "]t"
              2 (fn [] ((. (require :todo-comments) :jump_next)))
              :mode :n
              :desc "Next Todo"}
             {1 "[t"
              2 (fn [] ((. (require :todo-comments) :jump_prev)))
              :mode :n
              :desc "Prev Todo"}
             {1 :<leader>fT
              2 :<cmd>TodoTelescope<CR>
              :mode :n
              :desc "Find Todos"}])

[{1 :folke/todo-comments.nvim
  :dependencies [:nvim-lua/plenary.nvim]
  :event [:BufReadPost :BufNewFile]
  :cmd [:TodoTrouble :TodoTelescope]
  : keys
  :config true}]

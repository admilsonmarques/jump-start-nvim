(local keys
       [{1 "]h"
         2 (fn []
             (if vim.wo.diff
                 (vim.cmd "normal! ]c")
                 ((. (require :gitsigns) :next_hunk))))
         :mode :n
         :desc "Next Hunk"}
        {1 "[h"
         2 (fn []
             (if vim.wo.diff
                 (vim.cmd "normal! [c")
                 ((. (require :gitsigns) :prev_hunk))))
         :mode :n
         :desc "Prev Hunk"}
        {1 :<leader>hs
         2 :<cmd>Gitsigns stage_hunk<CR>
         :mode [:n :v]
         :desc "Stage Hunk"}
        {1 :<leader>hr
         2 :<cmd>Gitsigns reset_hunk<CR>
         :mode [:n :v]
         :desc "Reset Hunk"}
        {1 :<leader>hp
         2 :<cmd>Gitsigns preview_hunk<CR>
         :mode :n
         :desc "Preview Hunk"}
        {1 :<leader>hb
         2 :<cmd>Gitsigns blame_line<CR>
         :mode :n
         :desc "Blame Line"}
        {1 :<leader>hd
         2 :<cmd>Gitsigns diffthis<CR>
         :mode :n
         :desc "Diff This"}])

[{1 :lewis6991/gitsigns.nvim
  :lazy false
  : keys
  :config (fn []
            (let [gitsigns (require :gitsigns)]
              (gitsigns.setup {})))}]

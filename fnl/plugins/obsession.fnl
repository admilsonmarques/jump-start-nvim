(local {: autocmd : augroup} (require :config.utils))

(fn skip-obsession? []
  "Skip auto-tracking for git commit messages and other special buffers"
  (let [fname (vim.fn.expand "%:t")]
    (or (not= "" vim.bo.buftype)
        (string.match fname "^%.git")
        (= fname "COMMIT_EDITMSG")
        (= fname "MERGE_MSG"))))

(fn start-obsession []
  (when (not (skip-obsession?))
    (vim.cmd :Obsession)))

[{1 :tpope/vim-obsession
  :lazy false
  :keys [{1 :<leader>xo
          2 (fn [] (vim.cmd :Obsession))
          :mode :n
          :desc "Toggle Obsession (session tracking)"}]
  :config (fn []
            (autocmd :VimEnter
                     {:group (augroup :obsession-autostart {:clear true})
                      :desc "Keep Session.vim fresh so tmux-resurrect can restore this pane after a crash"
                      :callback start-obsession}))}]

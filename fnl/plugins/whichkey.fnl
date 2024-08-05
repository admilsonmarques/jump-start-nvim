(local plugins {:marks false
                ;shows a list of your marks on ' and `
                :registers false
                ;shows your registers on " in NORMAL or <C-r> in INSERT mode
                :spelling {:enabled true :suggestions 20}
                :presets {:operators false
                          :motions false
                          :text_objects true
                          :nav false
                          :z true
                          :g false}})

(local keys [{1 :<leader>q 2 :<CMD>bd<CR> :mode :n :desc "Quit tab"}])

(local leader-mappings {:d {:name :Diagnostic}
                        :f {:name :Find}
                        :g {:name :Git}
                        :h {:name :Harpoon}
                        :r {:name :Replace}
                        :T {:name :Themes}
                        :t {:name :Telekasten}
                        :x {:name :Settings}
                        :z {:name :Folds}})

(local local-leader-mappings {:r {:name :Request}})

(local opts {:preset :modern :sort [:alphanum] :expand 0 : plugins})

[{1 :folke/which-key.nvim
  :event false
  : keys
  :init (fn []
          (tset vim.opt :timeout true)
          (tset vim.opt :timeoutlen 300)
          (let [wk (require :which-key)]
            (wk.setup opts)
            (wk.register leader-mappings {:prefix :<leader>})
            (wk.register local-leader-mappings {:prefix :<localleader>})))}]


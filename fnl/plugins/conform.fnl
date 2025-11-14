(local keys [{1 :<localleader>f
              2 (fn []
                  (let [conform (require :conform)]
                    (conform.format)))
              :mode [:n :v]
              :desc "Format buffer"}])

[{1 :stevearc/conform.nvim
  : keys
  :lazy false
  :config (fn []
            (let [conform (require :conform)]
              (conform.setup {;; Define all our formatters
                              :formatters {; :zprint {:command :zprint
                                           ; :args ["{:map {:align-option :long-always :force-nl? true} :pair {:force-nl? true} :width 100}"
                                           ;        :--stdin]
                                           ; }
                                           :fnlfmt {:command :fnlfmt
                                                    :args ["-"]}
                                           :stylua {:command :stylua
                                                    :args ["-"]}
                                           :black {:command :black :args ["-"]}
                                           :shfmt {:command :shfmt}
                                           :prettierd {:command :prettierd
                                                       :stdin true
                                                       :args [:--single-quote
                                                              :--stdin-filepath
                                                              :$FILENAME]}}
                              ;; Associate formatters with filetypes
                              :formatters_by_ft {:fennel [:fnlfmt]
                                                 :lua [:stylua]
                                                 :clojure [:joker]
                                                 :python [:black]
                                                 :sh [:shfmt]
                                                 :javascript [:prettierd]
                                                 :typescript [:prettierd]
                                                 :typescriptreact [:prettierd]
                                                 :css [:prettierd]
                                                 :scss [:prettierd]
                                                 :html [:prettierd]
                                                 :json [:prettierd]
                                                 :yaml [:prettierd]
                                                 :markdown [:prettierd]}})))}]

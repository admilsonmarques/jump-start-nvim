(local keys [{1 :<leader>f 2 (fn [] ((require :conform) :format)) :mode [:n :v] :desc "Format buffer"}])


[{1 :stevearc/conform.nvim
  :keys keys
  :lazy false
  :config (fn []
            (let [conform (require :conform)]
              (conform.setup 
                {;; Define all our formatters
                 :formatters {:zprint_justified {:command :zprint
                                                 ;; Pass the config map as a string argument!
                                                 :args ["{:map {:style :justified} :width 100}"]}
                              :fnlfmt {:command :fnlfmt :args [:-]}
                              :stylua {:command :stylua :args [:-]}
                              :black {:command :black :args [:-]}
                              :shfmt {:command :shfmt}
                              :prettierd {:command :prettierd}}

                 ;; Associate formatters with filetypes
                 :formatters_by_ft {:fennel [:fnlfmt]
                                    :lua [:stylua]
                                    :clojure [:zprint_justified]
                                    :python [:black]
                                    :sh [:shfmt]
                                    ;; Use a single, fast daemon for all web formats
                                    :javascript [:prettierd]
                                    :typescript [:prettierd]
                                    :typescriptreact [:prettierd]
                                    :css [:prettierd]
                                    :scss [:prettierd]
                                    :html [:prettierd]
                                    :json [:prettierd]
                                    :yaml [:prettierd]
                                    :markdown [:prettierd]}

                 ;; Enable format on save
                 :format_on_save {:timeout_ms 500
                                  :lsp_fallback true}})))}]

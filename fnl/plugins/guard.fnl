(local keys [{1 :<localleader>f 2 "<CMD>Guard fmt<CR>" :mode :n :desc :Format}])

[{1 :nvimdev/guard.nvim
  :dependencies [:nvimdev/guard-collection]
  :config (fn []
            (let [ft (require :guard.filetype)]
              (-> (ft :python) (: :fmt :black))
              (-> (ft :fennel) (: :fmt :fnlfmt))
              (-> (ft :clojure)
                  (: :fmt {:cmd :joker
                           :args [:--format "-"]
                           :stdin true
                           :ignore_error true}))
              (-> (ft "javascript,typescript,typescriptreact,css,scss,html,json,jsonc,yaml,markdown,graphql")
                  (: :fmt {:cmd :prettier
                           :args [:--single-quote :--write ]
                           :fname true
                           } :lint :eslint))
              (-> (ft "scala,sbt")
                  (: :fmt {:cmd :scalafmt
                           :args [:--quiet :--stdin :--assume-filename]
                           :stdin true
                           :fname true}))
              (-> (ft "bash,sh,zsh") (: :fmt :shfmt))
              (tset vim.g :guard_config
                    {:fmt_on_save false :lsp_as_default_formatter false})))
  : keys}]

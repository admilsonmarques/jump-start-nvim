(local {: autocmd : augroup : llmap} (require :config.utils))


;; Adapted from https://github.com/hudclark/.dotfiles/blob/640a0f3d1a367a8803c2a8cc43f68b4ce0e245f2/.config/nvim/fnl/user/plugins/lsp/metals.fnl#L4
(fn status-handler [err status ctx]
  (let [text (-> status.text
                 (: :gsub "[⠇⠋⠙⠸⠴⠦]" "")
                 (: :gsub "^%s*(.-)%s*$" "%1"))
        msg-val (if status.hide {:kind :end}
                    status.show {:kind :begin :title text}
                    status.text {:kind :report :message text})
        info {:client_id ctx.client_id}
        msg {:token :metals :value msg-val}]
    (when msg.value
      ((. vim.lsp.handlers :$/progress) err msg ctx))))

;; Define keymaps with filetype restrictions
(local metals-keys
  [{1 :<localleader>I 2 "<cmd>lua require'metals'.organize_imports()<cr>"
    :desc "Organize Imports"}
   {1 :<localleader>m 2 "<cmd>lua require'telescope'.extensions.metals.commands()<cr>"
    :desc "Metals Menu"}])

;; Which-key groups for better organization
(local metals-groups
  [{1 :<localleader>m :group "Metals"}])

[{1 :scalameta/nvim-metals
  :dependencies [:nvim-lua/plenary.nvim
                 :mfussenegger/nvim-dap
                 :nvim-lua/popup.nvim
                 :hrsh7th/cmp-nvim-lsp]
  :keys metals-keys
  :config (fn []
            (let [metals (require :metals)
                  metals-config (metals.bare_config)
                  nvim-metals-group (augroup :nvim-metals {:clear true})]
              ;; Tell metals to use the above status handler
              (tset metals-config :handlers {:metals/status status-handler})
              ;; Enable metals LSP status
              (tset metals-config.init_options :statusBarProvider :on)
              (tset metals-config :settings
                    {:showImplicitArguments true
                     :showImplicitConversionsAndClasses true
                     :showInferredType true
                     :enableSemanticHighlighting false
                     :serverVersion :latest.snapshot
                     :scalafixRulesDependencies ["com.github.liancheng/scalafix-rules-dotty:0.1.6"]
                     :serverProperties ["-XX:+UseStringDeduplication"
                                        "-XX:MaxInlineLevel=20"
                                        "-XX:+UseParallelGC"
                                        :-Xmx10G
                                        :-Xms2G]
                     :testUserInterface "Test Explorer"})
              ((. (require :cmp_nvim_lsp) :default_capabilities))
              (tset metals-config :on_attach
                    (fn [client bufnr]
                      (metals.setup_dap)))
              (autocmd :FileType
                       {:pattern [:scala :sbt :sc]
                        :callback #(metals.initialize_or_attach metals-config)
                        :group nvim-metals-group})
              
              ;; Add which-key groups when which-key is available
              (vim.schedule (fn []
                              (when (pcall require :which-key)
                                (let [wk (require :which-key)]
                                  (wk.add metals-groups)))))))}]

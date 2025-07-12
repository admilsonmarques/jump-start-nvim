(local mason-opts {:ui {:border :rounded
                        :icons {:package_installed "✓"
                                :package_pending "➜"
                                :package_uninstalled "✗"}}
                   :max_concurrent_installers 10})

[{1 :VonHeikemen/lsp-zero.nvim
  :branch :v3.x
  :lazy true
  :config false
  :init (fn []
          (tset vim.g :lsp_zero_extend_cmp 0)
          (tset vim.g :lsp_zero_extend_lspconfig 0))}
 {1 :williamboman/mason.nvim
  :lazy false
  :config (fn []
            (let [mason (require :mason)]
              (require :mason-lspconfig)
              (mason.setup mason-opts)))}
 ;; LSP Support
 {1 :neovim/nvim-lspconfig
  :cmd [:LspInfo :LspInstall :LspStart]
  :event [:BufReadPre :BufNewFile]
  :dependencies [:hrsh7th/cmp-nvim-lsp :williamboman/mason-lspconfig.nvim]
  :config (fn [] ; This is where all the LSP shenanigans will live
            (let [lsp_zero (require :lsp-zero)
                  mason_lspconfig (require :mason-lspconfig)
                  cmp_nvim_lsp (require :cmp_nvim_lsp)]
              (lsp_zero.extend_lspconfig)
              
              ;; Enhanced diagnostic configuration
              (vim.diagnostic.config {:virtual_text {:spacing 4
                                                     :source :if_many
                                                     :prefix :●}
                                      :signs true
                                      :underline true
                                      :update_in_insert false
                                      :severity_sort true
                                      :float {:border :rounded
                                              :source :always
                                              :header ""
                                              :prefix ""}})
              
              ;; Enhanced capabilities with additional features
              (local capabilities (vim.tbl_deep_extend :force
                                                       (vim.lsp.protocol.make_client_capabilities)
                                                       (cmp_nvim_lsp.default_capabilities)
                                                       {:textDocument {:foldingRange {:dynamicRegistration false
                                                                                      :lineFoldingOnly true}
                                                                       :completion {:completionItem {:snippetSupport true
                                                                                                     :resolveSupport {:properties [:documentation
                                                                                                                                   :detail
                                                                                                                                   :additionalTextEdits]}}}}}))
              
              (lsp_zero.on_attach (fn [client bufnr] ; see :help lsp-zero-keybindings ; to learn the available actions
                                    ;; Disable semantic tokens for better performance if needed
                                    (when (and client.server_capabilities
                                               client.server_capabilities.semanticTokensProvider)
                                      (tset client.server_capabilities :semanticTokensProvider nil))
                                    
                                    (vim.keymap.set :n :<leader>L
                                                    :<cmd>LspInfo<cr>
                                                    {:desc :LspInfo
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<leader>rr
                                                    "<cmd>lua vim.lsp.buf.rename()<cr>"
                                                    {:desc :Rename
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>D
                                                    "<cmd>lua vim.diagnostic.open_float()<cr>"
                                                    {:desc "Float Diagnostic"
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>d
                                                    "<cmd>lua vim.lsp.buf.definition()<cr>"
                                                    {:desc :Definition
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>k
                                                    "<cmd>lua vim.lsp.buf.hover()<cr>"
                                                    {:desc :Hover
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>h
                                                    "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>"
                                                    {:desc "Toggle Inlay Hints"
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>a
                                                    "<cmd>lua vim.lsp.buf.code_action()<cr>"
                                                    {:desc :Action
                                                     :buffer bufnr})
                                    ;; Additional useful keymaps
                                    (vim.keymap.set :n :<localleader>r
                                                    "<cmd>lua vim.lsp.buf.references()<cr>"
                                                    {:desc :References
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>i
                                                    "<cmd>lua vim.lsp.buf.implementation()<cr>"
                                                    {:desc :Implementation
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>xx "<cmd>Trouble diagnostics toggle<cr>" {:desc "Diagnostics (Trouble)"})
                                    (vim.keymap.set :n :<localleader>xX "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" {:desc "Buffer Diagnostics (Trouble)"})))
              
              ;; Enhanced server configurations
              (local server-configs
                {:lua_ls {:settings {:Lua {:runtime {:version :LuaJIT}
                                           :diagnostics {:globals [:vim]}
                                           :workspace {:library (vim.api.nvim_get_runtime_file "" true)
                                                       :checkThirdParty false}
                                           :telemetry {:enable false}}}}
                 :ts_ls {:settings {:typescript {:inlayHints {:includeInlayParameterNameHints :all
                                                              :includeInlayParameterNameHintsWhenArgumentMatchesName false
                                                              :includeInlayFunctionParameterTypeHints true
                                                              :includeInlayVariableTypeHints true
                                                              :includeInlayPropertyDeclarationTypeHints true
                                                              :includeInlayFunctionLikeReturnTypeHints true
                                                              :includeInlayEnumMemberValueHints true}}}}
                 :pyright {:settings {:python {:analysis {:autoSearchPaths true
                                                          :useLibraryCodeForTypes true
                                                          :diagnosticMode :workspace}}}}
                 :yamlls {:settings {:yaml {:schemas {:kubernetes "*.yaml"
                                                      "http://json.schemastore.org/github-workflow" ".github/workflows/*"
                                                      "http://json.schemastore.org/github-action" ".github/action.{yml,yaml}"
                                                      "http://json.schemastore.org/prettierrc" ".prettierrc.{yml,yaml}"
                                                      "http://json.schemastore.org/stylelintrc" ".stylelintrc.{yml,yaml}"
                                                      "http://json.schemastore.org/circle-ci" ".circleci/**/*.{yml,yaml}"}}}}})
              
              (mason_lspconfig.setup {:ensure_installed [:clojure_lsp
                                                         :ts_ls
                                                         :fennel_language_server
                                                         :lua_ls
                                                         :jqls
                                                         :yamlls
                                                         :pyright
                                                         :bashls        ; Bash
                                                         :jsonls        ; JSON
                                                         :cssls         ; CSS
                                                         :html          ; HTML
                                                         :marksman]
                                      :handlers {1 (fn [server_name]
                                                     (let [lspconfig (require :lspconfig)
                                                           server-config (. server-configs server_name)
                                                           final-config (vim.tbl_deep_extend :force
                                                                                             {: capabilities}
                                                                                             (or server-config {}))]
                                                       ((. lspconfig server_name :setup) final-config)))
                                                 :lua_ls (fn []
                                                           (let [lua_opts (lsp_zero.nvim_lua_ls)
                                                                 lspconfig (require :lspconfig)
                                                                 enhanced-config (vim.tbl_deep_extend :force
                                                                                                      lua_opts
                                                                                                      {: capabilities}
                                                                                                      (. server-configs :lua_ls))]
                                                                                                                           (lspconfig.lua_ls.setup enhanced-config)))}})))}
 ;; Autocompletion
 {1 :zbirenbaum/copilot-cmp
  :config (fn []
            (let [copilot (require :copilot_cmp)]
              (copilot.setup {})))}
 {1 :hrsh7th/nvim-cmp
  :event :InsertEnter
  :dependencies [:L3MON4D3/LuaSnip
                 :hrsh7th/cmp-buffer
                 :hrsh7th/cmp-path
                 :saadparwaiz1/cmp_luasnip
                 :hrsh7th/cmp-nvim-lsp
                 :hrsh7th/cmp-nvim-lua
                 :zbirenbaum/copilot-cmp
                 :rafamadriz/friendly-snippets]
  :config (fn [] ; Here is where you configure the autocompletion settings
            (let [lsp_zero (require :lsp-zero)
                  cmp (require :cmp)
                  cmp_action (lsp_zero.cmp_action)
                  luasnip (require :luasnip)]
              ;; Load friendly snippets
              (require :luasnip.loaders.from_vscode)
              (luasnip.config.setup {})
              
              (lsp_zero.extend_cmp)
              (cmp.setup {:formatting (lsp_zero.cmp_format {:details true})
                          :sources (cmp.config.sources [{:name :nvim_lsp :priority 1000}
                                                         
                                                         {:name :luasnip :priority 800}
                                                         {:name :buffer :priority 500 :keyword_length 3}
                                                         {:name :path :priority 400}]
                                                       [{:name :buffer :keyword_length 3}])
                          :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
                          :window {:completion (cmp.config.window.bordered)
                                   :documentation (cmp.config.window.bordered)}
                          :mapping (cmp.mapping.preset.insert {:<C-SPACE> (cmp.mapping.complete)
                                                               :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                                                            :select true})
                                                               :<C-u> (cmp.mapping.scroll_docs -4)
                                                               :<C-d> (cmp.mapping.scroll_docs 4)
                                                               :<C-f> (cmp_action.luasnip_jump_forward)
                                                               :<C-b> (cmp_action.luasnip_jump_backward)
                                                               :<C-e> (cmp.mapping.abort)
                                                               :<C-n> (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Insert})
                                                               :<C-p> (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Insert})})})))}]


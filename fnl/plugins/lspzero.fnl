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
  :dependencies [:saghen/blink.cmp :williamboman/mason-lspconfig.nvim]
  :config (fn [] ; This is where all the LSP shenanigans will live
            (let [lsp_zero (require :lsp-zero)
                  mason_lspconfig (require :mason-lspconfig)
                  blink_cmp (require :blink.cmp)]
              (lsp_zero.extend_lspconfig)
              ;; Enhanced diagnostic configuration
              (vim.diagnostic.config {:virtual_text {:spacing 4
                                                     :source :if_many
                                                     :prefix "●"}
                                      :signs true
                                      :underline true
                                      :update_in_insert false
                                      :severity_sort true
                                      :float {:border :rounded
                                              :source :always
                                              :header ""
                                              :prefix ""}})
              ;; Enhanced capabilities with additional features
              (local capabilities
                     (vim.tbl_deep_extend :force
                                          (vim.lsp.protocol.make_client_capabilities)
                                          (blink_cmp.get_lsp_capabilities)
                                          {:textDocument {:foldingRange {:dynamicRegistration false
                                                                         :lineFoldingOnly true}
                                                          :completion {:completionItem {:snippetSupport true
                                                                                        :resolveSupport {:properties [:documentation
                                                                                                                      :detail
                                                                                                                      :additionalTextEdits]}}}}}))
              (lsp_zero.on_attach (fn [client bufnr] ; see :help lsp-zero-keybindings ; to learn the available actions
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
                                    (vim.keymap.set :n :<localleader>xx
                                                    "<cmd>Trouble diagnostics toggle<cr>"
                                                    {:desc "Diagnostics (Trouble)"})
                                    (vim.keymap.set :n :<localleader>xX
                                                    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
                                                    {:desc "Buffer Diagnostics (Trouble)"})))
              ;; Enhanced server configurations
              (local server-configs
                     ;; clojure-lsp's bundled OTel SDK tries to export metrics to localhost:4317 on
                     ;; every boot; with no collector listening it was crash-looping every ~5s and
                     ;; blew ~/.local/state/nvim/lsp.log up to 1GB. Disable it at the client level.
                     {:clojure_lsp {:cmd_env {:OTEL_SDK_DISABLED "true"}
                                    :capabilities {:textDocument {:foldingRange {:formatting false
                                                                                 :rangeFormatting false}}}}
                      :lua_ls {:settings {:Lua {:runtime {:version :LuaJIT}
                                                :diagnostics {:globals [:vim]}
                                                :workspace {:library (vim.api.nvim_get_runtime_file ""
                                                                                                    true)
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
                      :yamlls {:settings {:yaml {:schemas {:kubernetes :*.yaml
                                                           "http://json.schemastore.org/github-workflow" :.github/workflows/*
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
                                                         :bashls
                                                         ; Bash
                                                         :jsonls
                                                         ; JSON
                                                         :cssls
                                                         ; CSS
                                                         :html
                                                         ; HTML
                                                         :marksman]
                                      :handlers {1 (fn [server_name]
                                                     (let [lspconfig (require :lspconfig)
                                                           server-config (. server-configs
                                                                            server_name)
                                                           final-config (vim.tbl_deep_extend :force
                                                                                             {: capabilities}
                                                                                             (or server-config
                                                                                                 {}))]
                                                       ((. lspconfig
                                                           server_name :setup) final-config)))
                                                 :lua_ls (fn []
                                                           (let [lua_opts (lsp_zero.nvim_lua_ls)
                                                                 lspconfig (require :lspconfig)
                                                                 enhanced-config (vim.tbl_deep_extend :force
                                                                                                      lua_opts
                                                                                                      {: capabilities}
                                                                                                      (. server-configs
                                                                                                         :lua_ls))]
                                                             (lspconfig.lua_ls.setup enhanced-config)))}})))}
 ;; Autocompletion
 {1 :L3MON4D3/LuaSnip
  :version "v2.*"
  :build "make install_jsregexp"
  :dependencies [:rafamadriz/friendly-snippets]
  :config (fn []
            (let [luasnip (require :luasnip)]
              ((. (require :luasnip.loaders.from_vscode) :lazy_load))
              (luasnip.config.setup {})))}
 {1 :saghen/blink.cmp
  :version "*"
  :event :InsertEnter
  :dependencies [:L3MON4D3/LuaSnip
                 :rafamadriz/friendly-snippets
                 :giuxtaposition/blink-cmp-copilot]
  :config (fn [] ; Here is where you configure the autocompletion settings
            (let [blink (require :blink.cmp)]
              (blink.setup {:snippets {:preset :luasnip}
                            :keymap {:preset :none
                                     :<CR> [:accept :fallback]
                                     :<Up> [:select_prev :fallback]
                                     :<Down> [:select_next :fallback]
                                     :<C-j> [:scroll_documentation_down :fallback]
                                     :<C-k> [:scroll_documentation_up :fallback]
                                     :<C-f> [:snippet_forward :fallback]
                                     :<C-b> [:snippet_backward :fallback]
                                     :<C-e> [:cancel :fallback]}
                            :completion {:documentation {:auto_show true}
                                         :menu {:border :rounded}
                                         :ghost_text {:enabled false}
                                         ;; don't preselect the first item: <CR> should
                                         ;; only accept a suggestion you actually
                                         ;; navigated to with <Up>/<Down>, otherwise it
                                         ;; just inserts a newline like you'd expect
                                         :list {:selection {:preselect false}}}
                            :sources {:default [:lsp :path :snippets :buffer :copilot]
                                      :providers {:copilot {:name :copilot
                                                            :module :blink-cmp-copilot
                                                            :score_offset 100
                                                            :async true}}}})))}]

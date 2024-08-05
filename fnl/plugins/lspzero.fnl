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
                  mason_lspconfig (require :mason-lspconfig)]
              (lsp_zero.extend_lspconfig)
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
                                                    "<cmd>lua vim.lsp.buf.signature_help()<cr>"
                                                    {:desc :Signature
                                                     :buffer bufnr})
                                    (vim.keymap.set :n :<localleader>a
                                                    "<cmd>lua vim.lsp.buf.code_action()<cr>"
                                                    {:desc :Action
                                                     :buffer bufnr})))
              (mason_lspconfig.setup {:ensure_installed [:clojure_lsp
                                                         :tsserver
                                                         :fennel_language_server
                                                         :lua_ls
                                                         :jqls
                                                         :yamlls
                                                         :pyright]
                                      :handlers {1 (lsp_zero.default_setup)
                                                 :lua_ls (fn []
                                                           (let [lua_opts (lsp_zero.nvim_lua_ls)
                                                                 lspconfig (require :lspconfig)]
                                                             (lspconfig.lua_ls.setup lua_opts)))
                                                 :fennel_language_server (fn []
                                                                           (let [lspconfig (require :lspconfig)]
                                                                             (lspconfig.fennel_language_server.setup {})))
                                                 :clojure_lsp (fn []
                                                                (let [lspconfig (require :lspconfig)]
                                                                  (lspconfig.clojure_lsp.setup {})))
                                                 :jqls (fn []
                                                         (let [lspconfig (require :lspconfig)]
                                                           (lspconfig.jqls.setup {})))
                                                 :yamlls (fn []
                                                           (let [lspconfig (require :lspconfig)]
                                                             (lspconfig.yamlls.setup {})))
                                                 :pyright (fn []
                                                            (let [lspconfig (require :lspconfig)]
                                                              (lspconfig.pyright.setup {})))
                                                 :tsserver (fn []
                                                             (let [lspconfig (require :lspconfig)]
                                                               (lspconfig.tsserver.setup {})))}})))}
 {1 :williamboman/mason-lspconfig.nvim}
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
                  cmp_action (lsp_zero.cmp_action)]
              (lsp_zero.extend_cmp)
              (cmp.setup {:formating (lsp_zero.cmp_format)
                          :mapping (cmp.mapping.preset.insert {:<C-SPACE> (cmp.mapping.complete)
                                                               :<C-i> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                                                            :select true})
                                                               :<C-u> (cmp.mapping.scroll_docs -4)
                                                               :<C-d> (cmp.mapping.scroll_docs 4)
                                                               :<C-f> (cmp_action.luasnip_jump_forward)
                                                               :<C-b> (cmp_action.luasnip_jump_backward)})})))}]


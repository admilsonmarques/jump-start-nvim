(local opts {:preset :modern
             :sort [:alphanum]
             :expand 0
             :spec_plugin true
             :notify true
             :triggers [{1 :<auto> :mode :nxso}]
             :defer (fn [ctx]
                      (vim.list_contains [:d :y] ctx.operator))
             :plugins {:marks {:enabled true}
                       :registers {:enabled true}
                       :spelling {:enabled true :suggestions 20}
                       :presets {:operators false
                                 :motions false
                                 :text_objects true
                                 :nav false
                                 :z true
                                 :g false}}
             :win {:border :rounded
                   :padding [1 2]}
             :layout {:width {:min 20 :max 50}
                      :spacing 3}
             :show_help true
             :show_keys true
             :disable {:ft [:TelescopePrompt]
                       :bt [:terminal :help]}})

(local spec [{1 :<leader>q 2 :<CMD>bd<CR> :desc "Quit buffer" :mode :n}
             {1 :<leader>d :group :Diagnostic}
             {1 :<leader>f :group :Find}
             {1 :<leader>g :group :Git}
             {1 :<leader>h :group :Harpoon}
             {1 :<leader>r :group :Replace}
             {1 :<leader>T :group :Themes}
             {1 :<leader>t :group :Telekasten}
             {1 :<leader>x :group :Settings}
             {1 :<leader>z :group :Folds}
             {1 :<localleader>r :group :Request}
             {1 :<localleader>x :group :Diagnostics}])

[{1 :folke/which-key.nvim
  :event :VeryLazy
  :init (fn []
          (tset vim.g :mapleader " ")
          (tset vim.g :maplocalleader ",")
          (tset vim.opt :timeout true)
          (tset vim.opt :timeoutlen 300))
  :config (fn []
            (let [wk (require :which-key)]
              (wk.setup opts)
              (wk.add spec)))}]


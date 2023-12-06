(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(fn opts [themes]
  (let [grep-actions (require :telescope-live-grep-args.actions)]
    {:defaults {:file_ignore_patterns [:node_modules]}
     :extensions {:ui-select [(themes.get_dropdown)]
                  :live_grep_args {:auto_quoting true
                                   :mappings {:i {:<C-k> (grep-actions.quote_prompt)
                                                  :<C-i> (grep-actions.quote_prompt {:postfix " --iglob "})}}}}
     :pickers {:find_files {:find_command [:rg
                                           :--files
                                           :--iglob
                                           :!.git
                                           :--hidden]}}}))

(local keys ;find
       [
        
        {1 :<leader>ff
         2 "<cmd>Telescope find_files theme=dropdown<cr>"
 :mode :n        :desc "Files"}
        {1 :<leader>ft
         2 "<cmd>Telescope live_grep theme=ivy<cr>"
 :mode :n        :desc "Text(grep)"}
        {1 :<leader>fS
         2 "<cmd>Telescope grep_string theme=dropdown<cr>"
  :mode :n       :desc "Word"}
        {1 :<leader>fl 2 "<cmd>Telescope resume<cr>" :desc "Last Search"}
        {1 :<leader>fp 2 "<CMD>Telescope projects<CR>" :desc :Projects}
        {1 :<leader>fr
         2 "<cmd>Telescope oldfiles theme=dropdown<cr>"
         :desc "Recent File"}
        {1 :<leader>fk 2 "<cmd>Telescope keymaps<cr>" :desc :Keymaps}
        {1 :<leader>fC 2 "<cmd>Telescope commands<cr>" :desc :Commands}
        ; diag
        {1 :<leader>dt
         2 "<cmd>Telescope diagnostics theme=dropdown<cr>"
         :desc "Telescope"}])


[{1 :nvim-telescope/telescope-fzf-native.nvim
  :build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"}
 {1 :nvim-telescope/telescope.nvim
  :branch :0.1.x
  :lazy false
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-telescope/telescope-ui-select.nvim
                 :nvim-telescope/telescope-file-browser.nvim
                 :nvim-telescope/telescope-live-grep-args.nvim
                 :nvim-lua/popup.nvim
                 :ahmedkhalf/project.nvim
                 :xiyaowong/telescope-emoji.nvim
                 :nvim-telescope/telescope-fzf-native.nvim
                 :nvim-telescope/telescope-symbols.nvim]
  : keys
  :config (fn []
            (let [telescope (require :telescope)
                  themes (require :telescope.themes)]
              (telescope.setup (opts themes))
              (telescope.load_extension :ui-select)
              (telescope.load_extension :emoji)
              (telescope.load_extension :projects)
              (telescope.load_extension :file_browser)
              (telescope.load_extension :live_grep_args)
              (telescope.load_extension :fzf)))}]


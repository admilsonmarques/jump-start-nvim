(local neotest-keys
       [{1 :<localleader>tt
         2 (fn [] ((. (require :neotest) :run :run))) ; mirrors conjure "Test Current"
         :desc "Test Current"}
        {1 :<localleader>tn
         2 (fn [] ((. (require :neotest) :run :run) (vim.fn.expand "%"))) ; mirrors conjure "Test Namespace"
         :desc "Test Namespace"}
        {1 :<localleader>ta
         2 (fn [] ((. (require :neotest) :run :run) (vim.fn.getcwd))) ; mirrors conjure "Test All"
         :desc "Test All"}
        {1 :<localleader>tr
         2 (fn [] ((. (require :neotest) :run :run_last))) ; mirrors conjure "Test Refresh"
         :desc "Test Refresh"}
        {1 :<localleader>to
         2 (fn [] ((. (require :neotest) :output :open) {:enter true}))
         :desc "Test Output"}
        {1 :<localleader>ts
         2 (fn [] ((. (require :neotest) :summary :toggle)))
         :desc "Test Summary"}])

(local neotest-groups [{1 :<localleader>t :group :Test}])

[{1 :nvim-neotest/neotest
  :ft [:javascript :typescript :javascriptreact :typescriptreact :go :python :lua]
  :dependencies [:nvim-neotest/nvim-nio
                 :nvim-lua/plenary.nvim
                 :nvim-treesitter/nvim-treesitter
                 :nvim-neotest/neotest-jest
                 :nvim-neotest/neotest-go
                 :nvim-neotest/neotest-python
                 :nvim-neotest/neotest-plenary]
  :keys neotest-keys
  :config (fn []
            (let [neotest (require :neotest)]
              (neotest.setup {:adapters [((require :neotest-jest) {})
                                         ((require :neotest-go) {})
                                         ((require :neotest-python) {})
                                         (require :neotest-plenary)]
                              :output {:open_on_run true}
                              :quickfix {:open false}})
              (vim.schedule (fn []
                              (when (pcall require :which-key)
                                (let [wk (require :which-key)]
                                  (wk.add neotest-groups)))))))}]

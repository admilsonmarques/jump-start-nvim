(local {: autocmd : augroup} (require :config.utils))

;; FlowStorm debugger integration (via Conjure)
;; Requires flow-storm-debugger on the Leiningen classpath:
;;   :plugins [[flow-storm/flow-storm-debugger "LATEST"]]

(fn create-commands []
  (vim.api.nvim_create_user_command
    :FlowStormConnect
    (fn [] (vim.cmd "ConjureEval (do (require '[flow-storm.api :as fs-api]) (fs-api/local-connect))"))
    {:desc "Connect to FlowStorm"})
  (vim.api.nvim_create_user_command
    :FlowStormDisconnect
    (fn [] (vim.cmd "ConjureEval (flow-storm.api/stop)"))
    {:desc "Stop FlowStorm GUI (keeps REPL running)"})
  (vim.api.nvim_create_user_command
    :FlowStormQuit
    (fn []
      (vim.cmd "ConjureEval (do (flow-storm.api/stop) (System/exit 0))"))
    {:desc "Stop FlowStorm and kill the REPL process"})
  (vim.api.nvim_create_user_command
    :FlowStormStartRecording
    (fn [] (vim.cmd "ConjureEval (flow-storm.api/start-recording)"))
    {:desc "Start FlowStorm recording"})
  (vim.api.nvim_create_user_command
    :FlowStormStopRecording
    (fn [] (vim.cmd "ConjureEval (flow-storm.api/stop-recording)"))
    {:desc "Stop FlowStorm recording"})
  (vim.api.nvim_create_user_command
    :FlowStormReset
    (fn [] (vim.cmd "ConjureEval (flow-storm.api/reset)"))
    {:desc "Reset FlowStorm"}))

(fn create-keymaps []
  (let [opts {:silent true :noremap true :buffer true}]
    (vim.keymap.set :n :<localleader>Fc :<cmd>FlowStormConnect<CR>
                    (vim.tbl_extend :force opts {:desc "FlowStorm Connect"}))
    (vim.keymap.set :n :<localleader>Fd :<cmd>FlowStormDisconnect<CR>
                    (vim.tbl_extend :force opts {:desc "FlowStorm Disconnect"}))
    (vim.keymap.set :n :<localleader>Fq :<cmd>FlowStormQuit<CR>
                    (vim.tbl_extend :force opts {:desc "FlowStorm Quit (kill REPL)"}))
    (vim.keymap.set :n :<localleader>Fs :<cmd>FlowStormStartRecording<CR>
                    (vim.tbl_extend :force opts {:desc "FlowStorm Start Recording"}))
    (vim.keymap.set :n :<localleader>Fp :<cmd>FlowStormStopRecording<CR>
                    (vim.tbl_extend :force opts {:desc "FlowStorm Stop Recording"}))
    (vim.keymap.set :n :<localleader>Fr :<cmd>FlowStormReset<CR>
                    (vim.tbl_extend :force opts {:desc "FlowStorm Reset"}))))

(create-commands)

(autocmd :FileType
         {:pattern [:clojure :clj :cljs :cljc]
          :group (augroup :flowstorm {:clear true})
          :desc "Register FlowStorm keymaps for Clojure buffers"
          :callback (fn [] (create-keymaps))})

;; Register FlowStorm which-key group once at startup
(vim.schedule
  (fn []
    (when (pcall require :which-key)
      ((. (require :which-key) :add)
       [{1 :<localleader>F :group :FlowStorm}]))))

{}

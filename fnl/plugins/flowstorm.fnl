[]
; (local {: autocmd : augroup} (require :config.utils))
;
; ;; FlowStorm keymaps - only available for Clojure/ClojureScript projects
; (local flowstorm-keys
;   [{1 :<localleader>Fc 2 "<cmd>FlowStormConnect<cr>"
;     :desc "FlowStorm Connect"}
;    {1 :<localleader>Fd 2 "<cmd>FlowStormDisconnect<cr>"
;     :desc "FlowStorm Disconnect"}
;    {1 :<localleader>Fs 2 "<cmd>FlowStormStartRecording<cr>"
;     :desc "Start Recording"}
;    {1 :<localleader>Fp 2 "<cmd>FlowStormStopRecording<cr>"
;     :desc "Stop Recording"}
;    {1 :<localleader>Fr 2 "<cmd>FlowStormReset<cr>"
;     :desc "Reset FlowStorm"}
;    {1 :<localleader>Fb 2 "<cmd>FlowStormBreakpoint<cr>"
;     :desc "Toggle Breakpoint"}
;    {1 :<localleader>Fi 2 "<cmd>FlowStormInstrument<cr>"
;     :desc "Instrument Form"}
;    {1 :<localleader>Fu 2 "<cmd>FlowStormUninstrument<cr>"
;     :desc "Uninstrument Form"}])
;
; ;; Which-key groups for better organization
; (local flowstorm-groups
;   [{1 :<localleader>F :group "FlowStorm"}])
;
; ;; FlowStorm commands configuration
; (fn setup-flowstorm-commands []
;   (vim.api.nvim_create_user_command
;     :FlowStormConnect
;     (fn []
;       (vim.cmd "ConjureEval (do (require '[flow-storm.api :as fs-api]) (fs-api/local-connect))"))
;     {:desc "Connect to FlowStorm debugger"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormDisconnect
;     (fn []
;       (vim.cmd "ConjureEval (flow-storm.api/stop)"))
;     {:desc "Disconnect from FlowStorm debugger"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormStartRecording
;     (fn []
;       (vim.cmd "ConjureEval (flow-storm.api/start-recording)"))
;     {:desc "Start FlowStorm recording"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormStopRecording
;     (fn []
;       (vim.cmd "ConjureEval (flow-storm.api/stop-recording)"))
;     {:desc "Stop FlowStorm recording"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormReset
;     (fn []
;       (vim.cmd "ConjureEval (flow-storm.api/reset)"))
;     {:desc "Reset FlowStorm"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormBreakpoint
;     (fn []
;       (vim.cmd "ConjureEval #fs/trace"))
;     {:desc "Insert FlowStorm breakpoint at cursor"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormInstrument
;     (fn []
;       (vim.cmd "ConjureEvalRootForm"))
;     {:desc "Instrument current form with FlowStorm"})
;   
;   (vim.api.nvim_create_user_command
;     :FlowStormUninstrument
;     (fn []
;       (vim.cmd "ConjureEval (flow-storm.api/uninstrument-var (var current-form))"))
;     {:desc "Uninstrument current form"}))
;
; [{1 :jpmonettas/flow-storm-debugger
;   :dependencies [:Olical/conjure]
;   :ft [:clojure :clojurescript :clj :cljs :cljc]
;   :keys flowstorm-keys
;   :config (fn []
;             (setup-flowstorm-commands)
;             
;             ;; Auto-add FlowStorm dependency when connecting
;             (let [flowstorm-group (augroup :flowstorm-setup {:clear true})]
;               (autocmd :FileType
;                        {:pattern [:clojure :clojurescript :clj :cljs :cljc]
;                         :callback (fn []
;                                     ;; Add helpful notification about FlowStorm setup
;                                     (vim.notify "FlowStorm available! Use <localleader>Fc to connect" 
;                                                vim.log.levels.INFO 
;                                                {:title "FlowStorm"}))
;                         :group flowstorm-group}))
;             
;             ;; Add which-key groups when which-key is available
;             (vim.schedule (fn []
;                             (when (pcall require :which-key)
;                               (let [wk (require :which-key)]
;                                 (wk.add flowstorm-groups))))))}] 

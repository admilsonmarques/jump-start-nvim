(local {: g : opt : autocmd} (require :config.utils))

;; Better organized keymap configuration
(local conjure-keys
  [{1 :<localleader>cc 2 "<cmd>Lein!<cr><bar><cmd>ConjureLogVSplit<cr><bar><cmd>ConjureConnect<cr>" 
    :desc "Jack-in Lein and Conjure" :ft [:clojure]}
   {1 :gd 2 "<cmd>ConjureDefWord<CR>" :desc "Go to Definition" :ft [:clojure :fennel :scheme]}
   {1 :<c-]> 2 "<cmd>ConjureDefWord<CR>" :desc "Go to Definition" :ft [:clojure :fennel :scheme]}
   {1 :K 2 "<cmd>ConjureDocWord<CR>" :desc "Show Documentation" :ft [:clojure :fennel :scheme]}
   {1 :gD 2 "<cmd>ConjureCljViewSource<CR>" :desc "View Source" :ft [:clojure :fennel :scheme]}
   ;; Evaluation keymaps with better descriptions
   {1 :<localleader>ee 2 "<cmd>ConjureEval<CR>" :desc "Evaluate Current Form" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>er 2 "<cmd>ConjureEvalRootForm<CR>" :desc "Evaluate Root Form" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>ef 2 "<cmd>ConjureEvalFile<CR>" :desc "Evaluate File" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>eb 2 "<cmd>ConjureEvalBuf<CR>" :desc "Evaluate Buffer" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>em 2 "<cmd>ConjureEvalMotion<CR>" :desc "Evaluate Motion" :ft [:clojure :fennel :scheme]}
   ;; Enhanced testing support
   {1 :<localleader>tt 2 "<cmd>ConjureEvalCurrentTest<CR>" :desc "Test Current" :ft [:clojure]}
   {1 :<localleader>tn 2 "<cmd>ConjureTestRunNS<CR>" :desc "Test Namespace" :ft [:clojure]}
   {1 :<localleader>ta 2 "<cmd>ConjureTestRunAll<CR>" :desc "Test All" :ft [:clojure]}
   {1 :<localleader>tr 2 "<cmd>ConjureTestRefresh<CR>" :desc "Test Refresh" :ft [:clojure]}
   ;; Log management
   {1 :<localleader>ls 2 "<cmd>ConjureLogSplit<CR>" :desc "Log Split" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>lv 2 "<cmd>ConjureLogVSplit<CR>" :desc "Log VSplit" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>lt 2 "<cmd>ConjureLogTab<CR>" :desc "Log Tab" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>lq 2 "<cmd>ConjureLogCloseVisible<CR>" :desc "Close Log" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>lr 2 "<cmd>ConjureLogResetSoft<CR>" :desc "Log Reset Soft" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>lR 2 "<cmd>ConjureLogResetHard<CR>" :desc "Log Reset Hard" :ft [:clojure :fennel :scheme]}
   ;; Connection management
   {1 :<localleader>cn 2 "<cmd>ConjureConnect<CR>" :desc "Connect" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>cd 2 "<cmd>ConjureDisconnect<CR>" :desc "Disconnect" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>cs 2 "<cmd>ConjureStatus<CR>" :desc "Connection Status" :ft [:clojure :fennel :scheme]}
   ;; FIXED: Telescope integration using <localleader>s (Search) to avoid conflict with formatting
   {1 :<localleader>sp 2 (fn [] 
                           (when (pcall require :telescope)
                             (vim.cmd "Telescope live_grep search_dirs=src/")))
    :desc "Search Project" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>sf 2 (fn []
                           (when (pcall require :telescope)
                             (vim.cmd "Telescope find_files search_dirs=src/")))
    :desc "Search Files" :ft [:clojure :fennel :scheme]}])

;; Which-key groups for better organization
(local conjure-groups
  [{1 :<localleader>e :group "Evaluate" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>l :group "Log" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>c :group "Connection" :ft [:clojure :fennel :scheme]}
   {1 :<localleader>t :group "Test" :ft [:clojure]}
   {1 :<localleader>s :group "Search" :ft [:clojure :fennel :scheme]}])

;; Enhanced REPL connection management
(fn ensure-repl-connection []
  "Ensure REPL connection is active, start if needed"
  (let [conjure-available (pcall require :conjure)]
    (when conjure-available
      (vim.schedule (fn []
        (if (= (vim.fn.eval "conjure#client#get()") "")
            (do
              (vim.notify "Starting REPL connection..." vim.log.levels.INFO)
              (vim.cmd "ConjureConnect"))
            (vim.notify "REPL already connected" vim.log.levels.INFO)))))))

;; Better error handling for evaluations
(fn safe-eval-with-feedback [command]
  "Safely execute evaluation with user feedback"
  (let [conjure-available (pcall require :conjure)]
    (if conjure-available
        (do
          (vim.notify "Evaluating..." vim.log.levels.INFO)
          (vim.cmd command))
        (vim.notify "Conjure not available" vim.log.levels.ERROR))))

[{1 :Olical/conjure
  :ft [:clojure :fennel :clj]
  :keys conjure-keys
  :init (fn []
          (g "conjure#eval#result_register" "*")
          (g "conjure#log#botright" true)
          (g "conjure#mapping#doc_word" :K)
          (g "conjure#log#strip_ansi_escape_sequences_line_limit" 0)
          (g "conjure#extract#tree_sitter#enabled" true)
          (g "conjure#client#clojure#nrepl#connection#auto_repl#enabled" true)
          (g "conjure#client#clojure#nrepl#connection#auto_repl#hidden" false)
          (g "conjure#client#clojure#nrepl#connection#auto_repl#cmd" :Lein!)
          (g "conjure#client#clojure#nrepl#eval#auto_require" true)
          
          ;; Enhanced test configuration
          (g "conjure#client#clojure#nrepl#test#current_form_names"
             [:deftest :defflow :defspec :defcheck])
          (g "conjure#client#clojure#nrepl#test#runner" :clojure)
          
          ;; Remove duplicate tree_sitter setting
          ;; Set e register for evaluation result
          (g "conjure#eval#result_register" :e)
          ;; Evaluate root form (top level form) under the cursor
          ;; Default: `"er"`
          (g "conjure#mapping#eval_root_form" :ef)
          ;; Evaluate root form under the cursor & insert result as comment
          ;; Default: `"ecr"`
          (g "conjure#mapping#eval_comment_root_form" "e;")
          ;; Evaluate file loaded from disk
          ;; Default: `"ef"`
          (g "conjure#mapping#eval_file" :el)
          
          ;; Optimized HUD settings (disabled for performance)
          (g "conjure#log#hud#enabled" false)
          
          ;; Optimized log settings
          (g "conjure#log#botright" true)
          (g "conjure#log#wrap" true)
          (g "conjure#log#fold#enabled" false)
          (g "conjure#log#trim#at" 10000) ; Prevent log from growing too large
          
          ;; Number of lines to check for `ns` form, used for setting evaluation context
          ;; `b:conjure#context` to override a specific buffer that isn't finding the context
          ;; Default: `24`
          (g "conjure#extract#context_header_lines" 100)
          
          ;; Highlight
          (g "conjure#highlight#enabled" true)
          (g "conjure#highlight#timeout" 500) ; Shorter highlight timeout for performance
          
          ;; Fennel specific configuration
          (g "conjure#client#fennel#aniseed#aniseed_module_prefix" :aniseed.)
          
          ;; Enhanced autocmds with better error handling
          (autocmd :BufNewFile
                   {:desc "Conjure Log disable LSP diagnostics"
                    :callback (fn []
                                (pcall vim.diagnostic.enable false {:bufnr 0}))
                    :group (vim.api.nvim_create_augroup :conjure_log_disable_lsp
                                                        {:clear true})
                    :pattern [:conjure-log-*]})
          
          (autocmd :FileType {:desc "Lisp style line comment"
                              :callback (fn []
                                          (set vim.bo.commentstring ";; %s"))
                              :group (vim.api.nvim_create_augroup :comment_config
                                                                  {:clear true})
                              :pattern [:clojure]})
          
          ;; Auto-connect on file open for better UX
          (autocmd :BufReadPost
                   {:desc "Auto-ensure REPL connection"
                    :pattern [:*.clj :*.cljs :*.cljc :*.fnl]
                    :callback (fn []
                                (vim.defer_fn ensure-repl-connection 1000))
                    :group (vim.api.nvim_create_augroup :conjure_auto_connect
                                                        {:clear true})})
          
          ;; Better conjure log buffer settings
          (autocmd :FileType
                   {:desc "Conjure log buffer optimizations"
                    :pattern [:conjure-log]
                    :callback (fn []
                                (vim.opt_local.wrap true)
                                (vim.opt_local.number false)
                                (vim.opt_local.relativenumber false)
                                (vim.opt_local.signcolumn "no")
                                (vim.opt_local.cursorline false))
                    :group (vim.api.nvim_create_augroup :conjure_log_optimize
                                                        {:clear true})})
          
          ;; Add which-key groups when which-key is available
          (vim.schedule (fn []
                          (when (pcall require :which-key)
                            (let [wk (require :which-key)]
                              (wk.add conjure-groups)))))))}]

(local {: g : opt : autocmd} (require :config.utils))

;; CIDER-style dependency injection versions
(local cider-nrepl-version :0.57.0)
(local nrepl-version :1.3.1)

;; Build CIDER jack-in command with dependency injection
;; with-profile +unit,+integration,+dev ensures test dependencies and paths are available
(fn cider-jack-in-cmd [?port ?profile] ; with-profile +unit,+integration,+dev
  (if (and ?port (not= ?port ""))
      (.. "lein repl :connect " ?port "")
      (let [profile (if ?profile "with-profile +unit,+integration,+dev" "")]
        (.. "lein " profile "  update-in :dependencies conj '[nrepl \""
            nrepl-version "\"]' -- "
            "update-in :plugins conj '[cider/cider-nrepl \"" cider-nrepl-version
            "\"]' -- " "repl :headless"))))

;; Better organized keymap configuration
(local conjure-keys [{1 :<localleader>cc
                      2 (fn []
                          (vim.cmd (.. "!" (cider-jack-in-cmd) " &"))
                          (vim.cmd :ConjureLogVSplit)
                          (vim.schedule (fn []
                                          (vim.defer_fn #(vim.cmd :ConjureConnect)
                                            3000))))
                      :desc "Jack-in with CIDER deps and Conjure"}
                     {1 :<localleader>c!
                      2 (fn []
                          (vim.cmd (.. "!" (cider-jack-in-cmd nil true) " &"))
                          (vim.cmd :ConjureLogVSplit)
                          (vim.schedule (fn []
                                          (vim.defer_fn #(vim.cmd :ConjureConnect)
                                            3000))))
                      :desc "Jack-in with CIDER with profiles, deps and Conjure"}
                     {1 :<localleader>cC
                      2 (fn []
                          (let [port (vim.fn.input "Enter nREPL port: ")]
                            (vim.cmd (.. "!" (cider-jack-in-cmd port) " &"))
                            (vim.cmd :ConjureLogVSplit)
                            (vim.schedule (fn []
                                            (vim.defer_fn #(vim.cmd :ConjureConnect)
                                              3000)))))
                      :desc "Jack-in with CIDER deps on specific port"}
                     {1 :gd
                      2 :<cmd>ConjureDefWord<CR>
                      :desc "Go to Definition"}
                     {1 "<c-]>"
                      2 :<cmd>ConjureDefWord<CR>
                      :desc "Go to Definition"}
                     {1 :K
                      2 :<cmd>ConjureDocWord<CR>
                      :desc "Show Documentation"}
                     {1 :gD
                      2 :<cmd>ConjureCljViewSource<CR>
                      :desc "View Source"}
                     ;; Evaluation keymaps with better descriptions
                     {1 :<localleader>ee
                      2 :<cmd>ConjureEval<CR>
                      :desc "Evaluate Current Form"}
                     {1 :<localleader>er
                      2 :<cmd>ConjureEvalRootForm<CR>
                      :desc "Evaluate Root Form"}
                     {1 :<localleader>ef
                      2 :<cmd>ConjureEvalFile<CR>
                      :desc "Evaluate File"}
                     {1 :<localleader>eb
                      2 :<cmd>ConjureEvalBuf<CR>
                      :desc "Evaluate Buffer"}
                     {1 :<localleader>em
                      2 :<cmd>ConjureEvalMotion<CR>
                      :desc "Evaluate Motion"}
                     ;; Enhanced testing support
                     {1 :<localleader>tt
                      2 :<cmd>ConjureEvalCurrentTest<CR>
                      :desc "Test Current"}
                     {1 :<localleader>tn
                      2 :<cmd>ConjureTestRunNS<CR>
                      :desc "Test Namespace"}
                     {1 :<localleader>ta
                      2 :<cmd>ConjureTestRunAll<CR>
                      :desc "Test All"}
                     {1 :<localleader>tr
                      2 :<cmd>ConjureTestRefresh<CR>
                      :desc "Test Refresh"}
                     ;; Log management
                     {1 :<localleader>ls
                      2 :<cmd>ConjureLogSplit<CR>
                      :desc "Log Split"}
                     {1 :<localleader>lv
                      2 :<cmd>ConjureLogVSplit<CR>
                      :desc "Log VSplit"}
                     {1 :<localleader>lt
                      2 :<cmd>ConjureLogTab<CR>
                      :desc "Log Tab"}
                     {1 :<localleader>lq
                      2 :<cmd>ConjureLogCloseVisible<CR>
                      :desc "Close Log"}
                     {1 :<localleader>lr
                      2 :<cmd>ConjureLogResetSoft<CR>
                      :desc "Log Reset Soft"}
                     {1 :<localleader>lR
                      2 :<cmd>ConjureLogResetHard<CR>
                      :desc "Log Reset Hard"}
                     ;; Connection management
                     {1 :<localleader>cn
                      2 :<cmd>ConjureConnect<CR>
                      :desc :Connect}
                     {1 :<localleader>cd
                      2 :<cmd>ConjureDisconnect<CR>
                      :desc :Disconnect}
                     {1 :<localleader>cs
                      2 :<cmd>ConjureStatus<CR>
                      :desc "Connection Status"}
                     ;; FIXED: Telescope integration using <localleader>s (Search) to avoid conflict with formatting
                     {1 :<localleader>sp
                      2 (fn []
                          (when (pcall require :telescope)
                            (vim.cmd "Telescope live_grep search_dirs=src/")))
                      :desc "Search Project"}
                     {1 :<localleader>sf
                      2 (fn []
                          (when (pcall require :telescope)
                            (vim.cmd "Telescope find_files search_dirs=src/")))
                      :desc "Search Files"}])

;; Which-key groups for better organization
(local conjure-groups
       [{1 :<localleader>e :group :Evaluate}
        {1 :<localleader>l :group :Log}
        {1 :<localleader>c :group :Connection}
        {1 :<localleader>t :group :Test}
        {1 :<localleader>s :group :Search}])

;; Enhanced REPL connection management
(fn ensure-repl-connection []
  "Ensure REPL connection is active, start if needed"
  (let [conjure-available (pcall require :conjure)]
    (when conjure-available
      (vim.schedule (fn []
                      (if (= (vim.fn.eval "conjure#client#get()") "")
                          (do
                            (vim.notify "Starting REPL connection..."
                                        vim.log.levels.INFO)
                            (vim.cmd :ConjureConnect))
                          (vim.notify "REPL already connected"
                                      vim.log.levels.INFO)))))))

;; Better error handling for evaluations
(fn safe-eval-with-feedback [command]
  "Safely execute evaluation with user feedback"
  (let [conjure-available (pcall require :conjure)]
    (if conjure-available
        (do
          (vim.notify :Evaluating... vim.log.levels.INFO)
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
          ;; Use CIDER-style dependency injection instead of plain Lein!
          (g "conjure#client#clojure#nrepl#connection#auto_repl#cmd"
             (cider-jack-in-cmd))
          (g "conjure#client#clojure#nrepl#eval#auto_require" true)
          ;; Enhanced test configuration
          (set vim.g.conjure#client#clojure#nrepl#test#current_form_names
               [:deftest :defflow :defspec :describe])
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
          (g "conjure#extract#context_header_lines" 1000)
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
                                (vim.opt_local.signcolumn :no)
                                (vim.opt_local.cursorline false))
                    :group (vim.api.nvim_create_augroup :conjure_log_optimize
                                                        {:clear true})})
          ;; Add which-key groups when which-key is available
          (vim.schedule (fn []
                          (when (pcall require :which-key)
                            (let [wk (require :which-key)]
                              (wk.add conjure-groups))))))}]

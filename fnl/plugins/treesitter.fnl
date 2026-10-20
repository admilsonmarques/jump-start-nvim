(local ensure_installed
;; A list of parser names, or "all".
;; Languages Neovim already ships a parser AND queries for (`c`, `lua`, `markdown`,
;; `markdown_inline`, `vimdoc`, `query`, `vim`) are deliberately left out: the grammar
;; pinned by nvim-treesitter can be older than $VIMRUNTIME's queries, and an installed
;; parser shadows nvim's own. That mismatch is what produced
;; `Invalid field name "operator"` on every lua buffer.
       ["javascript" "typescript" "rust" "scala" "clojure" "fennel" "norg" "bash" "regex"])

;; nvim-treesitter (main branch) keeps its query files under `runtime/queries`, but
;; lazy.nvim only puts the plugin root on the runtimepath. Without this append, every
;; language Neovim does not ship queries for (rust, scala, clojure, yaml, json, ...)
;; runs with no highlighting at all (`vim.treesitter.query.get(lang, "highlights")` = nil).
(let [queries-dir (.. (vim.fn.stdpath :data) :/lazy/nvim-treesitter :/runtime)]
  (when (= 1 (vim.fn.isdirectory queries-dir))
    (vim.opt.runtimepath:append queries-dir)))

(local opts {
       : ensure_installed
       :sync_install false
       :auto_install true
       :highlight {:enable true
    ;; Setting this to true will run `:h syntax` and tree-sitter at the same time.
    ;; Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    ;; Using this option may slow down your editor, and you may see some duplicate highlights.
    ;; Instead of true it can also be a list of languages

       :additional_vim_regex_highlighting false}})

[{1 :nvim-treesitter/nvim-treesitter
  :lazy false
  :build ":TSUpdate"
   :config (fn []
            (let [treesitter (require :nvim-treesitter)]
              (treesitter.setup opts))) }
   {1 :nvim-treesitter/nvim-treesitter-context}
   ]

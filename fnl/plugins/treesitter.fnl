(local {: autocmd : augroup} (require :config.utils))

(local ensure_installed
;; A list of parser names, or "all".
;; Deliberately NOT listed:
;;  - `c`, `lua`, `markdown`, `markdown_inline`, `vimdoc`: Neovim ships both the parser and the
;;    queries for them ($VIMRUNTIME). The grammar pinned by nvim-treesitter can be older than those
;;    queries and an installed parser shadows nvim's own -- that mismatch produced
;;    `Invalid field name "operator"` on every lua buffer.
;;  - `norg`: no queries anywhere in nvim-treesitter main, so a parser buys no highlighting.
       ["javascript" "typescript" "rust" "scala" "clojure" "fennel" "bash" "regex"
        "css" "json" "xml" "yaml" "desktop" "gitignore" "hyprlang"])

;; nvim-treesitter (main branch) keeps its query files under `runtime/queries`, but
;; lazy.nvim only puts the plugin root on the runtimepath. Without this append, every
;; language Neovim does not ship queries for (rust, scala, clojure, yaml, json, ...)
;; runs with no highlighting at all (`vim.treesitter.query.get(lang, "highlights")` = nil).
(let [queries-dir (.. (vim.fn.stdpath :data) :/lazy/nvim-treesitter :/runtime)]
  (when (= 1 (vim.fn.isdirectory queries-dir))
    (vim.opt.runtimepath:append queries-dir)))

;; nvim-treesitter main dropped the `highlight` setup option -- it's silently ignored.
;; Highlighting now has to be started explicitly per buffer; pcall swallows the error
;; for filetypes without an installed parser. On a freshly installed parser the first
;; `FileType` firing can race the parser becoming available, so retry once on a defer
;; instead of leaving the buffer unhighlighted until a manual `:lua vim.treesitter.start()`.
(fn start-highlight []
  (when (not (pcall vim.treesitter.start))
    (vim.defer_fn (fn [] (pcall vim.treesitter.start)) 200)))

;; nvim-treesitter main also dropped `ensure_installed`/`auto_install`/`sync_install`
;; from `setup` -- passing them there is silently ignored too. Parsers now have to be
;; installed explicitly via `install`.
[{1 :nvim-treesitter/nvim-treesitter
  :lazy false
  :build ":TSUpdate"
   :config (fn []
            (let [treesitter (require :nvim-treesitter)]
              (treesitter.setup {})
              (treesitter.install ensure_installed)
              (autocmd :FileType
                       {:pattern "*"
                        :group (augroup :treesitter_highlight {:clear true})
                        :desc "Start treesitter highlighting when a parser is available"
                        :callback start-highlight}))) }
   {1 :nvim-treesitter/nvim-treesitter-context}
   ]

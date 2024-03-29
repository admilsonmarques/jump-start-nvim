(local ensure_installed 
;; A list of parser names, or "all"
       ["vimdoc" "javascript" "typescript" "c" "lua" "rust" "scala" "clojure" "norg" "markdown" "markdown_inline"])
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
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup opts))) }
   {1 :nvim-treesitter/playground }
   {1 :nvim-treesitter/nvim-treesitter-context}
   ]

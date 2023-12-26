(local opts {})
[{1 :JoosepAlviste/nvim-ts-context-commentstring
  :lazy false
  :config (fn []
            (let [commentstring (require :ts_context_commentstring)]
              (tset vim.g :skip_ts_context_commentstring_module true)
              (commentstring.setup {:enable_autocmd false})))}
 {1 :numToStr/Comment.nvim
  :lazy false
  :dependencies [:JoosepAlviste/nvim-ts-context-commentstring]
  :config (fn []
            (let [comment_nvim (require :Comment)
                  commentstring (require :ts_context_commentstring.integrations.comment_nvim)]
              (comment_nvim.setup {:pre_hook (commentstring.create_pre_hook)})))}]


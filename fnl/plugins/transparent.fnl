(local keys [{1 :<leader>Tt
              2 :<CMD>TransparentToggle<CR>
              :mode :n
              :desc :Transparency}])

;; transparent.nvim only clears a fixed list of highlight groups; plugins
;; that paint their own floating/terminal windows with a custom group (e.g.
;; sidekick's panel uses "SidekickChat") are invisible to it unless we add
;; that group explicitly.
(local extra-groups [:SidekickChat
                      :NvimTreeNormal
                      :NvimTreeNormalNC
                      :NvimTreeSignColumn
                      :NvimTreeEndOfBuffer])

(local cache-path (.. (vim.fn.stdpath :data) "/transparent_cache"))

[{1 :xiyaowong/transparent.nvim
  :lazy false
  : keys
  :config (fn []
            (let [transparent (require :transparent)]
              (transparent.setup {:extra_groups extra-groups})
              ;; default to transparent on first use only; once toggled,
              ;; transparent.nvim remembers your choice across restarts
              (when (= (vim.fn.filereadable cache-path) 0)
                (transparent.toggle true))))}]


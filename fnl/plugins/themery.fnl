;; Alguns colorschemes nao definem (ou herdam) o vim.o.background, e quem decide
;; a variante e o background atual ou um estado "preso" do plugin:
;;  - rose-pine / tokyonight / kanagawa simples seguem o background e viravam
;;    dawn / day / lotus ao vir de um tema claro;
;;  - rose-pine simples fica preso na ultima variante (dawn, moon...), entao
;;    tambem resetamos variant = auto;
;;  - kanagawa-wave/dragon/lotus nao ajustam o background;
;;  - catppuccin: ao recarregar o MESMO flavour com background diferente, ele
;;    ignora o pedido e escolhe pelo background (latte -> dracula -> latte
;;    carregava mocha).
;; Fixamos o background explicitamente em cada entrada.
(fn entry [name bg ?extra]
  {: name
   :colorscheme name
   :before (.. "vim.o.background = '" bg "'" (or ?extra ""))})

(local rose-pine-auto "; require('rose-pine').setup({variant = 'auto'})")

(local themes [(entry :rose-pine :dark rose-pine-auto)
               :rose-pine-moon
               :rose-pine-main
               (entry :tokyonight :dark)
               :tokyonight-night
               :tokyonight-storm
               :tokyonight-moon
               (entry :catppuccin-frappe :dark)
               (entry :catppuccin-macchiato :dark)
               (entry :catppuccin-mocha :dark)
               :dracula
               (entry :kanagawa :dark)
               (entry :kanagawa-wave :dark)
               (entry :kanagawa-dragon :dark)
               (entry :kanagawa-lotus :light)
               :rose-pine-dawn
               :tokyonight-day
               (entry :catppuccin-latte :light)
               :dracula-soft
               {:name "OneDark (dark)"
                :colorscheme :onedark
                :before "vim.o.background = 'dark'; require('onedark').setup({style = 'dark'})"}
               {:name "OneDark (light)"
                :colorscheme :onedark
                :before "vim.o.background = 'light'; require('onedark').setup({style = 'light'})"}
               :github_light
               :github_light_default
               :github_light_high_contrast
               :github_light_colorblind
               :github_light_tritanopia])

(local styles {:comments {:italic true}
               :keywords {:italic true}
               :functions {:bold true}
               :variables {:italic false}
               :sidebars :dark
               :floats :dark})

(local tokyonight-config
       {:style :moon
        : styles
        :transparent false
        :transparent_background true
        :dim_inactive true
        :terminal_colors true
        :on_highlights (fn [hl]
                         ;; cores pensadas p/ os estilos escuros
                         (when (= vim.o.background :dark)
                           (set hl.CursorLineNr {:fg "#99a0c7"})
                           (set hl.LineNr {:fg "#586085"})))})

(local keys 
       [{1 :<leader>TT 2 :<CMD>Themery<CR> :desc :Themery}])


[{1 :folke/tokyonight.nvim
  :lazy false
  :priority 1000
  :config (fn []
            (let [theme (require :tokyonight)]
              (theme.setup tokyonight-config)
              ;; O tokyonight guarda o estilo entre chamadas (tokyonight-night e depois
              ;; tokyonight ficava em night); reaplicamos a config base antes de
              ;; cada variante.
              (vim.api.nvim_create_autocmd :ColorSchemePre
                                           {:pattern :tokyonight*
                                            :callback (fn []
                                                        (theme.setup tokyonight-config))})))}
 {1 :rose-pine/neovim :name :rose-pine :lazy false :priority 1000}
 {1 :catppuccin/nvim :name :catppuccin :lazy false :priority 1000}
 {1 :Mofiqul/dracula.nvim :name :dracula :lazy false :priority 1000}
 {1 :rebelot/kanagawa.nvim :name :kanagawa :lazy false :priority 1000}
 {1 :navarasu/onedark.nvim :name :onedark :lazy false :priority 1000}
 {1 :projekt0n/github-nvim-theme :name :github :lazy false :priority 1000}
 {1 :zaldih/themery.nvim
  :lazy false
  : keys 
  :config (fn []
            (let [themery (require :themery)]
              (themery.setup {: themes
                              :livePreview true})))}]


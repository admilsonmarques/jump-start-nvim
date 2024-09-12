(local themes [:rose-pine
               :rose-pine-moon
               :rose-pine-main
               :tokyonight
               :tokyonight-night
               :tokyonight-storm
               :tokyonight-moon
               :catppuccin-frappe
               :catppuccin-macchiato
               :catppuccin-mocha
               :dracula
               :kanagawa
               :kanagawa-wave
               :kanagawa-dragon
               :kanagawa-lotus
               :rose-pine-dawn
               :tokyonight-day
               :catppuccin-latte
               :dracula-soft])

(local styles {:comments {:italic true}
               :keywords {:italic true}
               :functions {:bold true}
               :variables {:italic false}
               :sidebars :transparent
               :floats :transparent})

(local tokyonight-config
       {:style :moon
        : styles
        :transparent true
        :transparent_background true
        :dim_inactive true
        :terminal_colors true
        :on_highlights (fn [hl]
                         (set hl.CursorLineNr {:fg "#99a0c7"})
                         (set hl.LineNr {:fg "#586085"}))})

(local keys 
       [{1 :<leader>TT 2 :<CMD>Themery<CR> :desc :Themery}])

[{1 :folke/tokyonight.nvim
  :lazy false
  :priority 1000
  :config (fn []
            (let [theme (require :tokyonight)]
              (theme.setup tokyonight-config)))}
 {1 :rose-pine/neovim :name :rose-pine :lazy false :priority 1000}
 {1 :catppuccin/nvim :name :catppuccin :lazy false :priority 1000}
 {1 :Mofiqul/dracula.nvim :name :dracula :lazy false :priority 1000}
 {1 :rebelot/kanagawa.nvim :name :kanagawa :lazy false :priority 1000}
 {1 :zaldih/themery.nvim
  :lazy false
  : keys 
  :config (fn []
            (let [themery (require :themery)]
              (themery.setup {: themes
                              :livePreview true})))}]


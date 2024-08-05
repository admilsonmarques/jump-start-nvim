(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local icons (autoload :config.icons))

(local hl1 :String)
(local hl2 :Label)
(local hl3 :Statement)
(local hl4 :DevIconVim)

(local header {:type :group
               :val [{:type :text
                      :val ["                                     "
                            "      __                _            "
                            "   /\\ \\ \\___  ___/\\   /(_)_ __ ___   "
                            "  /  \\/ / _ \\/ _ \\ \\ / | | '_ ` _ \\  "
                            " / /\\  |  __| (_) \\ v /| | | | | | | "
                            " \\_\\ \\/ \\___|\\___/ \\_/ |_|_| |_| |_| "
                            "                                     "]
                      :opts {:position :center :hl hl4}}
                     {:type :text
                      :val (core.str (os.date))
                      :opts {:position :center :hl hl3}}]
               :opts {:hl hl2 :position :center}})

(local header2 {:type :group
                :val [{:type :terminal
                       :command "cat | pokemon-colorscripts --no-title -r 1,3,6"
                       :width 50
                       :height 15
                       :opts {:position :center :redraw true :hl hl3}}
                      {:type :text
                       :val (core.str (os.date))
                       :opts {:position :center :hl hl3}}]
                :opts {:hl hl2 :position :center}})

(fn quick_btn [theme]
  {:type :group
   :val [{:type :text :val "quick links" :opts {:hl hl1 :position :center}}
         {:type :padding :val 0}
         (theme.button :e (.. (core.get icons.ui :NewFile) "  new file")
                       :<cmd>ene!<cr>)
         (theme.button :f (.. (core.get icons.ui :FindFile) "  find file")
                       "<cmd>Telescope find_files<cr>")
         (theme.button :p (.. (core.get icons.ui :Project) "  projects")
                       "<cmd>Telescope projects<cr>")
         (theme.button :r (.. (core.get icons.ui :History) "  recent files")
                       "<cmd>Telescope oldfiles<cr>")
         (theme.button :t (.. (core.get icons.ui :FindText) "  find text")
                       "<cmd>Telescope live_grep<cr>")
         (theme.button :c (.. (core.get icons.ui :Gear) "  configuration")
                       "<cmd>edit ~/.config/jump-start-nvim/fnl/init.fnl<cr>")]
   :opts {:hl hl2 :position :center}})


(fn fortune_footer [fortune]
  {:type :text :val fortune :opts {:hl :Statement :position :center}})

(fn definitions [theme fortune]
  {:layout [{:type :padding :val 3}
            header
            {:type :padding :val 1}
            (quick_btn theme)
            {:type :padding :val 2}
            (fortune_footer fortune)
            {:type :padding :val 1}]
   :opts {:noautocmd false :redraw_on_resize true}})

(local keys [{1 "<leader>;" 2 :<CMD>Alpha<CR> :mode :n :desc :Home}])

[{1 :goolord/alpha-nvim
  :dependencies [:nvim-tree/nvim-web-devicons]
  :lazy false
  :config (fn []
            (let [alpha (require :alpha)
                  theme (require :alpha.themes.dashboard)
                  fortune (require :alpha.fortune)]
              (require :alpha.term)
              (alpha.setup (definitions theme fortune))))
  : keys}]


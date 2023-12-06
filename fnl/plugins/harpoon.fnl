
(fn get-list [] 
  (let [harpoon (require :harpoon)]
      (harpoon.list harpoon)))

(fn toggle-quick-menu [] 
  (let [harpoon (require :harpoon)
        list (harpoon.list harpoon)
        ui harpoon.ui]
      (ui.toggle_quick_menu ui list)))

(fn append []
  (let [list (get-list)] 
           (list.append list )))

(fn get-list-element [index]
  (let [list (get-list)] 
           (list.select list index)))

(local keys
       [{1 :<leader>ha 2 (fn [] (append)) :mode :n :desc "Append Harpoon"}
        {1 :<leader>hh 2 (fn [] (toggle-quick-menu)) :mode :n :desc "Harpoon Menu"}
        {1 :<leader>h1 2 (fn [] (get-list-element 1)) :mode :n :desc "Harpoon 1st"}
        {1 :<leader>h2 2 (fn [] (get-list-element 2)) :mode :n :desc "Harpoon 2nd"}
        {1 :<leader>h3 2 (fn [] (get-list-element 3)) :mode :n :desc "Harpoon 3rd"}
        {1 :<leader>h4 2 (fn [] (get-list-element 4)) :mode :n :desc "Harpoon 4th"}])

[{1 :ThePrimeagen/harpoon
:dependencies [:nvim-lua/plenary.nvim]
:branch :harpoon2
: keys
:config (fn []
          (let [harpoon (require :harpoon)]
            (harpoon.setup harpoon)))}]

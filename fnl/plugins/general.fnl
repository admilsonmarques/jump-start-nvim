(local work {:name :work :path "~/dev/ade/brain/work"})

(local personal {:name :personal :path "~/dev/ade/brain/personal"})

(local rpg {:name :rpg :path "~/dev/ade/brain/rpg"})

(local dynamic {:name :dynamic :path "~/dev/ade/brain/rpg"})

(local opts {:workspaces [personal work rpg]
             :notes_subdir :notes/general
             :daily_notes {:folder :notes/dailies
                           :date_format "%Y-%m-%d"
                           :template nil}
             :completion {:nvim_cpm true
                          :min_chars 2
                          :new_notes_location :current_dir
                          :preferred_link_style :markdown}})

[{1 :epwalsh/obsidian.nvim
  :version "*"
  :lazy true
  :ft :markdown
  :event :VeryLazy
  :dependencies [:nvim-lua/plenary.nvim]
  : opts}]


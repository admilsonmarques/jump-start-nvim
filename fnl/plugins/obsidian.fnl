(local work {:name :work :path "~/dev/ade/brain/work"})

(local personal {:name :personal :path "~/dev/ade/brain/personal"})

(local rpg {:name :rpg :path "~/dev/ade/brain/rpg"})

(local opts {:workspaces [work personal rpg]
             :notes_subdir :notes/general
             :daily_notes {:folder :notes/dailies
                           :date_format "%Y-%m-%d"
                           :template :daily.md}
             :templates {:subdir :templates :date_format "%Y-%m-%d"}
             :completion {:nvim_cpm true
                          :min_chars 2
                          :new_notes_location :current_dir
                          :preferred_link_style :markdown}})

(local keys ;find
       [{1 :go 2 :<cmd>ObsidianOpen<cr> :mode :n :desc :ObsidianOpen}
        {1 :gd 2 :<cmd>ObsidianFollowLink<cr> :mode :n :desc "Follow link"}
        {1 :<leader>oo 2 :<cmd>ObsidianOpen<cr> :mode :n :desc :ObsidianOpen}
        {1 :<leader>on 2 :<cmd>ObsidianNew<cr> :mode :n :desc "New note"}
        {1 :<leader>oq
         2 :<cmd>ObsidianQuickSwitch<cr>
         :mode :n
         :desc "Quick switch"}
        {1 :<leader>ok
         2 :<cmd>ObsidianFollowLink<cr>
         :mode :n
         :desc "Follow link"}
        {1 :<leader>oK
         2 "<cmd>ObsidianFollowLink vsplit<cr>"
         :mode :n
         :desc "Follow link split"}
        {1 :<leader>oj 2 :<cmd>ObsidianBacklinks<cr> :mode :n :desc :Backlinks}
        {1 :<leader>ot 2 ":ObsidianTags" :mode :n :desc :Tags}
        {1 :<leader>oT 2 ":ObsidianToday" :mode :n :desc :Backlinks}
        {1 :<leader>ol 2 ":ObsidianLinks" :mode :n :desc "Show Links"}])

[{1 :epwalsh/obsidian.nvim
  :version "*"
  :lazy true
  :ft :markdown
  :event :VeryLazy
  : keys
  :dependencies [:nvim-lua/plenary.nvim]
  : opts}]


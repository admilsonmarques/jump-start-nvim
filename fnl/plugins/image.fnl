(local integrations 
       [{:markdown {:enabled true
       :clear_in_insert_mode false
       :download_remote_images true
       :only_render_image_at_cursor false}}
       {:neorg {:enabled true}}
       {:html {:enabled true}}])

(local opts {:backend "kitty"
             :integrations integrations
             :max_width nil
             :max_height nil
             :max_width_window_percentage nil
             :max_height_window_percentage 50
             :window_overlap_clear_enabled false
             :window_overlap_clear_ft_ignore [:cmp_menu :cmp_docs ""]
})

[{1 :3rd/image.nvim
  :event :VeryLazy
  :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]
  : opts }]

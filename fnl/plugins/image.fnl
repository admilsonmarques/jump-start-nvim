(fn vault-root [file-path]
  (var current (vim.fn.fnamemodify file-path ":h"))
  (var root nil)
  (while (and (not root) (not= current "/"))
    (if (or (= (vim.fn.isdirectory (.. current "/.obsidian")) 1)
            (= (vim.fn.isdirectory (.. current "/.git")) 1))
        (set root current)
        (set current (vim.fn.fnamemodify current ":h"))))
  (or root (vim.fn.fnamemodify file-path ":h")))

(fn resolve-image-path [file-path url default-resolver]
  (if (or (url:match "^http")
          (url:match "^/")
          (url:match "^~")
          (url:match "^%./")
          (url:match "^%.%./"))
      (default-resolver file-path url)
      (let [root (vault-root file-path)]
        (vim.fn.fnamemodify (.. root "/" url) ":p"))))

(local integrations
       {:markdown {:enabled true
                   :clear_in_insert_mode false
                   :download_remote_images true
                   :only_render_image_at_cursor false
                   :resolve_image_path resolve-image-path}
        :neorg {:enabled true}
        :html {:enabled true}})

(local opts {:debug {:enabled true :level :debug :file_path "/tmp/image.nvim.log" :format :compact}
             :backend "kitty"
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

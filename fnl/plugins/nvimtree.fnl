(local {: augroup : autocmd : autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))


(local icons (autoload :config.icons))

(local diagnostics
       {:enable true
        :show_on_dirs false
        :icons {:hint (core.get-in icons.all [:diagnostics :BoldHint])
                :info (core.get-in icons.all [:diagnostics :BoldInformation])
                :warning (core.get-in icons.all [:diagnostics :BoldWarning])
                :error (core.get-in icons.all [:diagnostics :BoldError])}})

(local update_focused_file {:enable true :update_cwd true :ignore_list {}})

(local system_open {:cmd nil :args {}})

(local git {:enable true :ignore false :timeout 200})

(local view {:width 30
             ; :hide_root_folder false
             :side :left
             :adaptive_size true
             :number false
             :relativenumber false
             :signcolumn :yes})

(local renderer_indent_markers
       {:enable true :icons {:corner "└" :edge "│" :item "│" :none " "}})

(local renderer_icons
       {:webdev_colors true
        :show {:git true :folder true :file true :folder_arrow true}
        :glyphs {:default (core.get-in icons.all [:ui :Text])
                 :symlink (core.get-in icons.all [:ui :FileSymlink])
                 :git {:deleted (core.get-in icons.all [:git :FileDeleted])
                       :ignored (core.get-in icons.all [:git :FileIgnored])
                       :renamed (core.get-in icons.all [:git :FileRenamed])
                       :staged (core.get-in icons.all [:git :FileStaged])
                       :unmerged (core.get-in icons.all [:git :FileUnmerged])
                       :unstaged (core.get-in icons.all [:git :FileUnstaged])
                       :untracked (core.get-in icons.all [:git :FileUntracked])}
                 :folder {:default (core.get-in icons.all [:ui :Fodler])
                          :empty (core.get-in icons.all [:ui :EmptyFolder])
                          :empty_open (core.get-in icons.all
                                                   [:ui :EmptyFolderOpen])
                          :open (core.get-in icons.all [:ui :FolderOpen])
                          :symlink (core.get-in icons.all [:ui :FolderSymlink])}}})

(local renderer {:indent_markers renderer_indent_markers
                 :icons renderer_icons
                 :highlight_git true
                 :group_empty false
                 :root_folder_modifier ":t"})

(local filters {:dotfiles false
                :custom {1 :node_modules 2 "\\.cache"}
                :exclude {}})

(local trash {:cmd :trash :require_confirm true})

(local log {:enable false
            :truncate false
            :types {:all false
                    :config false
                    :copy_paste false
                    :diagnostics false
                    :git false
                    :profile false}})

(local actions_window_picker
       {:enable true
        :chars :ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
        :exclude {:filetype {1 :notify
                             2 :packer
                             3 :qf
                             4 :diff
                             5 :fugitive
                             6 :fugitiveblame}
                  :buftype {1 :nofile 2 :terminal 3 :help}}})

(local actions
       {:use_system_clipboard true
        :change_dir {:enable true :global true :restrict_above_cwd false}
        :open_file {:quit_on_open true
                    :resize_window false
                    :window_picker actions_window_picker}})

(local opts {:auto_reload_on_write true
             :hijack_directories {:enable true}
             :sync_root_with_cwd true
             :reload_on_bufenter true
             :respect_buf_cwd true
             :update_cwd true
             : diagnostics
             : update_focused_file
             : system_open
             : git
             : view
             : renderer
             : filters
             : trash
             : log
             : actions})

(fn bindings []
  (autocmd :FileType
           {:desc "Close folders on NvimTree with 'h'"
            :pattern [:NvimTree]
            :command "nnoremap <silent> h <cmd>lua nvim-tree-api.node.navigate.parent_close()<cr>"})
  (autocmd :FileType
           {:desc "Open folders on NvimTree with 'l' and files as preview (temporary buffer)"
            :pattern [:NvimTree]
            :command "nnoremap <silent> l <cmd>lua nvim-tree-api.node.navigate.preview()<cr>"}))

(local keys
       [{1 :<leader>e 2 :<cmd>NvimTreeToggle<CR> :mode :n :desc :NvimTree}])

;(local devicons-opts
;       {:override_by_extension {:fnl {:icon "🌜"
;                                     :color "#F3C13A"
;                                      :name :fennel}
;                                :.ignore {:icon ""
;                                          :color "#BE90D4"
;                                          :name :ignore}}})

[{1 :nvim-tree/nvim-web-devicons
  :config (fn []
            (let [devicons (require :nvim-web-devicons)]
              (devicons.setup {})))}
 {1 :kyazdani42/nvim-tree.lua
  :version "*"
  :lazy false
  :dependencies [:nvim-tree/nvim-web-devicons]
  : keys
  :config (fn []
            (let [tree (require :nvim-tree)]
              (tree.setup opts)))}]


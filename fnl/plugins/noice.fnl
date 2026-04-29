(local opts {;; Keep the floating cmdline you like
             :cmdline {:enabled true :view :cmdline_popup}
             :messages {:enabled true :view :notify}
             :lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                              :vim.lsp.util.stylize_markdown true
                              :cmp.entry.get_documentation true}}
             :presets {:bottom_search false
                       ;; Keep it floating!
                       :command_palette true
                       :long_message_to_split true}})

[{1 :folke/noice.nvim
  :event :VeryLazy
  : opts
  :dependencies [:MunifTanjim/nui.nvim]}]

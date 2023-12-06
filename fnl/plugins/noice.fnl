(local lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                       :vim.lsp.util.stylize_markdown true
                       :cmp.entry.get_documentation true}
            :hover {:enabled false}
            :signature {:enabled false}})

(local presets {:bottom_search true
                ;-- use a classic bottom cmdline for search
                :command_palette true
                ;-- position the cmdline and popupmenu together
                :long_message_to_split true
                ;-- long messages will be sent to a split
                :inc_rename false
                ;-- enables an input dialog for inc-rename.nvim
                :lsp_doc_border false
                ;-- add a border to hover docs and signature help
                })

(local opts {: lsp : presets})

(local keys [{1 :<leader>rn 2 :<CMD>Noice<CR> :mode :n :desc :Notifications}])

[{1 :folke/noice.nvim
  :event :VeryLazy
  :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]
  : keys
  :config (fn []
            (let [noice (require :noice)]
              (noice.setup opts)))}]


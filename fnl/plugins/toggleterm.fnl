(local float_opts
  {:border :curved
   :winblend 0})

(local opts
  {:size 20
   :open_mapping "<C-\\>"
   :hide_numbers true
   :start_in_insert true
   :insert_mappings true
   :persist_size false
   :direction :float
   : float_opts
   :shade_terminals false
   :shell vim.o.shell
   :close_on_exit true})

(local keys
  [{1 :<leader>tf
    2 "<cmd>ToggleTerm direction=float<CR>"
    :mode :n
    :desc "Float Terminal"}
   {1 :<leader>th
    2 "<cmd>ToggleTerm direction=horizontal<CR>"
    :mode :n
    :desc "Horizontal Terminal"}
   {1 :<leader>tv
    2 "<cmd>ToggleTerm direction=vertical<CR>"
    :mode :n
    :desc "Vertical Terminal"}
   {1 :<C-h> 2 "<Cmd>wincmd h<CR>" :desc "Move to the left window"  :mode :t}
   {1 :<C-j> 2 "<Cmd>wincmd j<CR>" :desc "Move to the below window" :mode :t}
   {1 :<C-k> 2 "<Cmd>wincmd k<CR>" :desc "Move to the above window" :mode :t}
   {1 :<C-l> 2 "<Cmd>wincmd l<CR>" :desc "Move to the right window" :mode :t}])

[{1 :akinsho/toggleterm.nvim
  :version "*"
  :lazy false
  :keys keys
  :opts opts}]

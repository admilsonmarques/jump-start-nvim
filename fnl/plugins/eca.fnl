(local opts {:behavior {:auto_start_server false
                        :auto_set_keymaps false
                        :auto_focus_sidebar false}})

(local keys
       [{1 :<leader>ac 2 :<cmd>EcaChat<cr> :desc "ECA Chat"}
        {1 :<leader>at 2 :<cmd>EcaToggle<cr> :desc "ECA Toggle"}
        {1 :<leader>af 2 :<cmd>EcaFocus<cr> :desc "ECA Focus"}
        {1 :<leader>ax 2 :<cmd>EcaClose<cr> :desc "ECA Close"}
        {1 :<leader>aaf 2 "<cmd>EcaAddFile  .. vim.fn.expand(\"%\") <cr>" :desc "ECA Add File as Context"}
        {1 :<leader>aas 2 :<cmd>EcaAddSelection<cr> :desc "ECA Add Selection as Context"}
        {1 :<leader>ass 2 :<cmd>EcaServerStart<cr> :desc "ECA Server Start"}
        {1 :<leader>asx 2 :<cmd>EcaServerStop<cr> :desc "ECA Server Stop"}
        {1 :<leader>asm 2 :<cmd>EcaChatSelectModel<cr> :desc "ECA Select Model"}
        {1 :<leader>asb 2 :<cmd>EcaChatSelectBehavior<cr> :desc "ECA Select Behavior"}])

[{1 :editor-code-assistant/eca-nvim
  :branch :context-improvements
  :dependencies [:nvim-lua/plenary.nvim :MunifTanjim/nui.nvim]
  : keys
  : opts
  :lazy false}]

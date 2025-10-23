-- [nfnl] fnl/plugins/eca.fnl
local opts = {behavior = {auto_start_server = true}}
local keys = {}
return {{"editor-code-assistant/eca-nvim", dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}, keys = keys, opts = opts, lazy = false}}

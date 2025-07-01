-- [nfnl] fnl/plugins/surround.fnl
local function _1_()
  local nvim_surround = require("nvim-surround")
  return nvim_surround.setup({})
end
return {{"kylechui/nvim-surround", version = "*", event = "VeryLazy", config = _1_}}

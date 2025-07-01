-- [nfnl] fnl/plugins/rainbow.fnl
local function _1_()
  local rainbow = require("rainbow-delimiters.setup")
  return rainbow.setup({})
end
return {{"HiPhish/rainbow-delimiters.nvim", config = _1_, lazy = false}}

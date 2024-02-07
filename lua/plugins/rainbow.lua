-- [nfnl] Compiled from fnl/plugins/rainbow.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local rainbow = require("rainbow-delimiters.setup")
  return rainbow.setup({})
end
return {{"HiPhish/rainbow-delimiters.nvim", config = _1_, lazy = false}}

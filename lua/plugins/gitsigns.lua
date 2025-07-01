-- [nfnl] fnl/plugins/gitsigns.fnl
local function _1_()
  local gitsigns = require("gitsigns")
  return gitsigns.setup({})
end
return {{"lewis6991/gitsigns.nvim", config = _1_, lazy = false}}

-- [nfnl] fnl/plugins/mcphub.fnl
local function _1_()
  local mcphub = require("mcphub")
  return mcphub.setup({})
end
return {{"ravitemer/mcphub.nvim", config = _1_}}

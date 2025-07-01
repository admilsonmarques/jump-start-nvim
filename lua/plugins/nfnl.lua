-- [nfnl] fnl/plugins/nfnl.fnl
local keys
local function _1_()
  local nfnl = require("nfnl.api")
  return nfnl["compile-all-files"]()
end
keys = {{"<leader>xr", _1_, mode = "n", desc = "Reload lua files"}}
return {{"olical/nfnl", keys = keys, lazy = false}}

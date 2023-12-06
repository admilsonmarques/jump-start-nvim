-- [nfnl] Compiled from fnl/plugins/nfnl.fnl by https://github.com/Olical/nfnl, do not edit.
local keys
local function _1_()
  local nfnl = require("nfnl.api")
  return nfnl["compile-all-files"]()
end
keys = {{"<leader>xr", _1_, mode = "n", desc = "Reload lua files"}}
return {{"olical/nfnl", keys = keys, lazy = false}}

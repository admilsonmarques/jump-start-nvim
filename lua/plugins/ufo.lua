-- [nfnl] Compiled from fnl/plugins/ufo.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("config.utils")
local lnoremap = _local_1_["lnoremap"]
local function bindings()
  lnoremap("n", "zR", "<cmd>lua require 'config.plugin.ufo'.openAllFolds()<cr>", "Open all folds")
  return lnoremap("n", "zM", "<cmd>lua require 'config.plugin.ufo'.closeAllFolds()<cr>", "Close all Folds")
end
local opts = {close_fold_kinds_for_ft = {"import", "comments"}, preview = {win_config = {border = {"", "-", "", "", "", "-", "", ""}, winhighlight = "Normal:Folded", winblend = 0}}, enable_get_fold_virt_text = true}
local function _2_()
  local ufo = require("ufo")
  bindings()
  return ufo.setup(opts)
end
return {{"kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"}, config = _2_, lazy = false}}

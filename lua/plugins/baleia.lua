-- [nfnl] fnl/plugins/baleia.fnl
local _local_1_ = require("config.utils")
local g = _local_1_["g"]
local autocmd = _local_1_["autocmd"]
local opts = {line_starts_at = 3}
local function _2_()
  local baleia = require("baleia")
  g("baleia", baleia.setup(opts))
  return autocmd("BufWinEnter", {desc = "ANSI colorize repl", pattern = {"conjure-log-*"}, command = "call g:baleia.automatically(bufnr('%'))"})
end
return {{"m00qek/baleia.nvim", init = _2_}}

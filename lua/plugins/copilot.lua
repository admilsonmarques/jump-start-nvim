-- [nfnl] fnl/plugins/copilot.fnl
local _local_1_ = require("config.utils")
local g = _local_1_.g
local opts = {panel = {enabled = false}, suggestion = {enabled = false}, filetypes = {"*", true}}
local function _2_()
  local copilot = require("copilot")
  return copilot.setup(opts)
end
return {{"zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter", config = _2_}}

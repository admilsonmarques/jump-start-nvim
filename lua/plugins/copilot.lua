-- [nfnl] fnl/plugins/copilot.fnl
local _local_1_ = require("config.utils")
local g = _local_1_["g"]
local opts = {panel = {["auto-refresh"] = true, keymap = {open = "<Space>gc", refresh = "gr"}}, suggestion = {auto_trigger = true, keymap = {accept = "<C-l>", dismiss = "<C-h>", next = "<C-k>", prev = "<C-j>"}}, filetypes = {"*", true}}
local function _2_()
  local copilot = require("copilot")
  return copilot.setup(opts)
end
return {{"zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter", config = _2_}}

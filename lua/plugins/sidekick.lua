-- [nfnl] fnl/plugins/sidekick.fnl
local opts = {nes = {enabled = false}, cli = {picker = "snacks", watch = true, win = {layout = "right", split = {width = 88}}, tools = {claude = {}, hermes = {cmd = {"hermes"}}}}}
local function toggle(name)
  local cli = require("sidekick.cli")
  return cli.toggle({name = name, focus = true})
end
local keys
local function _1_()
  return toggle("claude")
end
local function _2_()
  return toggle("hermes")
end
local function _3_()
  local cli = require("sidekick.cli")
  return cli.select({filter = {installed = true}})
end
local function _4_()
  local cli = require("sidekick.cli")
  return cli.close()
end
local function _5_()
  local cli = require("sidekick.cli")
  return cli.send({msg = "{file}"})
end
local function _6_()
  local cli = require("sidekick.cli")
  return cli.send({msg = "{selection}"})
end
local function _7_()
  local cli = require("sidekick.cli")
  return cli.prompt()
end
keys = {{"<leader>ac", _1_, mode = "n", desc = "Claude Code"}, {"<leader>ah", _2_, mode = "n", desc = "Hermes"}, {"<leader>as", _3_, mode = "n", desc = "Select CLI"}, {"<leader>ad", _4_, mode = "n", desc = "Detach CLI"}, {"<leader>af", _5_, mode = "n", desc = "Send File"}, {"<leader>av", _6_, mode = "x", desc = "Send Selection"}, {"<leader>ap", _7_, mode = {"n", "x"}, desc = "AI Prompts"}}
return {{"folke/sidekick.nvim", keys = keys, opts = opts}}

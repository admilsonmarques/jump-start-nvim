-- [nfnl] fnl/plugins/sidekick.fnl
local function panel_win()
  local found = nil
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if (not found and vim.w[w].sidekick_cli) then
      found = w
    else
    end
  end
  return found
end
local function resize_win(win, width)
  local cfg = vim.api.nvim_win_get_config(win)
  if ("" == cfg.relative) then
    return vim.api.nvim_win_set_width(win, width)
  else
    cfg["width"] = width
    return vim.api.nvim_win_set_config(win, cfg)
  end
end
local function toggle_max()
  local win = panel_win()
  if not win then
    return vim.notify("sidekick: painel nao esta aberto", vim.log.levels.WARN)
  else
    local cfg = vim.api.nvim_win_get_config(win)
    local float_3f = ("" ~= cfg.relative)
    local cur
    if float_3f then
      cur = cfg.width
    else
      cur = vim.api.nvim_win_get_width(win)
    end
    local max_w
    if float_3f then
      max_w = math.floor((vim.o.columns * 0.95))
    else
      max_w = vim.o.columns
    end
    local wvar = vim.w[win]
    if wvar.sidekick_maximized then
      wvar["sidekick_maximized"] = false
      return resize_win(win, (wvar.sidekick_prev_width or 88))
    else
      wvar["sidekick_prev_width"] = cur
      wvar["sidekick_maximized"] = true
      return resize_win(win, max_w)
    end
  end
end
local opts
local function _7_(_)
  return toggle_max()
end
opts = {nes = {enabled = false}, cli = {picker = "snacks", watch = true, win = {layout = "right", split = {width = 88}, keys = {fullscreen = {"<M-z>", _7_, mode = "nt", desc = "toggle fullscreen"}, hide_alt = {"<M-h>", "hide", mode = "nt", desc = "hide the panel"}}}, tools = {claude = {}, hermes = {cmd = {"hermes"}}}}}
local function toggle(name)
  local cli = require("sidekick.cli")
  return cli.toggle({name = name, focus = true})
end
local keys
local function _8_()
  return toggle("claude")
end
local function _9_()
  return toggle("hermes")
end
local function _10_()
  return toggle_max()
end
local function _11_()
  local cli = require("sidekick.cli")
  return cli.select({filter = {installed = true}})
end
local function _12_()
  local cli = require("sidekick.cli")
  return cli.close()
end
local function _13_()
  local cli = require("sidekick.cli")
  return cli.send({msg = "{file}"})
end
local function _14_()
  local cli = require("sidekick.cli")
  return cli.send({msg = "{selection}"})
end
local function _15_()
  local cli = require("sidekick.cli")
  return cli.prompt()
end
keys = {{"<leader>ac", _8_, mode = "n", desc = "Claude Code"}, {"<leader>ah", _9_, mode = "n", desc = "Hermes"}, {"<leader>az", _10_, mode = "n", desc = "AI Fullscreen"}, {"<leader>as", _11_, mode = "n", desc = "Select CLI"}, {"<leader>ad", _12_, mode = "n", desc = "Detach CLI"}, {"<leader>af", _13_, mode = "n", desc = "Send File"}, {"<leader>av", _14_, mode = "x", desc = "Send Selection"}, {"<leader>ap", _15_, mode = {"n", "x"}, desc = "AI Prompts"}}
return {{"folke/sidekick.nvim", keys = keys, opts = opts}}

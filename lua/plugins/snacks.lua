-- [nfnl] fnl/plugins/snacks.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local vim = _G.vim
local function dashboard_sections()
  local snacks = require("snacks")
  local in_git_3f = (nil ~= snacks.git.get_root())
  local cmds
  local function _2_()
    local snacks0 = require("snacks")
    return snacks0.picker.git_prs()
  end
  cmds = {{title = "My Work", cmd = "gh pr list --json title,number,updatedAt -L 10 | jq -r '.[] | \"#\" + (.number|tostring) + \" \" + .title + \" \" + (.updatedAt[0:10])'", action = _2_, key = "n", icon = "\239\144\135 ", height = 10}, {title = "Git Status", cmd = "git --no-pager diff --stat -B -M -C", height = 10}}
  local function _3_()
    return snacks.gitbrowse()
  end
  local function _4_(cmd)
    return core.merge({pane = 2, section = "terminal", enabled = in_git_3f, padding = 1, ttl = (5 * 60), indent = 3, random = 0}, cmd)
  end
  return {{section = "keys", gap = 1, padding = 1}, {section = "startup"}, {pane = 2, icon = "\238\156\137 ", desc = "Browse Repo", padding = 1, key = "b", action = _3_}, core.map(_4_, cmds)}
end
local function _5_()
  return dashboard_sections()
end
local function _6_()
  local snacks = require("snacks")
  return snacks.picker.files()
end
local function _7_()
  local snacks = require("snacks")
  return snacks.picker.projects()
end
local function _8_()
  local snacks = require("snacks")
  return snacks.dashboard.open()
end
return {"folke/snacks.nvim", priority = 1000, opts = {dashboard = {sections = _5_}, image = {enabled = true, max_width_window_percentage = 60, max_height_window_percentage = 20}, picker = {enabled = true, projects = {dirs = {"~/dev/ade", "~/dev/nu"}}, previewers = {image = {enabled = true, native_2d = true}}}, bigfile = {enabled = true}, indent = {enabled = true}, input = {enabled = false}, notifier = {enabled = false}, words = {enabled = false}}, keys = {{"<leader>ff", _6_, desc = "Find Files"}, {"<leader>fp", _7_, desc = "Projects"}, {"<leader>;", _8_, desc = "Open Dashboard"}}, lazy = false}

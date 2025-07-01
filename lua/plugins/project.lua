-- [nfnl] fnl/plugins/project.fnl
local opts = {detection_methods = {"pattern"}, patterns = {".git", ".nfnl.fnl", "src"}, ignore_lsp = {}, exclude_dirs = {}, show_hidden = true, silent_chdir = true, scope_chdir = "tab", update_focused_file = {enabled = true, update_cwd = true}, manual_mode = false}
local function _1_()
  local project = require("project_nvim")
  return project.setup(opts)
end
return {{"ahmedkhalf/project.nvim", lazy = true, config = _1_}}

-- [nfnl] Compiled from fnl/plugins/guard.fnl by https://github.com/Olical/nfnl, do not edit.
local keys = {{"<localleader>f", "<CMD>Guard fmt<CR>", mode = "n", desc = "Format"}}
local function _1_()
  local ft = require("guard.filetype")
  ft("python"):fmt("black")
  ft("fennel"):fmt("fnlfmt")
  ft("clojure"):fmt({cmd = "joker", args = {"--format", "-"}, stdin = true, ignore_error = true})
  ft("javascript,typescript,typescriptreact,css,scss,html,json,jsonc,yaml,markdown,graphql"):fmt({cmd = "prettier", args = {"--single-quote", "--write"}, fname = true}, "lint", "eslint")
  ft("scala,sbt"):fmt({cmd = "scalafmt", args = {"--quiet", "--stdin", "--assume-filename"}, stdin = true, fname = true})
  ft("bash,sh,zsh"):fmt("shfmt")
  vim.g["guard_config"] = {fmt_on_save = false, lsp_as_default_formatter = false}
  return nil
end
return {{"nvimdev/guard.nvim", dependencies = {"nvimdev/guard-collection"}, config = _1_, keys = keys}}

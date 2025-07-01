-- [nfnl] fnl/plugins/treesitter.fnl
local ensure_installed = {"vimdoc", "javascript", "typescript", "c", "lua", "rust", "scala", "clojure", "norg", "markdown", "markdown_inline"}
local opts = {ensure_installed = ensure_installed, auto_install = true, highlight = {enable = true, additional_vim_regex_highlighting = false}, sync_install = false}
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup(opts)
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_, lazy = false}, {"nvim-treesitter/playground"}, {"nvim-treesitter/nvim-treesitter-context"}}

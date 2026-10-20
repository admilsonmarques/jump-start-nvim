-- [nfnl] fnl/plugins/treesitter.fnl
local ensure_installed = {"javascript", "typescript", "rust", "scala", "clojure", "fennel", "bash", "regex", "css", "json", "xml", "yaml", "desktop", "gitignore", "hyprlang"}
do
  local queries_dir = (vim.fn.stdpath("data") .. "/lazy/nvim-treesitter" .. "/runtime")
  if (1 == vim.fn.isdirectory(queries_dir)) then
    vim.opt.runtimepath:append(queries_dir)
  else
  end
end
local opts = {ensure_installed = ensure_installed, auto_install = true, highlight = {enable = true, additional_vim_regex_highlighting = false}, sync_install = false}
local function _2_()
  local treesitter = require("nvim-treesitter")
  return treesitter.setup(opts)
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _2_, lazy = false}, {"nvim-treesitter/nvim-treesitter-context"}}

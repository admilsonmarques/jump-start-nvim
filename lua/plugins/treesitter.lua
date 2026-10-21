-- [nfnl] fnl/plugins/treesitter.fnl
local _local_1_ = require("config.utils")
local autocmd = _local_1_.autocmd
local augroup = _local_1_.augroup
local ensure_installed = {"javascript", "typescript", "rust", "scala", "clojure", "fennel", "bash", "regex", "css", "json", "xml", "yaml", "desktop", "gitignore", "hyprlang"}
do
  local queries_dir = (vim.fn.stdpath("data") .. "/lazy/nvim-treesitter" .. "/runtime")
  if (1 == vim.fn.isdirectory(queries_dir)) then
    vim.opt.runtimepath:append(queries_dir)
  else
  end
end
local function start_highlight()
  return pcall(vim.treesitter.start)
end
local function _3_()
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})
  treesitter.install(ensure_installed)
  return autocmd("FileType", {pattern = "*", group = augroup("treesitter_highlight", {clear = true}), desc = "Start treesitter highlighting when a parser is available", callback = start_highlight})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _3_, lazy = false}, {"nvim-treesitter/nvim-treesitter-context"}}

-- [nfnl] init.fnl
vim.g["mapleader"] = " "
vim.g["maplocalleader"] = ","
local lazypath = (vim.fn.stdpath("data") .. "/lazy")
local function ensure(user, repo)
  local install_path = string.format("%s/%s", lazypath, repo)
  if (vim.fn.empty(vim.fn.glob(install_path)) > 0) then
    vim.api.nvim_command(string.format("!git clone --filter=blob:none --single-branch https://github.com/%s/%s %s", user, repo, install_path))
  else
  end
  return vim.opt.runtimepath:prepend(install_path)
end
ensure("folke", "lazy.nvim")
ensure("Olical", "nfnl")
do
  local lazy = require("lazy")
  lazy.setup("plugins")
end
require("config.options")
require("config.keymaps")
require("config.autocmd")
return require("config.themes")

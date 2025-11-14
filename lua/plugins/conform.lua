-- [nfnl] fnl/plugins/conform.fnl
local keys
local function _1_()
  local conform = require("conform")
  return conform.format()
end
keys = {{"<localleader>f", _1_, mode = {"n", "v"}, desc = "Format buffer"}}
local function _2_()
  local conform = require("conform")
  return conform.setup({formatters = {fnlfmt = {command = "fnlfmt", args = {"-"}}, stylua = {command = "stylua", args = {"-"}}, black = {command = "black", args = {"-"}}, shfmt = {command = "shfmt"}, prettierd = {command = "prettierd", stdin = true, args = {"--single-quote", "--stdin-filepath", "$FILENAME"}}}, formatters_by_ft = {fennel = {"fnlfmt"}, lua = {"stylua"}, clojure = {"joker"}, python = {"black"}, sh = {"shfmt"}, javascript = {"prettierd"}, typescript = {"prettierd"}, typescriptreact = {"prettierd"}, css = {"prettierd"}, scss = {"prettierd"}, html = {"prettierd"}, json = {"prettierd"}, yaml = {"prettierd"}, markdown = {"prettierd"}}})
end
return {{"stevearc/conform.nvim", keys = keys, config = _2_, lazy = false}}

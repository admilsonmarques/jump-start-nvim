-- [nfnl] fnl/plugins/conform.fnl
local keys
local function _1_()
  return require("conform")("format")
end
keys = {{"<leader>f", _1_, mode = {"n", "v"}, desc = "Format buffer"}}
local function _2_()
  local conform = require("conform")
  return conform.setup({formatters = {zprint_justified = {command = "zprint", args = {"{:map {:style :justified} :width 100}"}}, fnlfmt = {command = "fnlfmt", args = {"-"}}, stylua = {command = "stylua", args = {"-"}}, black = {command = "black", args = {"-"}}, shfmt = {command = "shfmt"}, prettierd = {command = "prettierd"}}, formatters_by_ft = {fennel = {"fnlfmt"}, lua = {"stylua"}, clojure = {"zprint_justified"}, python = {"black"}, sh = {"shfmt"}, javascript = {"prettierd"}, typescript = {"prettierd"}, typescriptreact = {"prettierd"}, css = {"prettierd"}, scss = {"prettierd"}, html = {"prettierd"}, json = {"prettierd"}, yaml = {"prettierd"}, markdown = {"prettierd"}}, format_on_save = {timeout_ms = 500, lsp_fallback = true}})
end
return {{"stevearc/conform.nvim", keys = keys, config = _2_, lazy = false}}

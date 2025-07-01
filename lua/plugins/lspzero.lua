-- [nfnl] fnl/plugins/lspzero.fnl
local mason_opts = {ui = {border = "rounded", icons = {package_installed = "\226\156\147", package_pending = "\226\158\156", package_uninstalled = "\226\156\151"}}, max_concurrent_installers = 10}
local function _1_()
  vim.g["lsp_zero_extend_cmp"] = 0
  vim.g["lsp_zero_extend_lspconfig"] = 0
  return nil
end
local function _2_()
  local mason = require("mason")
  require("mason-lspconfig")
  return mason.setup(mason_opts)
end
local function _3_()
  local lsp_zero = require("lsp-zero")
  local mason_lspconfig = require("mason-lspconfig")
  lsp_zero.extend_lspconfig()
  local function _4_(client, bufnr)
    vim.keymap.set("n", "<leader>L", "<cmd>LspInfo<cr>", {desc = "LspInfo", buffer = bufnr})
    vim.keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<cr>", {desc = "Rename", buffer = bufnr})
    vim.keymap.set("n", "<localleader>D", "<cmd>lua vim.diagnostic.open_float()<cr>", {desc = "Float Diagnostic", buffer = bufnr})
    vim.keymap.set("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {desc = "Definition", buffer = bufnr})
    vim.keymap.set("n", "<localleader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", {desc = "Hover", buffer = bufnr})
    vim.keymap.set("n", "<localleader>h", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {desc = "Signature", buffer = bufnr})
    return vim.keymap.set("n", "<localleader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", {desc = "Action", buffer = bufnr})
  end
  lsp_zero.on_attach(_4_)
  local function _5_()
    local lua_opts = lsp_zero.nvim_lua_ls()
    local lspconfig = require("lspconfig")
    return lspconfig.lua_ls.setup(lua_opts)
  end
  local function _6_()
    local lspconfig = require("lspconfig")
    return lspconfig.fennel_language_server.setup({})
  end
  local function _7_()
    local lspconfig = require("lspconfig")
    return lspconfig.clojure_lsp.setup({})
  end
  local function _8_()
    local lspconfig = require("lspconfig")
    return lspconfig.jqls.setup({})
  end
  local function _9_()
    local lspconfig = require("lspconfig")
    return lspconfig.yamlls.setup({})
  end
  local function _10_()
    local lspconfig = require("lspconfig")
    return lspconfig.pyright.setup({})
  end
  local function _11_()
    local lspconfig = require("lspconfig")
    return lspconfig.ts_ls.setup({})
  end
  return mason_lspconfig.setup({ensure_installed = {"clojure_lsp", "ts_ls", "fennel_language_server", "lua_ls", "jqls", "yamlls", "pyright"}, handlers = {lsp_zero.default_setup(), lua_ls = _5_, fennel_language_server = _6_, clojure_lsp = _7_, jqls = _8_, yamlls = _9_, pyright = _10_, ts_ls = _11_}})
end
local function _12_()
  local copilot = require("copilot_cmp")
  return copilot.setup({})
end
local function _13_()
  local lsp_zero = require("lsp-zero")
  local cmp = require("cmp")
  local cmp_action = lsp_zero.cmp_action()
  lsp_zero.extend_cmp()
  return cmp.setup({formating = lsp_zero.cmp_format(), mapping = cmp.mapping.preset.insert({["<C-SPACE>"] = cmp.mapping.complete(), ["<C-i>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}), ["<C-u>"] = cmp.mapping.scroll_docs(-4), ["<C-d>"] = cmp.mapping.scroll_docs(4), ["<C-f>"] = cmp_action.luasnip_jump_forward(), ["<C-b>"] = cmp_action.luasnip_jump_backward()})})
end
return {{"VonHeikemen/lsp-zero.nvim", branch = "v3.x", lazy = true, init = _1_, config = false}, {"williamboman/mason.nvim", config = _2_, lazy = false}, {"neovim/nvim-lspconfig", cmd = {"LspInfo", "LspInstall", "LspStart"}, event = {"BufReadPre", "BufNewFile"}, dependencies = {"hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim"}, config = _3_}, {"williamboman/mason-lspconfig.nvim"}, {"zbirenbaum/copilot-cmp", config = _12_}, {"hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = {"L3MON4D3/LuaSnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "zbirenbaum/copilot-cmp", "rafamadriz/friendly-snippets"}, config = _13_}}

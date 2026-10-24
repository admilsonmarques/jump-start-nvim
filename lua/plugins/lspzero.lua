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
  local blink_cmp = require("blink.cmp")
  lsp_zero.extend_lspconfig()
  vim.diagnostic.config({virtual_text = {spacing = 4, source = "if_many", prefix = "\226\151\143"}, signs = true, underline = true, severity_sort = true, float = {border = "rounded", source = "always", header = "", prefix = ""}, update_in_insert = false})
  local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), blink_cmp.get_lsp_capabilities(), {textDocument = {foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}, completion = {completionItem = {snippetSupport = true, resolveSupport = {properties = {"documentation", "detail", "additionalTextEdits"}}}}}})
  local function _4_(client, bufnr)
    vim.keymap.set("n", "<leader>L", "<cmd>LspInfo<cr>", {desc = "LspInfo", buffer = bufnr})
    vim.keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<cr>", {desc = "Rename", buffer = bufnr})
    vim.keymap.set("n", "<localleader>D", "<cmd>lua vim.diagnostic.open_float()<cr>", {desc = "Float Diagnostic", buffer = bufnr})
    vim.keymap.set("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {desc = "Definition", buffer = bufnr})
    vim.keymap.set("n", "<localleader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", {desc = "Hover", buffer = bufnr})
    vim.keymap.set("n", "<localleader>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", {desc = "Toggle Inlay Hints", buffer = bufnr})
    vim.keymap.set("n", "<localleader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", {desc = "Action", buffer = bufnr})
    vim.keymap.set("n", "<localleader>r", "<cmd>lua vim.lsp.buf.references()<cr>", {desc = "References", buffer = bufnr})
    vim.keymap.set("n", "<localleader>i", "<cmd>lua vim.lsp.buf.implementation()<cr>", {desc = "Implementation", buffer = bufnr})
    vim.keymap.set("n", "<localleader>xx", "<cmd>Trouble diagnostics toggle<cr>", {desc = "Diagnostics (Trouble)"})
    return vim.keymap.set("n", "<localleader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {desc = "Buffer Diagnostics (Trouble)"})
  end
  lsp_zero.on_attach(_4_)
  local server_configs = {clojure_lsp = {cmd_env = {OTEL_SDK_DISABLED = "true"}, capabilities = {textDocument = {foldingRange = {formatting = false, rangeFormatting = false}}}}, lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false}, telemetry = {enable = false}}}}, ts_ls = {settings = {typescript = {inlayHints = {includeInlayParameterNameHints = "all", includeInlayFunctionParameterTypeHints = true, includeInlayVariableTypeHints = true, includeInlayPropertyDeclarationTypeHints = true, includeInlayFunctionLikeReturnTypeHints = true, includeInlayEnumMemberValueHints = true, includeInlayParameterNameHintsWhenArgumentMatchesName = false}}}}, pyright = {settings = {python = {analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace"}}}}, yamlls = {settings = {yaml = {schemas = {kubernetes = "*.yaml", ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*", ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}", ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}", ["http://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}", ["http://json.schemastore.org/circle-ci"] = ".circleci/**/*.{yml,yaml}"}}}}}
  local function _5_(server_name)
    local lspconfig = require("lspconfig")
    local server_config = server_configs[server_name]
    local final_config = vim.tbl_deep_extend("force", {capabilities = capabilities}, (server_config or {}))
    return lspconfig[server_name].setup(final_config)
  end
  local function _6_()
    local lua_opts = lsp_zero.nvim_lua_ls()
    local lspconfig = require("lspconfig")
    local enhanced_config = vim.tbl_deep_extend("force", lua_opts, {capabilities = capabilities}, server_configs.lua_ls)
    return lspconfig.lua_ls.setup(enhanced_config)
  end
  return mason_lspconfig.setup({ensure_installed = {"clojure_lsp", "ts_ls", "fennel_language_server", "lua_ls", "jqls", "yamlls", "pyright", "bashls", "jsonls", "cssls", "html", "marksman"}, handlers = {_5_, lua_ls = _6_}})
end
local function _7_()
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()
  return luasnip.config.setup({})
end
local function _8_()
  local blink = require("blink.cmp")
  return blink.setup({snippets = {preset = "luasnip"}, keymap = {preset = "none", ["<C-/>"] = {"show", "show_documentation", "hide_documentation"}, ["<CR>"] = {"accept", "fallback"}, ["<C-u>"] = {"scroll_documentation_up", "fallback"}, ["<C-d>"] = {"scroll_documentation_down", "fallback"}, ["<C-f>"] = {"snippet_forward", "fallback"}, ["<C-b>"] = {"snippet_backward", "fallback"}, ["<C-e>"] = {"cancel", "fallback"}, ["<C-n>"] = {"select_next", "fallback"}, ["<C-p>"] = {"select_prev", "fallback"}}, completion = {documentation = {auto_show = true}, menu = {border = "rounded"}, ghost_text = {enabled = false}}, sources = {default = {"lsp", "path", "snippets", "buffer", "copilot"}, providers = {copilot = {name = "copilot", module = "blink-cmp-copilot", score_offset = 100, async = true}}}})
end
return {{"VonHeikemen/lsp-zero.nvim", branch = "v3.x", lazy = true, init = _1_, config = false}, {"williamboman/mason.nvim", config = _2_, lazy = false}, {"neovim/nvim-lspconfig", cmd = {"LspInfo", "LspInstall", "LspStart"}, event = {"BufReadPre", "BufNewFile"}, dependencies = {"saghen/blink.cmp", "williamboman/mason-lspconfig.nvim"}, config = _3_}, {"L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp", dependencies = {"rafamadriz/friendly-snippets"}, config = _7_}, {"saghen/blink.cmp", version = "*", event = "InsertEnter", dependencies = {"L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets", "giuxtaposition/blink-cmp-copilot"}, config = _8_}}

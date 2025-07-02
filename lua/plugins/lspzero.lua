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
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  lsp_zero.extend_lspconfig()
  vim.diagnostic.config({virtual_text = {spacing = 4, source = "if_many", prefix = "\226\151\143"}, signs = true, underline = true, severity_sort = true, float = {border = "rounded", source = "always", header = "", prefix = ""}, update_in_insert = false})
  local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities(), {textDocument = {foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}, completion = {completionItem = {snippetSupport = true, resolveSupport = {properties = {"documentation", "detail", "additionalTextEdits"}}}}}})
  local function _4_(client, bufnr)
    if (client.server_capabilities and client.server_capabilities.semanticTokensProvider) then
      client.server_capabilities["semanticTokensProvider"] = nil
    else
    end
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
  local server_configs = {lua_ls = {settings = {Lua = {runtime = {version = "LuaJIT"}, diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false}, telemetry = {enable = false}}}}, ts_ls = {settings = {typescript = {inlayHints = {includeInlayParameterNameHints = "all", includeInlayFunctionParameterTypeHints = true, includeInlayVariableTypeHints = true, includeInlayPropertyDeclarationTypeHints = true, includeInlayFunctionLikeReturnTypeHints = true, includeInlayEnumMemberValueHints = true, includeInlayParameterNameHintsWhenArgumentMatchesName = false}}}}, pyright = {settings = {python = {analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace"}}}}, yamlls = {settings = {yaml = {schemas = {kubernetes = "*.yaml", ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*", ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}", ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}", ["http://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}", ["http://json.schemastore.org/circle-ci"] = ".circleci/**/*.{yml,yaml}"}}}}}
  local function _6_(server_name)
    local lspconfig = require("lspconfig")
    local server_config = server_configs[server_name]
    local final_config = vim.tbl_deep_extend("force", {capabilities = capabilities}, (server_config or {}))
    return lspconfig[server_name].setup(final_config)
  end
  local function _7_()
    local lua_opts = lsp_zero.nvim_lua_ls()
    local lspconfig = require("lspconfig")
    local enhanced_config = vim.tbl_deep_extend("force", lua_opts, {capabilities = capabilities}, server_configs.lua_ls)
    return lspconfig.lua_ls.setup(enhanced_config)
  end
  return mason_lspconfig.setup({ensure_installed = {"clojure_lsp", "ts_ls", "fennel_language_server", "lua_ls", "jqls", "yamlls", "pyright", "bashls", "jsonls", "cssls", "html", "marksman"}, handlers = {_6_, lua_ls = _7_}})
end
local function _8_()
  local copilot = require("copilot_cmp")
  return copilot.setup({})
end
local function _9_()
  local lsp_zero = require("lsp-zero")
  local cmp = require("cmp")
  local cmp_action = lsp_zero.cmp_action()
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode")
  luasnip.config.setup({})
  lsp_zero.extend_cmp()
  local function _10_(args)
    return luasnip.lsp_expand(args.body)
  end
  return cmp.setup({formatting = lsp_zero.cmp_format({details = true}), sources = cmp.config.sources({{name = "nvim_lsp", priority = 1000}, {name = "copilot", priority = 900}, {name = "luasnip", priority = 800}, {name = "buffer", priority = 500, keyword_length = 3}, {name = "path", priority = 400}}, {{name = "buffer", keyword_length = 3}}), snippet = {expand = _10_}, window = {completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered()}, mapping = cmp.mapping.preset.insert({["<C-SPACE>"] = cmp.mapping.complete(), ["<C-i>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}), ["<C-u>"] = cmp.mapping.scroll_docs(-4), ["<C-d>"] = cmp.mapping.scroll_docs(4), ["<C-f>"] = cmp_action.luasnip_jump_forward(), ["<C-b>"] = cmp_action.luasnip_jump_backward(), ["<C-e>"] = cmp.mapping.abort(), ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}), ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert})})})
end
return {{"VonHeikemen/lsp-zero.nvim", branch = "v3.x", lazy = true, init = _1_, config = false}, {"williamboman/mason.nvim", config = _2_, lazy = false}, {"neovim/nvim-lspconfig", cmd = {"LspInfo", "LspInstall", "LspStart"}, event = {"BufReadPre", "BufNewFile"}, dependencies = {"hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim"}, config = _3_}, {"zbirenbaum/copilot-cmp", config = _8_}, {"hrsh7th/nvim-cmp", event = "InsertEnter", dependencies = {"L3MON4D3/LuaSnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "zbirenbaum/copilot-cmp", "rafamadriz/friendly-snippets"}, config = _9_}}

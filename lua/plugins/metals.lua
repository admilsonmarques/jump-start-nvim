-- [nfnl] fnl/plugins/metals.fnl
local _local_1_ = require("config.utils")
local autocmd = _local_1_["autocmd"]
local augroup = _local_1_["augroup"]
local llmap = _local_1_["llmap"]
local function status_handler(err, status, ctx)
  local text = status.text:gsub("[\226\160\135\226\160\139\226\160\153\226\160\184\226\160\180\226\160\166]", ""):gsub("^%s*(.-)%s*$", "%1")
  local msg_val
  if status.hide then
    msg_val = {kind = "end"}
  elseif status.show then
    msg_val = {kind = "begin", title = text}
  elseif status.text then
    msg_val = {kind = "report", message = text}
  else
    msg_val = nil
  end
  local info = {client_id = ctx.client_id}
  local msg = {token = "metals", value = msg_val}
  if msg.value then
    return vim.lsp.handlers["$/progress"](err, msg, ctx)
  else
    return nil
  end
end
local metals_keys = {{"<localleader>I", "<cmd>lua require'metals'.organize_imports()<cr>", desc = "Organize Imports", ft = {"scala", "sbt", "sc"}}, {"<localleader>m", "<cmd>lua require'telescope'.extensions.metals.commands()<cr>", desc = "Metals Menu", ft = {"scala", "sbt", "sc"}}}
local metals_groups = {{"<localleader>m", group = "Metals", ft = {"scala", "sbt", "sc"}}}
local function _4_()
  local metals = require("metals")
  local metals_config = metals.bare_config()
  local nvim_metals_group = augroup("nvim-metals", {clear = true})
  metals_config["handlers"] = {["metals/status"] = status_handler}
  metals_config.init_options["statusBarProvider"] = "on"
  metals_config["settings"] = {showImplicitArguments = true, showImplicitConversionsAndClasses = true, showInferredType = true, serverVersion = "latest.snapshot", scalafixRulesDependencies = {"com.github.liancheng/scalafix-rules-dotty:0.1.6"}, serverProperties = {"-XX:+UseStringDeduplication", "-XX:MaxInlineLevel=20", "-XX:+UseParallelGC", "-Xmx10G", "-Xms2G"}, testUserInterface = "Test Explorer", enableSemanticHighlighting = false}
  require("cmp_nvim_lsp").default_capabilities()
  local function _5_(client, bufnr)
    return metals.setup_dap()
  end
  metals_config["on_attach"] = _5_
  local function _6_()
    return metals.initialize_or_attach(metals_config)
  end
  autocmd("FileType", {pattern = {"scala", "sbt", "sc"}, callback = _6_, group = nvim_metals_group})
  local function _7_()
    if pcall(require, "which-key") then
      local wk = require("which-key")
      return wk.add(metals_groups)
    else
      return nil
    end
  end
  return vim.schedule(_7_)
end
return {{"scalameta/nvim-metals", dependencies = {"nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", "nvim-lua/popup.nvim", "hrsh7th/cmp-nvim-lsp"}, keys = metals_keys, config = _4_}}

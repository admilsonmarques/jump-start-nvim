-- [nfnl] fnl/plugins/conjure.fnl
local _local_1_ = require("config.utils")
local g = _local_1_["g"]
local opt = _local_1_["opt"]
local autocmd = _local_1_["autocmd"]
local conjure_keys
local function _2_()
  if pcall(require, "telescope") then
    return vim.cmd("Telescope live_grep search_dirs=src/")
  else
    return nil
  end
end
local function _4_()
  if pcall(require, "telescope") then
    return vim.cmd("Telescope find_files search_dirs=src/")
  else
    return nil
  end
end
conjure_keys = {{"<localleader>cc", "<cmd>Lein!<cr><bar><cmd>ConjureLogVSplit<cr><bar><cmd>ConjureConnect<cr>", desc = "Jack-in Lein and Conjure"}, {"gd", "<cmd>ConjureDefWord<CR>", desc = "Go to Definition"}, {"<c-]>", "<cmd>ConjureDefWord<CR>", desc = "Go to Definition"}, {"K", "<cmd>ConjureDocWord<CR>", desc = "Show Documentation"}, {"gD", "<cmd>ConjureCljViewSource<CR>", desc = "View Source"}, {"<localleader>ee", "<cmd>ConjureEval<CR>", desc = "Evaluate Current Form"}, {"<localleader>er", "<cmd>ConjureEvalRootForm<CR>", desc = "Evaluate Root Form"}, {"<localleader>ef", "<cmd>ConjureEvalFile<CR>", desc = "Evaluate File"}, {"<localleader>eb", "<cmd>ConjureEvalBuf<CR>", desc = "Evaluate Buffer"}, {"<localleader>em", "<cmd>ConjureEvalMotion<CR>", desc = "Evaluate Motion"}, {"<localleader>tt", "<cmd>ConjureEvalCurrentTest<CR>", desc = "Test Current"}, {"<localleader>tn", "<cmd>ConjureTestRunNS<CR>", desc = "Test Namespace"}, {"<localleader>ta", "<cmd>ConjureTestRunAll<CR>", desc = "Test All"}, {"<localleader>tr", "<cmd>ConjureTestRefresh<CR>", desc = "Test Refresh"}, {"<localleader>ls", "<cmd>ConjureLogSplit<CR>", desc = "Log Split"}, {"<localleader>lv", "<cmd>ConjureLogVSplit<CR>", desc = "Log VSplit"}, {"<localleader>lt", "<cmd>ConjureLogTab<CR>", desc = "Log Tab"}, {"<localleader>lq", "<cmd>ConjureLogCloseVisible<CR>", desc = "Close Log"}, {"<localleader>lr", "<cmd>ConjureLogResetSoft<CR>", desc = "Log Reset Soft"}, {"<localleader>lR", "<cmd>ConjureLogResetHard<CR>", desc = "Log Reset Hard"}, {"<localleader>cn", "<cmd>ConjureConnect<CR>", desc = "Connect"}, {"<localleader>cd", "<cmd>ConjureDisconnect<CR>", desc = "Disconnect"}, {"<localleader>cs", "<cmd>ConjureStatus<CR>", desc = "Connection Status"}, {"<localleader>sp", _2_, desc = "Search Project"}, {"<localleader>sf", _4_, desc = "Search Files"}}
local conjure_groups = {{"<localleader>e", group = "Evaluate"}, {"<localleader>l", group = "Log"}, {"<localleader>c", group = "Connection"}, {"<localleader>t", group = "Test"}, {"<localleader>s", group = "Search"}}
local function ensure_repl_connection()
  local conjure_available = pcall(require, "conjure")
  if conjure_available then
    local function _6_()
      if (vim.fn.eval("conjure#client#get()") == "") then
        vim.notify("Starting REPL connection...", vim.log.levels.INFO)
        return vim.cmd("ConjureConnect")
      else
        return vim.notify("REPL already connected", vim.log.levels.INFO)
      end
    end
    return vim.schedule(_6_)
  else
    return nil
  end
end
local function safe_eval_with_feedback(command)
  local conjure_available = pcall(require, "conjure")
  if conjure_available then
    vim.notify("Evaluating...", vim.log.levels.INFO)
    return vim.cmd(command)
  else
    return vim.notify("Conjure not available", vim.log.levels.ERROR)
  end
end
local function _10_()
  g("conjure#eval#result_register", "*")
  g("conjure#log#botright", true)
  g("conjure#mapping#doc_word", "K")
  g("conjure#log#strip_ansi_escape_sequences_line_limit", 0)
  g("conjure#extract#tree_sitter#enabled", true)
  g("conjure#client#clojure#nrepl#connection#auto_repl#enabled", true)
  g("conjure#client#clojure#nrepl#connection#auto_repl#hidden", false)
  g("conjure#client#clojure#nrepl#connection#auto_repl#cmd", "Lein!")
  g("conjure#client#clojure#nrepl#eval#auto_require", true)
  g("conjure#client#clojure#nrepl#test#current_form_names", {"deftest", "defflow", "defspec", "defcheck"})
  g("conjure#client#clojure#nrepl#test#runner", "clojure")
  g("conjure#eval#result_register", "e")
  g("conjure#mapping#eval_root_form", "ef")
  g("conjure#mapping#eval_comment_root_form", "e;")
  g("conjure#mapping#eval_file", "el")
  g("conjure#log#hud#enabled", false)
  g("conjure#log#botright", true)
  g("conjure#log#wrap", true)
  g("conjure#log#fold#enabled", false)
  g("conjure#log#trim#at", 10000)
  g("conjure#extract#context_header_lines", 100)
  g("conjure#highlight#enabled", true)
  g("conjure#highlight#timeout", 500)
  g("conjure#client#fennel#aniseed#aniseed_module_prefix", "aniseed.")
  local function _11_()
    return pcall(vim.diagnostic.enable, false, {bufnr = 0})
  end
  autocmd("BufNewFile", {desc = "Conjure Log disable LSP diagnostics", callback = _11_, group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", {clear = true}), pattern = {"conjure-log-*"}})
  local function _12_()
    vim.bo.commentstring = ";; %s"
    return nil
  end
  autocmd("FileType", {desc = "Lisp style line comment", callback = _12_, group = vim.api.nvim_create_augroup("comment_config", {clear = true}), pattern = {"clojure"}})
  local function _13_()
    return vim.defer_fn(ensure_repl_connection, 1000)
  end
  autocmd("BufReadPost", {desc = "Auto-ensure REPL connection", pattern = {"*.clj", "*.cljs", "*.cljc", "*.fnl"}, callback = _13_, group = vim.api.nvim_create_augroup("conjure_auto_connect", {clear = true})})
  local function _14_()
    vim.opt_local.wrap(true)
    vim.opt_local.number(false)
    vim.opt_local.relativenumber(false)
    vim.opt_local.signcolumn("no")
    return vim.opt_local.cursorline(false)
  end
  autocmd("FileType", {desc = "Conjure log buffer optimizations", pattern = {"conjure-log"}, callback = _14_, group = vim.api.nvim_create_augroup("conjure_log_optimize", {clear = true})})
  local function _15_()
    if pcall(require, "which-key") then
      local wk = require("which-key")
      return wk.add(conjure_groups)
    else
      return nil
    end
  end
  return vim.schedule(_15_)
end
return {{"Olical/conjure", ft = {"clojure", "fennel", "clj"}, keys = conjure_keys, init = _10_}}

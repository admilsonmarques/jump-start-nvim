-- [nfnl] fnl/plugins/flowstorm.fnl
local _local_1_ = require("config.utils")
local autocmd = _local_1_["autocmd"]
local augroup = _local_1_["augroup"]
local flowstorm_keys = {{"<localleader>Fc", "<cmd>FlowStormConnect<cr>", desc = "FlowStorm Connect"}, {"<localleader>Fd", "<cmd>FlowStormDisconnect<cr>", desc = "FlowStorm Disconnect"}, {"<localleader>Fs", "<cmd>FlowStormStartRecording<cr>", desc = "Start Recording"}, {"<localleader>Fp", "<cmd>FlowStormStopRecording<cr>", desc = "Stop Recording"}, {"<localleader>Fr", "<cmd>FlowStormReset<cr>", desc = "Reset FlowStorm"}, {"<localleader>Fb", "<cmd>FlowStormBreakpoint<cr>", desc = "Toggle Breakpoint"}, {"<localleader>Fi", "<cmd>FlowStormInstrument<cr>", desc = "Instrument Form"}, {"<localleader>Fu", "<cmd>FlowStormUninstrument<cr>", desc = "Uninstrument Form"}}
local flowstorm_groups = {{"<localleader>F", group = "FlowStorm"}}
local function setup_flowstorm_commands()
  local function _2_()
    return vim.cmd("ConjureEval (do (require '[flow-storm.api :as fs-api]) (fs-api/local-connect))")
  end
  vim.api.nvim_create_user_command("FlowStormConnect", _2_, {desc = "Connect to FlowStorm debugger"})
  local function _3_()
    return vim.cmd("ConjureEval (flow-storm.api/stop)")
  end
  vim.api.nvim_create_user_command("FlowStormDisconnect", _3_, {desc = "Disconnect from FlowStorm debugger"})
  local function _4_()
    return vim.cmd("ConjureEval (flow-storm.api/start-recording)")
  end
  vim.api.nvim_create_user_command("FlowStormStartRecording", _4_, {desc = "Start FlowStorm recording"})
  local function _5_()
    return vim.cmd("ConjureEval (flow-storm.api/stop-recording)")
  end
  vim.api.nvim_create_user_command("FlowStormStopRecording", _5_, {desc = "Stop FlowStorm recording"})
  local function _6_()
    return vim.cmd("ConjureEval (flow-storm.api/reset)")
  end
  vim.api.nvim_create_user_command("FlowStormReset", _6_, {desc = "Reset FlowStorm"})
  local function _7_()
    return vim.cmd("ConjureEval #fs/trace")
  end
  vim.api.nvim_create_user_command("FlowStormBreakpoint", _7_, {desc = "Insert FlowStorm breakpoint at cursor"})
  local function _8_()
    return vim.cmd("ConjureEvalRootForm")
  end
  vim.api.nvim_create_user_command("FlowStormInstrument", _8_, {desc = "Instrument current form with FlowStorm"})
  local function _9_()
    return vim.cmd("ConjureEval (flow-storm.api/uninstrument-var (var current-form))")
  end
  return vim.api.nvim_create_user_command("FlowStormUninstrument", _9_, {desc = "Uninstrument current form"})
end
local function _10_()
  setup_flowstorm_commands()
  do
    local flowstorm_group = augroup("flowstorm-setup", {clear = true})
    local function _11_()
      return vim.notify("FlowStorm available! Use <localleader>Fc to connect", vim.log.levels.INFO, {title = "FlowStorm"})
    end
    autocmd("FileType", {pattern = {"clojure", "clojurescript", "clj", "cljs", "cljc"}, callback = _11_, group = flowstorm_group})
  end
  local function _12_()
    if pcall(require, "which-key") then
      local wk = require("which-key")
      return wk.add(flowstorm_groups)
    else
      return nil
    end
  end
  return vim.schedule(_12_)
end
return {{"jpmonettas/flow-storm-debugger", dependencies = {"Olical/conjure"}, ft = {"clojure", "clojurescript", "clj", "cljs", "cljc"}, keys = flowstorm_keys, config = _10_}}

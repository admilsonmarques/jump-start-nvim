-- [nfnl] fnl/config/autocmd.fnl
local _local_1_ = require("config.utils")
local autocmd = _local_1_.autocmd
local augroup = _local_1_.augroup
local function create_commands()
  local function _2_()
    return vim.cmd("ConjureEval (do (require '[flow-storm.api :as fs-api]) (fs-api/local-connect))")
  end
  vim.api.nvim_create_user_command("FlowStormConnect", _2_, {desc = "Connect to FlowStorm"})
  local function _3_()
    return vim.cmd("ConjureEval (flow-storm.api/stop)")
  end
  vim.api.nvim_create_user_command("FlowStormDisconnect", _3_, {desc = "Stop FlowStorm GUI (keeps REPL running)"})
  local function _4_()
    return vim.cmd("ConjureEval (do (flow-storm.api/stop) (System/exit 0))")
  end
  vim.api.nvim_create_user_command("FlowStormQuit", _4_, {desc = "Stop FlowStorm and kill the REPL process"})
  local function _5_()
    return vim.cmd("ConjureEval (flow-storm.api/start-recording)")
  end
  vim.api.nvim_create_user_command("FlowStormStartRecording", _5_, {desc = "Start FlowStorm recording"})
  local function _6_()
    return vim.cmd("ConjureEval (flow-storm.api/stop-recording)")
  end
  vim.api.nvim_create_user_command("FlowStormStopRecording", _6_, {desc = "Stop FlowStorm recording"})
  local function _7_()
    return vim.cmd("ConjureEval (flow-storm.api/reset)")
  end
  return vim.api.nvim_create_user_command("FlowStormReset", _7_, {desc = "Reset FlowStorm"})
end
local function create_keymaps()
  local opts = {silent = true, noremap = true, buffer = true}
  vim.keymap.set("n", "<localleader>Fc", "<cmd>FlowStormConnect<CR>", vim.tbl_extend("force", opts, {desc = "FlowStorm Connect"}))
  vim.keymap.set("n", "<localleader>Fd", "<cmd>FlowStormDisconnect<CR>", vim.tbl_extend("force", opts, {desc = "FlowStorm Disconnect"}))
  vim.keymap.set("n", "<localleader>Fq", "<cmd>FlowStormQuit<CR>", vim.tbl_extend("force", opts, {desc = "FlowStorm Quit (kill REPL)"}))
  vim.keymap.set("n", "<localleader>Fs", "<cmd>FlowStormStartRecording<CR>", vim.tbl_extend("force", opts, {desc = "FlowStorm Start Recording"}))
  vim.keymap.set("n", "<localleader>Fp", "<cmd>FlowStormStopRecording<CR>", vim.tbl_extend("force", opts, {desc = "FlowStorm Stop Recording"}))
  return vim.keymap.set("n", "<localleader>Fr", "<cmd>FlowStormReset<CR>", vim.tbl_extend("force", opts, {desc = "FlowStorm Reset"}))
end
create_commands()
local function _8_()
  create_keymaps()
  local function _9_()
    if pcall(require, "which-key") then
      return require("which-key").add({{"<localleader>F", group = "FlowStorm"}})
    else
      return nil
    end
  end
  return vim.schedule(_9_)
end
autocmd("FileType", {pattern = {"clojure", "clj", "cljs", "cljc"}, group = augroup("flowstorm", {clear = true}), desc = "Register FlowStorm keymaps for Clojure buffers", callback = _8_})
return {}

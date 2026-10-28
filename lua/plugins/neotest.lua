-- [nfnl] fnl/plugins/neotest.fnl
local function _1_()
  return require("neotest").run.run()
end
local function _2_()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _3_()
  return require("neotest").run.run(vim.fn.getcwd())
end
local function _4_()
  return require("neotest").run.run_last()
end
local function _5_()
  return require("neotest").output.open({enter = true})
end
local function _6_()
  return require("neotest").summary.toggle()
end
local neotest_keys = {{"<localleader>tt", _1_, desc = "Test Current"}, {"<localleader>tn", _2_, desc = "Test Namespace"}, {"<localleader>ta", _3_, desc = "Test All"}, {"<localleader>tr", _4_, desc = "Test Refresh"}, {"<localleader>to", _5_, desc = "Test Output"}, {"<localleader>ts", _6_, desc = "Test Summary"}}
local neotest_groups = {{"<localleader>t", group = "Test"}}
local function _7_()
  local neotest = require("neotest")
  neotest.setup({adapters = {require("neotest-jest")({}), require("neotest-go")({}), require("neotest-python")({}), require("neotest-plenary")}, output = {open_on_run = true}, quickfix = {open = false}})
  local function _8_()
    if pcall(require, "which-key") then
      local wk = require("which-key")
      return wk.add(neotest_groups)
    else
      return nil
    end
  end
  return vim.schedule(_8_)
end
return {{"nvim-neotest/neotest", ft = {"javascript", "typescript", "javascriptreact", "typescriptreact", "go", "python", "lua"}, dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-jest", "nvim-neotest/neotest-go", "nvim-neotest/neotest-python", "nvim-neotest/neotest-plenary"}, keys = neotest_keys, config = _7_}}

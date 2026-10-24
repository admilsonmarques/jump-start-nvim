-- [nfnl] fnl/plugins/gitsigns.fnl
local keys
local function _1_()
  if vim.wo.diff then
    return vim.cmd("normal! ]c")
  else
    return require("gitsigns").next_hunk()
  end
end
local function _3_()
  if vim.wo.diff then
    return vim.cmd("normal! [c")
  else
    return require("gitsigns").prev_hunk()
  end
end
keys = {{"]h", _1_, mode = "n", desc = "Next Hunk"}, {"[h", _3_, mode = "n", desc = "Prev Hunk"}, {"<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", mode = {"n", "v"}, desc = "Stage Hunk"}, {"<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", mode = {"n", "v"}, desc = "Reset Hunk"}, {"<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", mode = "n", desc = "Preview Hunk"}, {"<leader>hb", "<cmd>Gitsigns blame_line<CR>", mode = "n", desc = "Blame Line"}, {"<leader>hd", "<cmd>Gitsigns diffthis<CR>", mode = "n", desc = "Diff This"}}
local function _5_()
  local gitsigns = require("gitsigns")
  return gitsigns.setup({})
end
return {{"lewis6991/gitsigns.nvim", keys = keys, config = _5_, lazy = false}}

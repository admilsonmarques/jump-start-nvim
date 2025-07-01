-- [nfnl] fnl/plugins/comment.fnl
local opts = {}
local function _1_()
  local commentstring = require("ts_context_commentstring")
  vim.g["skip_ts_context_commentstring_module"] = true
  return commentstring.setup({enable_autocmd = false})
end
local function _2_()
  local comment_nvim = require("Comment")
  local commentstring = require("ts_context_commentstring.integrations.comment_nvim")
  return comment_nvim.setup({pre_hook = commentstring.create_pre_hook()})
end
return {{"JoosepAlviste/nvim-ts-context-commentstring", config = _1_, lazy = false}, {"numToStr/Comment.nvim", dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"}, config = _2_, lazy = false}}

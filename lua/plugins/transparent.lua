-- [nfnl] fnl/plugins/transparent.fnl
local keys = {{"<leader>Tt", "<CMD>TransparentToggle<CR>", mode = "n", desc = "Transparency"}}
local extra_groups = {"SidekickChat", "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeSignColumn", "NvimTreeEndOfBuffer"}
local cache_path = (vim.fn.stdpath("data") .. "/transparent_cache")
local function _1_()
  local transparent = require("transparent")
  transparent.setup({extra_groups = extra_groups})
  if (vim.fn.filereadable(cache_path) == 0) then
    return transparent.toggle(true)
  else
    return nil
  end
end
return {{"xiyaowong/transparent.nvim", keys = keys, config = _1_, lazy = false}}

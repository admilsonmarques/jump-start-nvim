-- [nfnl] fnl/plugins/obsidian.fnl
local md = {"markdown"}
local function _1_()
  local ok_3f, patch = pcall(require, "config.obsidian_patch")
  if ok_3f then
    return patch.apply()
  else
    return nil
  end
end
local function _3_(_, opts)
  for _0, k in ipairs({"heading", "bullet", "checkbox", "quote", "dash", "pipe_table", "code", "link", "latex", "indent", "inline_highlight"}) do
    opts[k] = {enabled = false}
  end
  opts.custom_handlers = (opts.custom_handlers or {})
  opts.custom_handlers["markdown"] = require("obsidian-query").handler
  opts.custom_handlers["markdown_inline"] = require("obsidian-query.inline").handler
  opts.win_options = {concealcursor = {default = "", rendered = "nc"}}
  return nil
end
local function _4_(_, opts)
  local oq = require("obsidian-query")
  local devicons = require("nvim-web-devicons")
  oq.setup(opts)
  do
    local ok_3f, rowclick = pcall(require, "config.obsidian_query_patch")
    if ok_3f then
      rowclick.apply()
    else
    end
  end
  return devicons.set_icon({dataview = {icon = "\243\176\187\186", color = "#6d8086", cterm_color = "66", name = "Dataview"}})
end
return {{"obsidian-nvim/obsidian.nvim", ft = md, dependencies = {"nvim-lua/plenary.nvim"}, init = _1_, opts = {picker = {name = "snacks.picker"}, workspaces = {{name = "rpg", path = "/home/adba/dev/ade/brain-rpg/duelo-de-drag\195\181es"}}, cache = {enabled = true}, ui = {enable = false}, legacy_commands = false}, version = false}, {"MeanderingProgrammer/render-markdown.nvim", ft = md, dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"}, opts = _3_}, {"dpezto/obsidian-query.nvim", ft = md, dependencies = {"obsidian.nvim", "render-markdown.nvim"}, opts = {picker = {style = "rich"}, max_inline_rows = math.huge}, config = _4_}}

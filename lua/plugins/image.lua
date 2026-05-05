-- [nfnl] fnl/plugins/image.fnl
local function vault_root(file_path)
  local current = vim.fn.fnamemodify(file_path, ":h")
  local root = nil
  while (not root and (current ~= "/")) do
    if ((vim.fn.isdirectory((current .. "/.obsidian")) == 1) or (vim.fn.isdirectory((current .. "/.git")) == 1)) then
      root = current
    else
      current = vim.fn.fnamemodify(current, ":h")
    end
  end
  return (root or vim.fn.fnamemodify(file_path, ":h"))
end
local function resolve_image_path(file_path, url, default_resolver)
  if (url:match("^http") or url:match("^/") or url:match("^~") or url:match("^%./") or url:match("^%.%./")) then
    return default_resolver(file_path, url)
  else
    local root = vault_root(file_path)
    return vim.fn.fnamemodify((root .. "/" .. url), ":p")
  end
end
local integrations = {markdown = {enabled = true, download_remote_images = true, resolve_image_path = resolve_image_path, clear_in_insert_mode = false, only_render_image_at_cursor = false}, neorg = {enabled = true}, html = {enabled = true}}
local opts = {debug = {enabled = true, level = "debug", file_path = "/tmp/image.nvim.log", format = "compact"}, backend = "kitty", integrations = integrations, max_width = nil, max_height = nil, max_width_window_percentage = nil, max_height_window_percentage = 50, window_overlap_clear_ft_ignore = {"cmp_menu", "cmp_docs", ""}, window_overlap_clear_enabled = false}
return {{"3rd/image.nvim", event = "VeryLazy", dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, opts = opts}}

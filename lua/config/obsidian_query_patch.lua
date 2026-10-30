-- Local patch for obsidian-query.nvim: clicking a rendered dataview TABLE row
-- opens that note with the mouse.
--
-- Upstream, obsidian-query.dataview.click only handles CALENDAR results (its
-- _clickmap is built by calendar_lines); for TABLE/LIST/TASK it returns false,
-- so the click falls through to "move the cursor". Since the result block is
-- virtual lines, the cursor can never sit on a row — which leaves the <CR>
-- picker as the only way into a page.
--
-- Table rows ARE addressable though: dataview/query.lua stores `path` on every
-- out_row, and dataview/render.lua lays the table out as
--   virt line 1 = top rule, 2 = header, 3 = middle rule, 4..N = data rows
-- so the row under a click is simply vidx - 3.
--
-- Wrapping the module function (instead of editing the plugin) keeps it
-- upgrade-safe; when upstream implements table clicks, drop this file.

local M = {}

local HEADER_LINES = 3

function M.apply()
  local ok, dv = pcall(require, "obsidian-query.dataview")
  if not ok or dv.__row_click_patched then
    return false
  end

  local orig = dv.click
  dv.click = function(result, vidx, col)
    if orig and orig(result, vidx, col) then
      return true -- calendar cells, month arrows
    end

    local data = result and result.ok and result.data
    if not (data and data.kind == "table" and data.rows) then
      return false
    end

    local row = data.rows[vidx - HEADER_LINES]
    local path = row and row.path
    if not path or path == "" then
      return false
    end

    vim.cmd("edit " .. vim.fn.fnameescape(path))
    return true
  end

  dv.__row_click_patched = true
  return true
end

return M

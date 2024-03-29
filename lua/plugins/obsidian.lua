-- [nfnl] Compiled from fnl/plugins/obsidian.fnl by https://github.com/Olical/nfnl, do not edit.
local work = {name = "work", path = "~/dev/ade/brain/work"}
local personal = {name = "personal", path = "~/dev/ade/brain/personal"}
local rpg = {name = "rpg", path = "~/dev/ade/brain/rpg"}
local dynamic = {name = "dynamic", path = "~/dev/ade/brain/rpg"}
local opts = {workspaces = {personal, work, rpg}, notes_subdir = "notes/general", daily_notes = {folder = "notes/dailies", date_format = "%Y-%m-%d", template = "templates"}, completion = {nvim_cpm = true, min_chars = 2, new_notes_location = "current_dir", preferred_link_style = "markdown"}}
local keys = {{"<leader>oo", "<cmd>ObsidianOpen<cr>", mode = "n", desc = "Open"}, {"<leader>on", "<cmd>ObsidianNew<cr>", mode = "n", desc = "New note"}, {"<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", mode = "n", desc = "Quick switch"}, {"<leader>ok", "<cmd>ObsidianFollowLink<cr>", mode = "n", desc = "Follow link"}, {"<leader>oK", "<cmd>ObsidianFollowLink vsplit<cr>", mode = "n", desc = "Follow link split"}, {"<leader>oj", "<cmd>ObsidianBacklinks<cr>", mode = "n", desc = "Backlinks"}, {"<leader>ot", ":ObsidianTags", mode = "n", desc = "Tags"}, {"<leader>oT", ":ObsidianToday", mode = "n", desc = "Backlinks"}, {"<leader>ol", ":ObsidianLinks", mode = "n", desc = "Show Links"}, {"<leader>ol", ":ObsidianLinks", mode = "n", desc = "Show Links"}}
return {{"epwalsh/obsidian.nvim", version = "*", lazy = true, ft = "markdown", event = "VeryLazy", keys = keys, dependencies = {"nvim-lua/plenary.nvim"}, opts = opts}}

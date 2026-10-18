return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>hc", "<CMD>Git commit<CR>", desc = "Commit staged changes" },
			{ "<leader>hG", "<CMD>Git<CR>", desc = "Open fugitive" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		keys = {
			"<leader>hh",
			"<leader>[h",
			"<leader>]h",
		},
		opts = {
			signs_staged = {
				add = { text = "┃+" },
				change = { text = "┃+" },
				delete = { text = "_+" },
				topdelete = { text = "‾+" },
				changedelete = { text = "~+" },
				untracked = { text = "┆+" },
			},
			numhl = true,
			on_attach = function(buf_number)
				local gitsigns = require("gitsigns")
				local function map(mode, key, command, desc)
					desc = desc or ""
					opts = {
						buffer = buf_number,
						desc = desc,
					}
					vim.keymap.set(mode, key, command, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, "Goto next hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, "Goto previous hunk")

				-- Actions
				map("n", "<leader>hh", gitsigns.stage_hunk, "Toggle stage hunk")
				map("n", "<leader>hr", gitsigns.reset_hunk, "Rollback hunk")

				map("v", "<leader>hh", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Toggle stage selection")

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset selection")

				map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
				map("n", "<leader>hR", gitsigns.reset_buffer, "Rollback buffer")
				map("n", "<leader>hp", gitsigns.preview_hunk_inline, "Preview hunk")
				map("n", "<leader>hP", gitsigns.preview_hunk, "Preview hunk inline")

				map("n", "<leader>hC", gitsigns.show_commit, "Show latest commit")

				map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, "Diff against HEAD")

				-- Toggles
				map("n", "<leader>hw", gitsigns.toggle_word_diff, "Show word diffs")

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
			end,
		},
	},
}

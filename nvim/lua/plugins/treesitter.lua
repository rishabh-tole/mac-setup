local selects = {
	["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
	["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
	["l="] = { query = "@assignment.lhs", desc = "Select lhs of an assignment" },
	["r="] = { query = "@assignment.rhs", desc = "Select rhs of an assignment" },

	["aa"] = { query = "@parameter.outer", desc = "Select outer part of an argument" },
	["ia"] = { query = "@parameter.inner", desc = "Select inner part of an argument" },

	["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
	["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

	["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
	["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

	["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
	["if"] = { query = "@function.inner", desc = "Select inner part of a function" },

	["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
	["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

	["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
	["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },

	["am"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
	["im"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
}
local swaps = {
	swap_next = {
		["<leader>cna"] = { query = "@parameter.inner", desc = "Swap with next argument" },
		["<leader>cnf"] = { query = "@function.outer", desc = "Swap with next function" },
		["<leader>cns"] = { query = "@statement.outer", desc = "Swap with next statement" },
	},
	swap_previous = {
		["<leader>cpa"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
		["<leader>cpf"] = { query = "@function.outer", desc = "Swap with previous function" },
		["<leader>cps"] = { query = "@statement.outer", desc = "Swap with previous statement" },
	},
}
local moves = {
	goto_next_start = {
		["]f"] = { query = "@function.outer", desc = "Goto start of next function" },
		["]c"] = { query = "@class.outer", desc = "Goto start of next class" },
		["]i"] = { query = "@conditional.outer", desc = "Goto start of next conditional" },
		["]l"] = { query = "@loop.outer", desc = "Goto start of next loop" },
		["]b"] = { query = "@block.outer", desc = "Goto start of next block" },
		["]v"] = { query = "@call.outer", desc = "Goto start of next invocation" },
	},
	goto_next_end = {
		["]F"] = { query = "@function.outer", desc = "Goto end of next function" },
		["]C"] = { query = "@class.outer", desc = "Goto end of next class" },
		["]I"] = { query = "@conditional.outer", desc = "Goto end of next conditional" },
		["]L"] = { query = "@loop.outer", desc = "Goto end of next loop" },
		["]B"] = { query = "@block.outer", desc = "Goto end of next block" },
		["]V"] = { query = "@call.outer", desc = "Goto end of next invocation" },
	},
	goto_previous_start = {
		["[f"] = { query = "@function.outer", desc = "Goto start of previous function" },
		["[c"] = { query = "@class.outer", desc = "Goto start of previous class" },
		["[i"] = { query = "@conditional.outer", desc = "Goto start of previous conditional" },
		["[l"] = { query = "@loop.outer", desc = "Goto start of previous loop" },
		["[b"] = { query = "@block.outer", desc = "Goto start of previous block" },
		["[v"] = { query = "@call.outer", desc = "Goto end of previous invocation" },
	},
	goto_previous_end = {
		["[F"] = { query = "@function.outer", desc = "Goto end of previous function" },
		["[C"] = { query = "@class.outer", desc = "Goto end of previous class" },
		["[I"] = { query = "@conditional.outer", desc = "Goto end of previous conditional" },
		["[L"] = { query = "@loop.outer", desc = "Goto end of previous loop" },
		["[B"] = { query = "@block.outer", desc = "Goto end of previous block" },
		["[V"] = { query = "@call.outer", desc = "Goto end of previous invocation" },
	},
}

-- Lazy-load the textobjects plugin on first use of any of its keymaps.
local textobject_keys = {}
for lhs, spec in pairs(selects) do
	table.insert(textobject_keys, { lhs, mode = { "x", "o" }, desc = spec.desc })
end
for _, maps in pairs(swaps) do
	for lhs, spec in pairs(maps) do
		table.insert(textobject_keys, { lhs, mode = "n", desc = spec.desc })
	end
end
for _, maps in pairs(moves) do
	for lhs, spec in pairs(maps) do
		table.insert(textobject_keys, { lhs, mode = { "n", "x", "o" }, desc = spec.desc })
	end
end
for _, lhs in ipairs({ ";", ",", "f", "F", "t", "T" }) do
	table.insert(textobject_keys, { lhs, mode = { "n", "x", "o" } })
end

return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = true,
		keys = textobject_keys,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local swap = require("nvim-treesitter-textobjects.swap")
			local move = require("nvim-treesitter-textobjects.move")

			for lhs, spec in pairs(selects) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(spec.query, "textobjects")
				end, { desc = spec.desc })
			end

			for fn, maps in pairs(swaps) do
				for lhs, spec in pairs(maps) do
					vim.keymap.set("n", lhs, function()
						swap[fn](spec.query)
					end, { desc = spec.desc })
				end
			end

			for fn, maps in pairs(moves) do
				for lhs, spec in pairs(maps) do
					vim.keymap.set({ "n", "x", "o" }, lhs, function()
						move[fn](spec.query, "textobjects")
					end, { desc = spec.desc })
				end
			end

			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate", -- Update all parsers when nvim-treesitter is updated.
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup()

			-- Installs only the parsers that are missing; runs asynchronously.
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"css",
				"csv",
				"dockerfile",
				"diff",
				"gitignore",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"latex",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			})

			-- Syntax highlighting. Silently skipped for filetypes without a parser.
			-- Treesitter indentation is intentionally not enabled: it is
			-- experimental and causes issues with markdown files.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
}

return {
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{
				"<C-e>",
				"<CMD>NvimTreeToggle<CR>",
				"Open file explorer",
			},
		},
		opts = {
			filters = {
				dotfiles = true,
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>ff",
				"<CMD>FzfLua files<CR>",
				"Find files",
			},
			{
				"<leader>fc",
				"<CMD>FzfLua git_commits<CR>",
				"Find commits",
			},
			{
				"<leader>fg",
				"<CMD>FzfLua live_grep<CR>",
				"Search in files",
			},
		},
		opts = {},
	},
}

-- ------------- Keymap Settings -------------
-- Set leader to space for easy access to subsequent keystrokes
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Helper function to make mapping easier.
function map(modes, key, action, desc)
	options = {
		desc = desc or "",
	}
	vim.api.nvim_set_keymap(modes, key, action, options)
end

-- Switch tabs using CTRL-l or CTRL-h
map("n", "<C-l>", "gt", "Go to next tab")
map("n", "<C-h>", "gT", "Go to previous tab")

-- Allow CTRL+j or CTRL+k to move a line/selection up or down.
map("n", "<C-j>", ":m+<CR>", "Move current line down")
map("n", "<C-k>", ":m-2<CR>", "Move current line up")
map("v", "<C-j>", ":m'>+<CR>gv=gv", "Move current selection down")
map("v", "<C-k>", ":m'<-2<CR>gv=gv", "Move current selection up")

if vim.g.loaded_netrw == 1 then
	-- Map CTRL+e to open the in-editor file browser if a plugin has not
	-- been defined to override netrw
	map("n", "<C-e>", "<ESC>:Lexplore<CR>", "Open file explorer")
end

-- " Map <leader>s to search for selected word
map("v", "<leader>s", 'y/<C-R>"<CR>', "Search for selected text")

-- " Map <leader>w to save all tabs
map("n", "<leader>w", "<ESC>:tabd w<CR>", "Save all tabs")

map("n", "<leader>sc", "<ESC>:nohl<CR>", "Clear search highlights")

-- Map <leader>r to run selected text/lines as a shell command
map("n", "<leader>r", "<ESC>:.w!zsh<CR>", "Execute line under cursor")
map("v", "<leader>r", "\"cy<ESC>:execute '!'@c<CR>", "Execute selected text")

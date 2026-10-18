-- ------------- General Options -------------
-- Set encoding to UTF-8 (default on nvim)
vim.opt.encoding = "utf-8"

-- Tab space : 4 Chars
vim.opt.ts = 4
vim.opt.shiftwidth = 4

-- Enable visual bell. Gets rid of the annoying beep when the <ESC> key is hit.
vim.opt.visualbell = true

-- When using tabs, replace with spaces
vim.opt.expandtab = true

-- End of line: $; Tab: |---
vim.opt.listchars = { eol = "$", tab = "|-" }

-- Show line numbers
vim.opt.number = true

-- Smart indenting, autoindenting
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Use clipboard as default register
vim.opt.clipboard:append("unnamedplus")

-- ------------- Text Wrapping/Width Markers -------------
-- Disable wrapping
vim.opt.wrap = false

-- If wrapping is enabled, break lines at end of words
vim.opt.linebreak = true

-- Show a column marker at the 81st column.
vim.opt.colorcolumn = "81,101"

-- Set max width to 80 characters
vim.opt.tw = 80

-- Enable automatic text wrapping at text width
vim.opt.fo:remove("l")
vim.opt.fo:append("t")

-- ------------- NeoVim inccommand settings -------------
vim.opt.inccommand = "nosplit"

-- ------------- Windows -------------
-- Set window splits to the right for vertical splits
vim.opt.splitright = true

-- ------------- Search -------------
-- Support incremental search.
vim.opt.incsearch = true

-- Always highlight all search result matches.
vim.opt.hlsearch = true

-- Support intelligent case sensitive search.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ------------- Theme -------------
if vim.opt.termguicolors then
	vim.opt.termguicolors = true
end

-- ------------- Status Bar -------------
-- Always show status bar
vim.opt.laststatus = 2

-- Show row,column on status bar
vim.opt.ruler = true

-- Enable wildcard menu
vim.opt.wildmenu = true

-- ------------- Backup File/Swap File Settings -------------
vim.opt.backupcopy = "yes"
vim.opt.writebackup = false

-- ------------- Netrw Settings -------------
vim.g.netrw_banner = false
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.netrw_preview = 1

-- Disable netrw so that nvim-tree can take over
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable syntax highlighting
vim.cmd("syntax enable")

-- Enable file type plugins
vim.cmd("filetype plugin indent on")

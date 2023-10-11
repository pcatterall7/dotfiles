-- Options
----------

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Use system clipboard
vim.o.clipboard = 'unnamedplus'

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- wrap text
vim.o.wrap = true

-- for linebreaks, break at spaces, not in the middle of words
vim.o.linebreak = true

-- tab = 4 spaces
vim.o.tabstop = 4

-- not sure
vim.o.softtabstop = 4

-- turn tabs to spaces
vim.o.expandtab = true

-- when indenting, use 4 spaces
vim.o.shiftwidth = 4



-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Undo
vim.opt.undofile = true

-- Visuals
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.linebreak = true     -- wrap at word boundaries, not mid-word
vim.opt.breakindent = true   -- keep wrapped lines visually indented
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Splits open naturally
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Misc
vim.opt.mouse = "a"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

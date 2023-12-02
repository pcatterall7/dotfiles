vim.g.mapleader = " " -- easy to reach leader key
vim.keymap.set("n", "-", vim.cmd.Ex) -- need nvim 0.8+

-- movement adjustments for wrap mode
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- start and end of line using H and L
vim.keymap.set('n', 'H', 'g0', {noremap = true, silent = true})
vim.keymap.set('n', 'L', 'g$', {noremap = true, silent = true})
vim.keymap.set('v', 'H', 'g0', {noremap = true, silent = true})
vim.keymap.set('v', 'L', 'g$', {noremap = true, silent = true})

-- remove highlighting after search using double esc
vim.keymap.set('n', '<esc><esc>', ':nohlsearch<CR>', {noremap = true, silent = false})

-- open markdown preview in marked 2 or using my `mdp` script to generate html 
-- than can be copied into google docs
vim.keymap.set('n', '<leader>mm', ':!open -a Marked\\ 2 %:p<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>mg', ':!mdp -c gd %:p<CR>', {noremap = true, silent = true})

-- remap keys used to jump between windows so that I don't have to use ctrl
vim.keymap.set('n', '<leader>h', '<C-W>h', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>j', '<C-W>j', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>k', '<C-W>k', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>l', '<C-W>l', {noremap = true, silent = true})

-- zenmode
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', {noremap = true, silent = true})

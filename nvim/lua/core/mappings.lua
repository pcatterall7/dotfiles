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

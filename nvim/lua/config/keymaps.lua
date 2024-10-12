-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- movement adjustments for wrap mode
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- start and end of line using H and L
vim.keymap.set("n", "H", "g0", { noremap = true, silent = true })
vim.keymap.set("n", "L", "g$", { noremap = true, silent = true })
vim.keymap.set("v", "H", "g0", { noremap = true, silent = true })
vim.keymap.set("v", "L", "g$", { noremap = true, silent = true })

-- remove highlighting after search using double esc
vim.keymap.set("n", "<esc><esc>", ":nohlsearch<CR>", { noremap = true, silent = false })

-- open markdown preview in marked 2 or using my `mdp` script to generate html
-- than can be copied into google docs
vim.keymap.set("n", "<leader>mm", ":!open -a Marked\\ 2 %:p<CR>", { noremap = true, silent = true })

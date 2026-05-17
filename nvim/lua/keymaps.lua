local map = vim.keymap.set

-- prevent space from doing its default action so leader mappings fire
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- j/k respect visual line wrapping
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- H/L for start/end of visual line
map({ "n", "v" }, "H", "g0", { noremap = true, silent = true })
map({ "n", "v" }, "L", "g$", { noremap = true, silent = true })

-- clear search highlight
map("n", "<esc><esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- toggle light/dark theme
map("n", "<leader>th", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd("colorscheme github_light")
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme tokyonight-night")
  end
end, { desc = "Toggle light/dark theme" })

-- window navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- save with Ctrl-S
map({ "n", "i", "v" }, "<C-s>", "<esc>:w<CR>", { noremap = true, silent = true })

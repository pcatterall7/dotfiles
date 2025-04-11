-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable concealing in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.conceallevel = 0 -- Turn off markup concealing
    vim.opt_local.tabstop = 4 -- Width of tab character
    vim.opt_local.shiftwidth = 4 -- Size of indent
    vim.opt_local.expandtab = false -- Use tabs, not spaces
    vim.opt_local.spell = false -- Turn off spellcheck
    -- vim.opt_local.softtabstop = 0 -- Disable soft tabs
  end,
})

-- left-align tables when converting from csv
-- https://github.com/SidOfc/mkdx#gmkdxsettingstablealign
vim.api.nvim_exec([[
let g:mkdx#settings = { 'table': { 'align': {
        \ 'default': 'left' } } }

]], false)

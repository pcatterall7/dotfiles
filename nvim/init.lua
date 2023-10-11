require("core.mappings")
require("core.options")
require("core.plugins")

-- need this to get markdown syntax highlighting to work automatically.
-- see: https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
-- vim.cmd([[
--   autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown
-- ]])
 vim.api.nvim_exec([[
   augroup MarkdownFileType
     autocmd!
     autocmd BufRead,BufNewFile *.md set syntax=markdown
   augroup END
 ]], false)



" everything here I found on https://dougblack.io/words/a-good-vimrc.html

let g:gruvbox_contrast_dark = 'medium'
syntax enable
colorscheme gruvbox
set background=dark    " Setting dark mode
set termguicolors      " Fixes the colors for gruvbox theme

" default tab settings
set tabstop=4 
set softtabstop=4
set expandtab

" taskpaper stuff
autocmd Filetype taskpaper setlocal ts=4 sw=4 noexpandtab " keep tabs when using tp
let g:task_paper_archive_project = "archive"
let g:task_paper_date_format = "%Y-%m-%d"

" for yaml, 2 spaces
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab  

set number
set wildmenu
set showcmd " shows key presses in the bottom corner

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

call plug#begin()

Plug 'cweagans/vim-taskpaper'   

call plug#end()


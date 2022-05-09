" everything here I found on https://dougblack.io/words/a-good-vimrc.html

call plug#begin()

Plug 'cweagans/vim-taskpaper'   
Plug 'dkarter/bullets.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdtree'
" Plug 'kyazdani42/nvim-web-devicons' " for file icons
" Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

"color theme
let g:gruvbox_contrast_dark = 'medium'
syntax enable
colorscheme gruvbox
set background=dark    " Setting dark mode
set termguicolors      " Fixes the colors for gruvbox theme

" general settings
set number
set relativenumber
set wildmenu
set showcmd " shows key presses in the bottom corner
set mouse=a
set wrap linebreak

" default tab settings
set tabstop=4 
set softtabstop=4
set expandtab
set shiftwidth=4

" taskpaper stuff
autocmd Filetype taskpaper setlocal ts=4 sw=4 noexpandtab " keep tabs when using tp
let g:task_paper_archive_project = "archive"
let g:task_paper_date_format = "%Y-%m-%d"
nmap gx :silent execute "!open " . shellescape("<cWORD>")<CR>

" for yaml, 2 spaces
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab  

" markdown stuff
let g:markdown_folding = 1
set nofoldenable
" enable better list support for markdown https://github.com/dkarter/bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch',
    \ 'taskpaper'
    \]
let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std-']


" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" set <space> to leader
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>


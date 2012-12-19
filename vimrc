filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
syntax on

set number
call pathogen#infect()
filetype plugin indent on
set hidden

set expandtab
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.hanldebars set filetype=html
au BufRead,BufNewFile *.ino set filetype=cpp
au BufRead,BufNewFile *.hamlc set filetype=haml
autocmd BufWritePre * :%s/\s\+$//e
set ruler
set rulerformat=%l,%c%V%=%P
set laststatus=2

set wildmenu
set wildmode=list:longest,list:full

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*./git/*

set sw=2 " no of spaces for indenting
set ts=2 " show \t as 2 spaces and treat 2 spaces as \t when deleting, etc..

colorscheme jellybeans

" Ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

" Leader
let mapleader = '\'

map <leader>w :w<cr>
map <leader>qq :q!<cr>
map <leader>q :q<cr>

map <leader>rm :Rmodel<space>

" Switch between split screens
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

map <leader>s :sp<cr>
map <leader>v :vs<cr>

" NerdTREE
nmap <leader>t :NERDTreeToggle<cr>
nmap <leader>f :NERDTreeFind<cr>

" Abbreviations
ab bpry binding.pry
ab spech require 'spec_helper'

" Mappings
nmap , $p

" Enable visualbell instead of sound
set vb


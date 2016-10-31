
" Vundle {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim'
Plugin 'fs111/pydoc.vim'
Plugin 'fatih/vim-go'
Plugin 'arturoescaip/related.vim'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'nelstrom/vim-visual-star-search'
call vundle#end()

"}}}

" Options {{{

filetype plugin indent on
set laststatus=2
set modeline
set modelines=1
set nocompatible
filetype plugin on
set autoread
set visualbell
set number
set showcmd
set ruler
set smartcase
set incsearch
set showmatch
set hlsearch
set mat=2
set expandtab
set shiftwidth=2
set tabstop=2
set history=1000
syntax enable

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

"}}}

" Mappings {{{

nnoremap <C-s> <Esc>:w<CR>
map <Space> :nohl<CR>

" Change windows quickly
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move through errors quickly
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" Make j,k work better on long lines
nnoremap j gj
nnoremap k gk

"}}}

" Abbrevs {{{

abbreviate pdb; import pdb; pdb.set_trace()

"}}}

" Auto commands {{{

autocmd! BufRead *.java set foldmethod=indent foldlevel=99
autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

"}}}

" Plugin config {{{

" vim-go config
let g:go_fmt_command = "goimports"

" youcomplete me
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:EclimCompletionMethod = 'omnifunc'

" related.vim
nnoremap <silent> <space>o :call related#switch(0)<CR>
nnoremap <silent> <space>O :call related#switch(1)<CR>

"}}}

" vim: foldmethod=marker foldlevel=0

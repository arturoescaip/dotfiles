" Vundle setup
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
call vundle#end()
filetype plugin indent on

set laststatus=2
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

" vim-go config
let g:go_fmt_command = "goimports"

abbreviate pdb; import pdb; pdb.set_trace()

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

" Load man plugin
runtime ftplugin/man.vim

" youcomplete me
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:EclimCompletionMethod = 'omnifunc'

" Perl support.
function! AddPerlBoilerPlate()
  let lines = [ "#" . "!/usr/bin/perl -w",
        \  "use strict;", "use feature 'say';", "" ]
  call append(0, lines)
endfunction
autocmd! BufNewFile *.pl call AddPerlBoilerPlate()

autocmd! BufRead *.pl 
      \ if getline(1) =~ 'perl6' |
      \   set ft=perl6 |
      \ endif

autocmd! BufRead,BufNewFile *.pl6 set ft=perl6

function! AddPerl6BoilerPlate()
  let lines = [ "#" . "!/usr/bin/env perl6", "" ]
  call append(0, lines)
  set ft=perl6
endfunction
autocmd! BufNewFile *.pl6 call AddPerl6BoilerPlate()

autocmd! BufRead *.java set foldmethod=indent foldlevel=99

autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

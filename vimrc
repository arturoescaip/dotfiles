call pathogen#infect()

if has("gui_running")
  set background=light
  colorscheme solarized
endif

let g:unite_enable_ignore_case=1

" For camel case
nnoremap <space>c :ToggleCamelCase<cr>

set mouse=a
set laststatus=2
nnoremap <C-s> <Esc>:w<CR>
map <Space> :nohl<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" Change windows quickly
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap \| :vsplit<cr>
nnoremap - :split<cr>

" Move through errors quickly
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

set statusline=[%n]\ %<%.99f\%h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\%l,%c-%v\ %)%P

if has('autocmd')
  filetype plugin indent on
endif

set modeline
set modelines=1
set nocompatible
filetype plugin on
set autoread
set visualbell
set mouse=a
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

" for tcomment
map <leader>c <C-_><C-_>

" For easy-motion
let g:EasyMotion_leader_key = '<Leader>'

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

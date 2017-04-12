
" Vundle {{{

set nocompatible
filetype off
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
call plug#begin('~/.plug')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'fs111/pydoc.vim'
Plug 'fatih/vim-go'
Plug 'arturoescaip/related.vim'
Plug 'nelstrom/vim-markdown-folding'
Plug 'nelstrom/vim-visual-star-search'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

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
set splitright
set splitbelow
syntax enable
let mapleader = "\<space>"

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

" Java
autocmd! BufRead *.java set foldmethod=indent foldlevel=99

" Go
autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4 tw=80 foldmethod=syntax foldlevel=99

autocmd! BufNewFile,BufRead *.py setlocal sw=4

"}}}

" Plugin config {{{

" vim-go config
let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1

" youcomplete me
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:EclimCompletionMethod = 'omnifunc'

" related.vim
nnoremap <silent> <leader>o :call related#switch(0)<CR>
nnoremap <silent> <leader>O :call related#switch(1)<CR>

" Tagbar golang support
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
nnoremap <silent> <leader>t :TagbarToggle<CR>

"}}}

" vim: foldmethod=marker foldlevel=0

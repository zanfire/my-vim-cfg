filetype off

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Theme
set t_Co=256


if has('gui_running')
  colorscheme Mustang
else
  colorscheme 3dglasses
endif

" Misc
set nowrap
set autowrite
set autoread
" Disable vi backward compatibility.
set nocompatible
set shortmess=atI

set encoding=utf-8
set scrolloff=3
" set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set list
set listchars=tab:▸\ ,eol:¬

" YankRing
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" Create an undo file. In this way when you close and re-open the same file
" you can perform undo.
" set undofile
 

" Status line
set laststatus=2
set statusline=%<%f\ %h%m%r%%=%-14.(%l,%c%V%)\ %P

" Line numbers.
set number
set numberwidth=4

" Tabs and indents
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ai "Auto indent
set si "Smart indent

" Spelling.
set spelllang=en
setlocal spell spelllang=en 

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" Moues configuration.
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


" Leater
let mapleader = ","

" Shortcuts
nnoremap <leader>i :FSHere<CR>
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>m :make<CR>
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>s :shell<CR>
nnoremap <leader>q :qall<CR>

" normal copy/paste
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
imap <C-v> <Esc>pi
imap <C-y> <Esc>ddi
map <C-z> <Esc>
imap <C-z> <Esc>ui


" Platform specific stuff
if has('macunix')
  set guifont=Monaco:h12.5
endif


filetype off

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Theme
set t_Co=256
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized

let g:airline_powerline_fonts = 1


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
set hlsearch
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
if exists("+relativenumber") 
  set relativenumber
endif
set list
set listchars=eol:¬
set listchars=tab:>-


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
"set spelllang=en
"setlocal spell spelllang=en 

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" Moues configuration.
set mouse=n
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


" Leater
let mapleader = ","

" Shortcuts
nnoremap <leader>i :FSHere<CR>
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>l :NERDTreeFind<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>b :BufExplorer<CR>
nnoremap <leader>o :CtrlP ./<CR>
nnoremap <leader>s :shell<CR>
nnoremap <leader>q :qall<CR>
nnoremap <leader>v :YRShow<CR>
nnoremap <leader>a "zyiw:exe "Ack ".@z.""<CR>

" Platform specific stuff
if has('macunix')
  set guifont=Monaco:h12.5
endif


set wildignore+=*/tmp/*,*.so,*.a,*.o,*.swp,*.lib,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|Vendors)$',
  \ 'file': '\v\.(exe|so|dll|o|a)$',
  \ }

set exrc " enable per-directory .vimrc files.
set secure " disable unsafe commands in local .vimrc files.

function AppendToFile(file, lines)
  call writefile(readfile(a:file)+a:lines, a:file)
endfunction


function! ClearBreakpoints()
  let cmd = '!cat /dev/null > ~/.gdb_breakpoints'
  echom 'Clearing breakpoints.'
  execute cmd
endfunction

function! ShowBreakpoint()
  let cmd = '!cat ~/.gdb_breakpoints'
  execute cmd
endfunction

function! SetBreakpoint()
  let b = $HOME . "/.gdb_breakpoints"
  let l=line('.')
  let f = expand('%:t')
  let cmd = '!echo break ' . f . ':' . l . ' >> ~/.gdb_breakpoints'
  let br = 'break ' . f . ':' . l
  "execute cmd
  let lines = [br]
  call AppendToFile(b, lines)
  echo br
endfunction

function! SetPrintBreakpoint()
  let b = $HOME . "/.gdb_breakpoints"
  let l=line('.')
  let f = expand('%:t')
  let cmd = '!echo break ' . f . ':' . l . ' >> ~/.gdb_breakpoints'
  let br = 'break ' . f . ':' . l
  "execute cmd
  let lines = [br, 'commands', "silent", "set pagination off", "printf \"----\\n\"", "info args", "info local", "bt", "printf \"----\\n\"",  "set pagination on", "cont", "end" ]
  call AppendToFile(b, lines)
endfunction

function! SetPrintHitBreakpoint()
  let b = $HOME . "/.gdb_breakpoints"
  let l=line('.')
  let f = expand('%:t')
  let cmd = '!echo break ' . f . ':' . l . ' >> ~/.gdb_breakpoints'
  let br = 'break ' . f . ':' . l
  "execute cmd
  let lines = [br, 'commands', "silent", "set pagination off", "printf \"----> \"", "bt 1" , "set pagination on", "cont", "end" ]
  call AppendToFile(b, lines)
endfunction



function! EditBreakpoints()
  let cmd = ':vsplit ~/.gdb_breakpoints'
  execute cmd
endfunction


command GdbSetBt :call SetBreakpoint()
command GdbSetPrintBt :call SetPrintBreakpoint()
command GdbSetBtPrintHit :call SetPrintHitBreakpoint()
command GdbEditBt :call EditBreakpoints()
command GdbClearBt :call ClearBreakpoints()
command GdbShowBt :call ShowBreakpoint()

function! MakeSession()
  let b:sessiondir = $PWD . "/.vim/sessions"
  exe "!mkdir -p .vim"
  let b:filename = b:sessiondir
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  if argc() == 0
    let b:sessiondir = $PWD . "/.vim/sessions"
    let b:sessionfile = b:sessiondir
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  endif
endfunction

function! ClearSession()
  let b:sessiondir = $PWD . "/.vim/sessions"
  let cmd = '!cat /dev/null > ' . b:sessiondir
  echom 'Clearing session.'
  execute cmd
endfunction



au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()

command SessionUpdate :call MakeSession()
command SessionClear :call ClearSession()
command SessionLoad :call ClearSession()

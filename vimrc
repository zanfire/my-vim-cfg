" Matteo Valdina vimrc.
"

" Pathogen load plugins.
execute pathogen#infect()
syntax on
filetype plugin indent on

let g:my_vim_dir=expand("$HOME/.vim")

"$HOME/.vim and $HOME/.vim/after are in the &rtp on unix
"But on windows, they need to be added.
if has("win16") || has("win32") || has("win64")
  "add g:my_vim_dir to the front of the runtimepath
   execute "set rtp^=".g:my_vim_dir
  "add g:my_vim_dir\after to the end of the runtimepath
  execute "set rtp+=".g:my_vim_dir."\\after"
  "Note, pathogen#infect() looks for the 'bundle' folder in each path
  "of the &rtp, where the last dir in the '&rtp path' is not 'after'. The
  "<path>\bundle\*\after folders will be added if and only if
  "the corresponding <path>\after folder is in the &rtp before
  "pathogen#infect() is called.  So it is very important to add the above
  "'after' folder.
  "(This applies to vim plugins such as snipmate, tabularize, etc.. that
  " are loaded by pathogen (and perhaps vundle too.))

  " Not necessary, but I like to cleanup &rtp to use \ instead of /
  " when on windows machines
  let &rtp=substitute(&rtp,"[/]","\\","g")

  "On windows, if called from cygwin or msys, the shell needs to be changed 
  "to cmd.exe to work with certain plugins that expect cmd.exe on windows versions   
  "of vim.
  if &shell=~#'bash$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
  endif
else

endif

" Theme
set t_Co=256
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
set background=dark
colorscheme solarized

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

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
set listchars=eol:¬,tab:··
set tags=./tagsk
syntax on

set shell=/bin/zsh

" Create an undo file. In this way when you close and re-open the same file
" you can perform undo.
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" " Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif

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

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
nnoremap <leader>a "zyiw:exe "Ack ".@z.""<CR>

" Platform specific stuff
set guifont=PragmataPro\ Mono

  " set guifont=Monaco:h12.5
  "set guifont=Consolas\ for\ Powerline:h9.5
  "set guifont=Powerline\ Consolas:h12.

if has("win16") || has("win32") || has("win64")
  set guifont=Inconsolata\ for\ Powerline:h12.5
  "set guifont=Powerline\ Consolasc:h12.5
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
  let b:sessiondir = $HOME . "/.vim/sessions" . $PWD
  exe "!mkdir -p " . b:sessiondir
  let b:filename = b:sessiondir . "/session"
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  if argc() == 0
    let b:sessiondir = $HOME . "/.vim/sessions" . $PWD
    let b:sessionfile = b:sessiondir . "/session"
    if (filereadable(b:sessionfile))
      exe "source " . b:sessionfile
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

" Platform specific stuff
if has('unix')
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession()
  command SessionUpdate :call MakeSession()
  command SessionClear :call ClearSession()
  command SessionLoad :call ClearSession()
endif

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
"
" " Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
"
" " Default: 0.5
" let g:limelight_default_coefficient = 0.7
"
" " Number of preceding/following paragraphs to include (default: 0)
" let g:limelight_paragraph_span = 1
"
" " Beginning/end of paragraph
" "   When there's no empty line between the paragraphs
" "   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'
"
" " Highlighting priority (default: 10)
" "   Set it to -1 not to overrule hlsearch
" let g:limelight_priority = -1


" Disable arrow keys
noremap <Up> :copen<CR>
noremap <Down> :cclose<CR>
noremap <Left> :bprevious<CR>
noremap <Right> :bnext<CR>

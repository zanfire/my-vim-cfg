" Matteo Valdina vimrc.
"

let g:my_vim_dir=expand("$HOME/.vim")

"$HOME/.vim and $HOME/.vim/after are in the &rtp on unix
"But on windows, they need to be added.
"add g:my_vim_dir to the front of the runtimepath
execute "set rtp^=".g:my_vim_dir
"add g:my_vim_dir\after to the end of the runtimepath
execute "set rtp+=".g:my_vim_dir."\\after"

if has("win16") || has("win32") || has("win64")
  " Not necessary, but I like to cleanup &rtp to use \ instead of /
  " when on windows machines
  let &rtp=substitute(&rtp,"[/]","\\","g")

  "On windows, if called from cygwin or msys, the shell needs to be changed 
  "to cmd.exe to work with certain plugins that expect cmd.exe on windows versions   
  "of vim.
  if &shell=~#'bash$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
  endif
endif

" Pathogen load plugins.
execute pathogen#infect()
syntax on
filetype plugin indent on


" Theme
"set t_Co=256
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"
"set background=dark
"colorscheme solarized8
colorscheme molokai

" Airline
let g:airline#extensions#tabline#enabled = 1
if has("win16") || has("win32") || has("win64")
  let g:airline_powerline_fonts = 0
else
  let g:airline_powerline_fonts = 0
endif
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" vim-gutentags
" Enabled in project .vimrc
let g:gutentags_enabled = 0

" asyncrun
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git']

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
set colorcolumn=120
set backspace=indent,eol,start
if exists("+relativenumber") 
  set relativenumber
endif
set list
set listchars=eol:¬,tab:··
set tags=./tags
syntax on


if has("win16") || has("win32") || has("win64")
else
  set shell=/bin/zsh
endif

" Create an undo file. In this way when you close and re-open the same file
" you can perform undo.
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
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
nnoremap <leader>s :shell<CR>
nnoremap <leader>q :qall<CR>
nnoremap <leader>e :Files<CR>
nnoremap <leader>a "zyiw:exe "Ack! ".@z.""<CR>

let wildignore = '*/tmp/*,*/node_modules/*,*/dist/*,*/build/*,*.so,*.a,*.o,*.swp,*.lib,*.zip,*/web-static/*'
" Configure ack to use rg the siver searcher
let g:ackprg = 'rg --ignore "' . wildignore . '" --nocolor --column'

cnoreabbrev Ack Ack!

" Platform specific stuff
set guifont=PragmataPro\ Mono

"set guifont=Monaco:h12.5
"set guifont=Consolas\ for\ Powerline:h9.5
"set guifont=Powerline\ Consolas:h12.

if has("win16") || has("win32") || has("win64")
  set guifont=PragmataPro\ Mono:h12.5
  " set guifont=Inconsolata\ for\ Powerline:h12.5
  "set guifont=Powerline\ Consolasc:h12.5
endif

set wildignore+=wildignore

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|o|a|lib|node)$',
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
"noremap <Up> :CtrlPCurWD<CR>
"nnoremap <Down> :call asyncrun#quickfix_toggle(6)<cr>
noremap <Up> <NOP>
nnoremap <Down> <NOP>
noremap <Left> :bprevious<CR>
noremap <Right> :bnext<CR>

" Typescript configurations and addition.
let g:ale_completion_enabled = 1

" Tagbar
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
  \ }


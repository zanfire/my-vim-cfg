" Theme
set t_Co=256

colorscheme 3dglasses
"colorscheme aiseeredvi
"colorscheme xoria256


" Misc
set nowrap
set autowrite
set autoread

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
setlocal spell spelllang=en_us 

" Shortcuts
map <F2> :NERDTreeToggle<CR>
map <F5> :make<CR>
map <F6> :cn<CR>

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Moues configuration.
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


:colorscheme Dark
:set nowrap
:set autowrite
:set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
:set number
:set numberwidth=3
:set spelllang=en
:set expandtab
:set tabstop=2
:set softtabstop=2
:set shiftwidth=2
:set mouse=a
:setlocal spell spelllang=en_us 

map <F2> :NERDTreeToggle<CR>
map <F5> :mak -C build

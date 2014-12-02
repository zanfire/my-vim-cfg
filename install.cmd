@echo off
REM Install script of my-vim-cfg for windows.
REM 

mklink /D C:\Users\Matteo\.vim C:\Users\Matteo\Documents\GitHub\my-vim-cfg
mklink C:\Users\Matteo\_vimrc C:\Users\Matteo\Documents\GitHub\my-vim-cfg\vimrc
echo "Done."

pause
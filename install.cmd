@echo off
REM Install script of my-vim-cfg for windows.

SET DIR=%~dp0
mklink /D %USERPROFILE%\.vim %DIR:~0,-1%
mklink %USERPROFILE%\_vimrc %DIR%\vimrc
echo "Done."

pause
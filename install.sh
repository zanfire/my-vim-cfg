#!/bin/bash
#
# Script that install the checkout as a configuration of vi.
# Author: Matteo Valdina

echo "-------------------------"
echo "| INSTALL script        |"
echo "-------------------------"
echo " "
echo "This script will substitute .vim folder and .vimrc file with this configuration file and plugins collection."
echo " "

read -p "Are you sure? (Y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] ; then
  echo " ..."
else
  echo "Exit from script."
  echo " "
  exit
fi


# Get install.sh directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VIMRC=~/.vimrc
VIMDIR=~/.vim

# Check if .vimrc folder exists and ask if to be deleted or to be moved.
if [ -e "$VIMRC" ] ; then
  rm -i "$VIMRC"
  if [ -e "$VIMRC" ] ; then
    echo "Install script aborted."
    exit
  fi
fi

# Check if .vim folder exists and ask if to be deleted or to be moved.
if [ -e "$VIMDIR" ] ; then
  rm -IR "$VIMDIR"
  if [ -e "$VIMRC" ] ; then
    echo "Install script aborted."
    exit
  fi
fi

echo " ... "


pushd ~ > /dev/null
ln -s $DIR/vimrc .vimrc
echo "Linking $DIR/vimrc <- ~/.vimrc"
ln -s $DIR .vim
echo "Linking $DIR <- ~/.vim"
popd > /dev/null

echo " "
echo "Done."


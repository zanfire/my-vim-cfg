#!/bin/bash
#
# Script that install the checkout as a configuration of vi.
# Author: Matteo Valdina

echo This scripts will substitute .vim folder and .vimrc file with this configuration file and plugins collection.

# Get install.sh directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

touch ~/test.file

# Check if .vim folder exists and ask if to be deleted or to be moved.
if [ -f ~/test.file ] ; then
  rm -i ~/test.file
  echo $?
fi

exit

# Check if .vimrc file exists and ask if to be deleted or to be moved.

ln -s $DIR/vimrc .vimrc
ln -s $DIR .vim



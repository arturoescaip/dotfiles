#!/bin/bash

source utils.sh
set -x

# Run the install.sh of each subdir
for d in ~/dotfiles/*/install.sh; do
  $d
done

# Make symbolic links to all rc files at top level
for f in `ls ~/dotfiles`; do
  if [[ -f $f ]] && [[ $f != *.sh ]]; then
    createLink ~/.$f ~/dotfiles/$f
  fi
done

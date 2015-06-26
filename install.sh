#!/bin/bash

set -x

for f in `ls ~/dotfiles`; do
  [ $f != install.sh ] && ln -s ~/dotfiles/$f ~/.$f
done

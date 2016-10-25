function createLink {
  linkPath=$1
  target=$2

  if [ -h $linkPath ]; then
    rm $linkPath
  fi

  if [ ! -e $1 ]; then
    ln -s $target $linkPath
  fi
}

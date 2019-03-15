function activate {
  source $1/bin/activate
}

function edit-package {
   [ -n "$1" ] && cd /src/$1
   file=$(fzf)
   [ $? -eq 0 ] && vim $file
}

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

alias ls="ls -G"
alias tree="tree -C"
alias trls="tree -C | less -R"
alias grep='grep -E --color=auto'

alias emacs="/usr/local/Cellar/emacs/24.2/Emacs.app/Contents/MacOS/Emacs -nw"
# Homebrew completion
source `brew --prefix`/Library/Contributions/brew_bash_completion.sh

# grc
source "`brew --prefix`/etc/grc.bashrc"

# For using C-s with vim
stty ixany
stty ixoff -ixon


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

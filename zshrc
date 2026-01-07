#!/bin/zsh

# ====== GENERAL ======

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export EDITOR="emacsclient -t -a ''"
# Path to your oh-my-zsh installation.
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="clean-custom" #"fwalch"

# get the hostname. works on both macos and linux.
host=$(command -v scutil &> /dev/null && scutil --get LocalHostName || hostname)

case $host in
    "phil-macbook-air")
        # ====== Personal macbook scripts, aliases, etc. ======
        export ZSH="/Users/phil/.oh-my-zsh"
	export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

        plugins=(
            git
        )

        # add ruby and dotfile scripts to my path
        export PATH="/opt/homebrew/opt/ruby/bin:/Users/phil/Library/Python/3.11/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"

        # store secrets in a separate file that's outside of my dotfiles
        source ~/.secrets
        export DENO_INSTALL="/Users/phil/.deno"
        export PATH="$DENO_INSTALL/bin:$PATH"
        ;;
    "phils-mbp")
        export ZSH="/Users/edwardcatterall/.oh-my-zsh"
        export GOOGLE_CLOUD_PROJECT="engineering-sandbox"
        alias docs='cd ~/code/snowplow/documentation'
        export NVM_DIR="$HOME/.nvm"
        # Lazy load nvm - only initialize when actually needed
        nvm() {
            unset -f nvm
            [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
            nvm "$@"
        }
        node() {
            unset -f node nvm
            [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
            node "$@"
        }
        npm() {
            unset -f npm nvm
            [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
            npm "$@"
        }
	# initiate https://github.com/tobi/try
	eval "$(ruby ~/.local/try.rb init ~/projects/tries)"
        ;;
    "raspi")
	export ZSH="/home/phil/.oh-my-zsh"
        plugins=(
            git
        )
	;;
    *)
        echo -n "computer $host not recognized"
esac

source $ZSH/oh-my-zsh.sh

# ====== ALIASES ======

# lf file manager stuff
lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}

alias lf='lfcd'

# emacs
alias e='emacsclient -t'           # Terminal emacs
alias ec='emacsclient -c'          # GUI emacs

# make a directory, then cd into it.
mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

# create a temp directory and cds into it
tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

alias gs='git status'

# bun completions
[ -s "/Users/edwardcatterall/.bun/_bun" ] && source "/Users/edwardcatterall/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

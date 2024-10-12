#!/bin/zsh
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="clean" #"fwalch"

localhost=`scutil --get LocalHostName`

case $localhost in
    "phil-macbook-air")
        #####################################################
        # Personal macbook scripts, aliases, etc.
        #####################################################
        export ZSH="/Users/phil/.oh-my-zsh"

        plugins=(
            git
        )

        # add ruby and dotfile scripts to my path
        export PATH="$HOME/.dotfiles/bin:/opt/homebrew/opt/ruby/bin:/Users/phil/Library/Python/3.11/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"
        # store secrets in a separate file that's outside of my dotfiles
        source ~/.secrets  
        export DENO_INSTALL="/Users/phil/.deno"
        export PATH="$DENO_INSTALL/bin:$PATH"
        ;;
    "ActionIQ-philipcatterall") # old work laptop
        #####################################################
        # Work macbook scripts, aliases, etc.
        #####################################################
        export ZSH="/Users/philipcatterall/.oh-my-zsh"
        # add random dirs to my PATH
        scripts_bin="$HOME/.dotfiles/bin"
        docker_bin="$HOME/.docker/bin"
        cargo_bin="$HOME/.cargo/bin"
        export PATH="$PATH:$scripts_bin:$docker_bin:$cargo_bin"
        # store secrets in a separate file that's outside of my dotfiles
        source ~/.secrets
        # look up customers by name or number
        cust() {
            lua ~/.dotfiles/scripts/customer_finder.lua "$1"
        }
        export AWS_PROFILE=189443971038_AWS_Athena_Access
        export EDITOR=nvim
        # set aliases for python
        alias python='python3.12'
        alias pip='pip3.12'
        plugins=(
            git
        )
        ;;
    "ActionIQ-phil") # new work laptop
        #####################################################
        # Work macbook scripts, aliases, etc.
        #####################################################
        export ZSH="/Users/phil/.oh-my-zsh"
        # add random dirs to my PATH
        scripts_bin="$HOME/.dotfiles/bin"
        docker_bin="$HOME/.docker/bin"
        cargo_bin="$HOME/.cargo/bin"
        export PATH="$PATH:$scripts_bin:$docker_bin:$cargo_bin"
        # store secrets in a separate file that's outside of my dotfiles
        #source ~/.secrets
        # look up customers by name or number
        cust() {
            lua ~/.dotfiles/bin/customer_finder.lua "$1"
        }
        export AWS_PROFILE=189443971038_AWS_Athena_Access
        export EDITOR=nvim
        # set aliases for python
        # alias python='python3.12'
        # alias pip='pip3.12'
        plugins=(
            git
        )
        ;;
    *)
        echo -n "computer $localhost not recognized"
esac

source $ZSH/oh-my-zsh.sh
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

alias gs='git status'

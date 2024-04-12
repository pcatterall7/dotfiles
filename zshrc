# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/phil/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="simple" #"fwalch"

localhost=`scutil --get LocalHostName`

case $localhost in
    "phil-macbook-air")
        #####################################################
        # Personal macbook scripts, aliases, etc.
        #####################################################
        plugins=(
            git
        )

        # add ruby and dotile scripts to my path
        export PATH="$HOME/.dotfiles/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"

        # store secrets in a separate file that's outside of my dotfiles
        source ~/.secrets
        ;;
    "ActionIQ-philipcatterall")
        #####################################################
        # Work macbook scripts, aliases, etc.
        #####################################################
        
        # add .dotfiles/bin/ to my path
        scripts_dir="$HOME/.dotfiles/bin"
        export PATH="$PATH:${scripts_dir}"
        
        # store secrets in a separate file that's outside of my dotfiles
        source ~/.secrets
        # look up customers by name or number
        cust() {
            ~/aiq-misc/scripts/customers.sh "$1" 
        }
        export AWS_PROFILE=189443971038_AWS_Athena_Access

        # set aliases for python
        alias python='python3.11'
        alias pip='pip3.11'
        plugins=(
            git
        )
        ;;
    *)
        echo -n "computer $localhost not recognized"
esac

source $ZSH/oh-my-zsh.sh
export EDITOR=nvim
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

alias gs='git status'

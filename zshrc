# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/philipcatterall/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="fwalch"

localhost=`scutil --get LocalHostName`

case $localhost in
    "philip-macbook-air")
        plugins=(
            git
        )
        # add ruby and dotile scripts to my path
        export PATH="$HOME/.dotfiles/scripts:/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"
        ;;

    "ActionIQ-philipcatterall")
        # everything below is specific to my work macbook pro
        alias cust="~/aiq-misc/scripts/customers.sh"
        alias mdpreview="~/.dotfiles/scripts/md_preview.sh"
        # alias wj="~/notes/aiq/00-index/wj-append.bash"
        alias notes="code ~/notes/aiq"
        # add .dotfiles/scripts/ to my path
        # TODO convert the aliases above to use this model
        scripts_dir="$HOME/.dotfiles/scripts"
        export PATH="$PATH:${scripts_dir}"
        # Load pyenv into the shell by adding
        # the following to ~/.zshrc:
        eval "$(pyenv init -)"
        export AWS_PROFILE=189443971038_AWS_Athena_Access
        plugins=(
            git
            zsh-autosuggestions
        )
        ;;
    *)
        echo -n "computer $localhost not recognized"
esac

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim


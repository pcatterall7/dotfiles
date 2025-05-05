#!/bin/zsh
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="clean-custom" #"fwalch"

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
        # add pipx apps to my path
        export PATH="$HOME/.local/bin:$PATH"

        # store secrets in a separate file that's outside of my dotfiles
        source ~/.secrets  
        export DENO_INSTALL="/Users/phil/.deno"
        export PATH="$DENO_INSTALL/bin:$PATH"
        ;;
    *)
        echo -n "computer $localhost not recognized"
esac

source $ZSH/oh-my-zsh.sh
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
alias gs='git status'
export EDITOR=nvim
export NNN_OPENER=nvim
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

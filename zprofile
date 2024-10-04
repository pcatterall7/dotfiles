
localhost=`scutil --get LocalHostName`

# Different things to initialize depending on which computer I'm using
case $localhost in
    "phil-macbook-air")
        # Set PATH, MANPATH, etc., for Homebrew.
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;

   "ActionIQ-philipcatterall" | "ActionIQ-phil")
        # 2024-07-26: pyenv broke for some reason
        # export PYENV_ROOT="$HOME/.pyenv"
        # export PATH="$PYENV_ROOT/bin:$PATH"
        # eval "$(pyenv init --path)"
        ;;

    *)
        echo -n "computer $localhost not recognized"
        ;;
esac

# Set PATH for Sublime Text and VSCode
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
eval "$(/opt/homebrew/bin/brew shellenv)"

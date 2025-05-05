
localhost=`scutil --get LocalHostName`

# Different things to initialize depending on which computer I'm using
case $localhost in
    "phil-macbook-air")
        # Set PATH, MANPATH, etc., for Homebrew.
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;

   "phils-mbp")
        ;;

    *)
        echo -n "computer $localhost not recognized"
        ;;
esac

# Set PATH for Sublime Text and VSCode
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
eval "$(/opt/homebrew/bin/brew shellenv)"

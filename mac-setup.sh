#!/bin/zsh

set -e  # Exit on error

DOTFILES_DIR="$HOME/dotfiles"

# Install xCode cli tools
echo "==> Installing commandline tools..."
if xcode-select -p &>/dev/null; then
    echo "    ✓ Xcode command line tools already installed"
else
    xcode-select --install || { echo "    ✗ Failed to install Xcode tools"; exit 1; }
    echo "    ✓ Xcode command line tools installed"
fi

# Homebrew
## Install
echo "\n==> Installing Homebrew..."
if command -v brew &>/dev/null; then
    echo "    ✓ Homebrew already installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "    ✗ Failed to install Homebrew"; exit 1; }
    echo "    ✓ Homebrew installed"
fi
brew analytics off

## Formulae
echo "\n==> Installing Homebrew Formulae..."
formulae=(jq gh mosh pandoc tmux duckdb bat lf emacs tlrc thaw mas nvm ruby lazygit)
for formula in "${formulae[@]}"; do
    echo "    → Installing $formula..."
    if brew install "$formula" 2>&1 | grep -q "already installed"; then
        echo "      ✓ $formula already installed"
    else
        echo "      ✓ $formula installed"
    fi
done

## Casks
echo "\n==> Installing Homebrew Casks..."
casks=(bettermouse betterdisplay raycast spotify espanso iterm2 rectangle obsidian sublime-text)
for cask in "${casks[@]}"; do
    echo "    → Installing $cask..."
    if brew install --cask "$cask" 2>&1 | grep -q "already installed"; then
        echo "      ✓ $cask already installed"
    else
        echo "      ✓ $cask installed"
    fi
done

## Mac App Store
echo "\n==> Mac App Store Apps"
echo "    ⚠️  Please log into the Mac App Store before continuing."
echo "    Press Enter once you're logged in..."
read

echo "    → Installing rcmd..."
if mas install 1596283165; then
    echo "      ✓ rcmd installed"
else
    echo "      ✗ Failed to install rcmd"
fi

# Oh My Zsh
echo "\n==> Installing Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "    ✓ Oh My Zsh already installed"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || { echo "    ✗ Failed to install Oh My Zsh"; exit 1; }
    echo "    ✓ Oh My Zsh installed"
fi

# Git submodules
echo "\n==> Initializing Git submodules..."
if [ -d "$DOTFILES_DIR" ]; then
    cd "$DOTFILES_DIR"
    if git submodule update --init --recursive; then
        echo "    ✓ Git submodules initialized"
    else
        echo "    ✗ Failed to initialize Git submodules"
    fi
else
    echo "    ⚠️  Dotfiles directory not found at $DOTFILES_DIR, skipping submodules"
fi

# Dotbot - Symlink dotfiles
echo "\n==> Setting up dotfiles with Dotbot..."
if [ -d "$DOTFILES_DIR" ] && [ -f "$DOTFILES_DIR/install" ]; then
    cd "$DOTFILES_DIR"
    if ./install; then
        echo "    ✓ Dotfiles symlinked successfully"
    else
        echo "    ✗ Failed to symlink dotfiles"
    fi
else
    echo "    ⚠️  Dotbot install script not found at $DOTFILES_DIR/install"
fi

# Fonts
# TODO 2026-03-05: use homebrew instead? https://formulae.brew.sh/cask-font/
echo "\n==> Installing custom fonts..."
if [ -d "$DOTFILES_DIR/fonts" ]; then
    echo "    → Copying fonts to ~/Library/Fonts..."
    for font_dir in "$DOTFILES_DIR/fonts"/*; do
        if [ -d "$font_dir" ]; then
            font_name=$(basename "$font_dir")
            echo "      → Installing $font_name..."
            cp -R "$font_dir"/*.{ttf,otf} ~/Library/Fonts/ 2>/dev/null || true
        fi
    done
    echo "    ✓ Fonts installed"
else
    echo "    ⚠️  Fonts directory not found"
fi

# macOS defaults
echo "\n==> Configuring macOS defaults..."

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.Dock showhidden -bool YES
echo "    ✓ Dock: auto-hide enabled, recent apps hidden, icon size 33, fade hidden apps"

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "    ✓ Finder: path bar enabled, list view default, show all extensions"

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
echo "    ✓ Keyboard: fast key repeat, auto-correct disabled"

# Menu bar clock
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
echo "    ✓ Menu bar: show AM/PM and day of week"

echo "    ✓ macOS defaults configured (restart required for some changes)"

# Restart affected applications
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
echo "    ✓ Dock and Finder restarted"

echo "\n🎉 Setup complete!"
echo "\nNext steps:"
echo "  1. Restart your terminal for zsh changes to take effect"
echo "  2. Configure Espanso and other apps as needed"
echo "  3. Create ~/.secrets file if you have sensitive environment variables"

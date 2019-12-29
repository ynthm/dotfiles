#!/bin/sh

# Upgrade homebrew
echo "🍄🍄🍄 brew update"
brew update

# Run Homebrew through the Brewfile
echo "🌖🌖🌖 brew bundle"
DOTFILES_ROOT=$(pwd -P)
brew bundle --file="$DOTFILES_ROOT/Brewfile"

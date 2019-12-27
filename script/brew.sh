#!/bin/sh

# Upgrade homebrew
echo "› brew update"
brew update

cd "$(dirname $0)"/..

# Run Homebrew through the Brewfile
echo "› brew bundle"
brew bundle
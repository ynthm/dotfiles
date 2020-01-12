#!/bin/sh

DOTFILES_ROOT=$(cd "$(dirname "$0")/..";pwd)

# Upgrade homebrew
echo "🍄🍄🍄 brew update"
brew update

info () {
  printf "\r[\033[00;36mINFO\033[0m] $1\n"
}
# 用户选择
user () {
  printf "\r[ \033[0;33m??\033[0m ] $1\n"
}

# Run Homebrew through the Brewfile
echo "🌖🌖🌖 brew bundle"

install_brew_apps() {
    bundle_check_install $DOTFILES_ROOT/homebrew/Brewfile
    user "More tools?\n\
        [y]Yes, [n]No?"
        local more=true
        read -n 1 action
        case "$action" in
          n )
            more=false
        esac

        if $more
        then
            bundle_check_install $DOTFILES_ROOT/homebrew/BrewfileX
        fi
}

bundle_check_install() {
    SATISFIED=`brew bundle check --file="$1"`
    SUB_STR="satisfied"
    if [[ $SATISFIED =~ $SUB_STR ]]
    then
        info "$SATISFIED"
    
    else
        brew bundle --file="$1"
    fi
}

install_brew_apps
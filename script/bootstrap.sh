#!/usr/bin/env bash

# 这条命令写在脚本文件里才有作用 dirname $0 指当前脚本所在目录
cd "$(dirname $0)/.."
echo `pwd`
DOTFILES_ROOT=$(pwd -P)

info () {
  printf "\r  [\033[00;34mINFO\033[0m] $1\n"
}
# 用户选择
user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

install_homebrew () {
  if test ! $(which brew)
  then
    echo "  Installing Homebrew for you..."

    # Install the correct homebrew for each OS type
    if test "$(uname)" = "Darwin"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
    fi
  else
    echo '💋💋💋 Homebrew already installed.'
  fi
}

install_ohmyzsh () {
  if [ ! -d ~/.oh-my-zsh ]
  then
    info '  Installing oh-my-zsh'
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  else
    echo '👏🏻👏🏻👏🏻 Oh My Zsh already installed.'
  fi
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info '  Installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}


install_homebrew
install_ohmyzsh

# If we're on a Mac, let's install and setup homebrew.
if [ "$(uname -s)" == "Darwin" ]
then
  info "installing dependencies"
  if source script/brew.sh
  then
    success "dependencies installed"
  else
    fail "error installing dependencies"
  fi
fi

install_dotfiles
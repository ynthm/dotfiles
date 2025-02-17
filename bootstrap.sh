#!/usr/bin/env zsh

# 这条命令写在脚本文件里才有作用 dirname $0 指当前脚本所在目录
DOTFILES_ROOT=$(
  cd "$(dirname "$0")"
  pwd
)

info() {
  printf "\r[\033[00;36mINFO\033[0m] $1\n"
}
# 用户选择
user() {
  printf "\r[ \033[0;33m??\033[0m ] $1\n"
}

ok() {
  printf "\r\033[2K[ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
  printf "\r\033[2K[\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
     echo '💋💋💋 Homebrew already installed.'
  else

    info "Installing Homebrew for you..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> /Users/ynthm/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/ynthm/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_starship(){
  curl -sS https://starship.rs/install.sh | sh
  # mkdir ~/.zsh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
}

install_ohmyzsh() {
  if [ ! -d ~/.oh-my-zsh ]; then
    info 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
  else
    echo '👏🏻👏🏻👏🏻 Oh My Zsh already installed.'
  fi
}

if [ "$SHELL" != "/bin/zsh" ]; then
  chsh -s $(which zsh)
fi

install_brew_apps() {
  # If we're on a Mac, let's install and setup homebrew.
  if [ "$(uname -s)" = "Darwin" ]; then
    info "Installing dependencies"
    # 执行其他脚本
    cd $DOTFILES_ROOT
    cd script
    if source brew.sh; then
      ok "Dependencies installed"
    else
      fail "Error installing dependencies"
    fi
  fi
}



link_file() {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then

        skip=true

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
        o)
          overwrite=true
          ;;
        O)
          overwrite_all=true
          ;;
        b)
          backup=true
          ;;
        B)
          backup_all=true
          ;;
        s)
          skip=true
          ;;
        S)
          skip_all=true
          ;;
        *) ;;

        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      ok "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      ok "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      ok "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]; then # "false" or empty
    ln -s "$1" "$2"
    ok "linked $1 to $2"
  fi
}

link() {
  if [ ! -d $HOME/.config/youtube-dl/config ]; then
    info "config youtube-dl"
    mkdir ~/.config/youtube-dl
    ln -s "$DOTFILES_ROOT/config/youtube-dl/config" "$HOME/.config/youtube-dl/config"
  fi
}

install_dotfiles() {
  info 'Installing dotfiles'
  link

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find "$DOTFILES_ROOT/config" -maxdepth 2 -name '*.symlink' -not -path '*.git*'); do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

install_homebrew
# install_ohmyzsh
install_brew_apps
install_dotfiles

install_spacevim() {
  if [ ! -d ~/.SpaceVim.d ]; then
    info "Installing SpaceVim for you..."
    curl -sLf https://spacevim.org/cn/install.sh | bash
  else
    echo '💋💋💋 SpaceVim already installed.'
  fi
}

# install_spacevim

# Disable the “Last login” Message on new Terminal Session
# touch ~/.hushlogin

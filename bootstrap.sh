#!/bin/bash

# 这条命令写在脚本文件里才有作用 dirname $0 指当前脚本所在目录
DOTFILES_ROOT=$(
  cd "$(dirname "$0")"
  pwd
)
# echo `pwd`

function info {
  printf "\r\033[32m🍀 $1\033[0m\n"
}
# 用户选择
function choose {
  printf "\r\033[95m🌸 $1\033[0m\n"
}

function ok {
  echo -e "\033[94m🎽 $1\033[0m"
}

function fail {
  echo -e "\033[90m✖️  $1\033[0m"
  # exit
}

# In computing, a symbolic link (also symlink or soft link)
# is a file whose purpose is to point to a file or directory (called the "target") by specifying a path thereto.
function link_symbol_link() {
  cat $1 | while read line; do
    string=$line
    array=(${string//,/ })

    if [ -n "${array[2]}" ]; then
      dst=$HOME${array[2]}
    fi

    if [ -L $dst ]; then
      ok "existed symbolic link $dst"
      continue
    fi

    if [ -n "${array[0]}" ]; then
      name=${array[0]}
    fi
    if [ -n "${array[1]}" ]; then
      src="$DOTFILES/config/link/${array[1]}"
    fi

    if [ "$name" = "youtube-dl" ]; then
      if [ ! -d $HOME/.config/youtube-dl/config ]; then
        mkdir -p ~/.config/youtube-dl
      fi
    fi

    if [ -e $dst ]; then
      echo "File already exists: $dst"
      rm -rf "$dst"
    fi

    echo "create symbolic link $dst"
    ln -s "$src" "$dst"
  done
}

install_homebrew() {
  if test ! $(which brew); then
    info "Installing Homebrew for you..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    info 'Homebrew already installed.'
  fi
}

# https://github.com/ohmyzsh/ohmyzsh
function install_ohmyzsh {
  if [ ! -d ~/.oh-my-zsh ]; then
    info 'Installing oh-my-zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    info 'Oh My Zsh already installed.'
  fi

  link_symbol_link "$DOTFILES_ROOT/config/link/link-pairs.txt"

  install_powerlevel10k
  install_zsh_autosuggestions
  install_zsh_syntax_highlighting
  intall_zsh_completions

  choose "please exec: source ~/.zshrc"
  # source_zshrc
}

function source_zshrc {
  source ~/.zshrc
}

# Fish-like fast/unobtrusive autosuggestions for zsh
function install_zsh_autosuggestions {
  if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    info 'Installing zsh-autosuggestions'
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  else
    info 'zsh-autosuggestions already installed.'
  fi
}

# Fish shell like syntax highlighting for zsh
function install_zsh_syntax_highlighting {
  if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    info 'Installing zsh-syntax-highlighting'
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  else
    info 'zsh-syntax-highlighting already installed.'
  fi
}

function intall_zsh_completions {
  if [ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions ]; then
    info 'Installing zsh-completions'
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
  else
    info 'zsh-completions already installed.'
  fi
}

function install_powerlevel10k {
  if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    info 'Installing Zsh theme powerlevel10k'
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  else
    info 'powerlevel10k already installed.'
  fi
}

install_brew_apps() {
  # If we're on a Mac, let's install and setup homebrew.
  if [ "$(uname -s)" == "Darwin" ]; then
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

PS3='Please enter your choice: '
options=("Install all" "Install homebrew" "Install ohmyzsh" "Install brew apps" "Create symbolic link" "Quit")
select opt in "${options[@]}"; do
  case $opt in
  "Install all")
    install_homebrew
    install_ohmyzsh
    install_brew_apps
    ;;
  "Install homebrew")
    install_homebrew
    ;;
  "Install ohmyzsh")
    install_ohmyzsh
    ;;
  "Install brew apps")
    install_brew_apps
    ;;
  "Create symbolic link")
    link_symbol_link "$DOTFILES_ROOT/config/link/link-pairs.txt"
    ;;
  "Quit")
    break
    ;;
  *) echo invalid option ;;
  esac
done

# Disable the “Last login” Message on new Terminal Session
touch ~/.hushlogin

# macOS Catalina 使用 zsh 作为默认 Shell
function change_shell() {
  if [ "$SHELL" != "/bin/zsh" ]; then
    echo "changing to zsh."
    chsh -s $(which zsh)
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

        choose "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
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

install_dotfiles() {
  info 'Installing dotfiles'
  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find "$DOTFILES_ROOT/config" -maxdepth 2 -name '*.symlink' -not -path '*.git*'); do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

install_spacevim() {
  if [ ! -d ~/.SpaceVim.d ]; then
    info "Installing SpaceVim for you..."
    curl -sLf https://spacevim.org/cn/install.sh | bash
  else
    echo '💋💋💋 SpaceVim already installed.'
  fi
}

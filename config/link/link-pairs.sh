#!/bin/bash

export DOTFILES=$HOME/.dotfiles
if [ -n "$1" ]; then
    name=$1
fi
if [ -n "$2" ]; then
    src="$DOTFILES/config/link/$2"
fi
if [ -n "$3" ]; then
    dst=$HOME$3
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

ln -s "$src" "$dst"



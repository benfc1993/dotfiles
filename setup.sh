#! /bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

mkdir -p ~/.config/tmux

ln -s "$parent_path/tmux/tmux.conf" ~/.config/tmux/tmux.conf

ln -s "$parent_path/nvim" ~/.config/nvim/lua/custom

ln -s "$parent_path/vimcd" /usr/local/bin/vimcd


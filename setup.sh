#! /bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mkdir -p ~/.config/tmux

cp -r "$parent_path/tmux" ~/.config

cp -r "$parent_path/nvim/*" ~/.config/nvim/lua/custom/

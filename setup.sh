#! /bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

rm -rf ~/.config/nvim

mkdir -p ~/.config/tmux

ln -s "$parent_path/tmux/tmux.conf" ~/.config/tmux/tmux.conf

chmod a+u "$parent_path/tmux/plugins/fileSearch" 
ln -s "$parent_path/tmux/plugins/fileSearch" /usr/local/bin/fileSearch 

cd "$parent_path/nvim" && ln -s $(pwd) ~/.config/nvim

ln -s "$parent_path/vimcd" /usr/local/bin/vimcd


#! /bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

mkdir -p ~/.config/tmux

ln -s "$parent_path/tmux/tmux.conf" ~/.config/tmux/tmux.conf

chmod a+u "$parent_path/tmux/plugins/fileSearch" 
ln -s "$parent_path/tmux/plugins/fileSearch" /usr/local/bin/fileSearch 

cd ~/.config/nvim/lua && ln -s "$parent_path/nvim" custom

ln -s "$parent_path/vimcd" /usr/local/bin/vimcd


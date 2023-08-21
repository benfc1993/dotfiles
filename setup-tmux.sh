#! /usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

rm -rf ~/.config/tmux/tmux.conf
sudo rm -rf /usr/local/bin/fileSearch
sudo rm -rf /usr/local/bin/vimcd

mkdir -p ~/.config/tmux

ln -s "$parent_path/tmux/tmux.conf" ~/.config/tmux/tmux.conf

chmod a+u "$parent_path/tmux/plugins/fileSearch" 
sudo ln -s "$parent_path/tmux/plugins/fileSearch" /usr/local/bin/fileSearch 

chmod a+u "$parent_path/vimcd" 
sudo ln -s "$parent_path/vimcd" /usr/local/bin/vimcd

#! /bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

rm -f ~/.config/nvim
sudo rm -rf /usr/local/bin/vimcd

sudo ln -s "$parent_path/vimcd.sh" /usr/local/bin/vimcd
ln -s "$parent_path/nvim" ~/.config/nvim


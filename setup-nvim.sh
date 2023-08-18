#! /bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

rm -rf /usr.local/bin.vimcd

cd "$parent_path/nvim" && ln -s $(pwd) ~/.config/nvim


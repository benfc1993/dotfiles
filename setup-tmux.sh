#! /usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

if [[ ! $(dpkg-query -l glow)  ]]; then
    echo "installing dependancies"
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install glow
fi

if [[ ! $(dpkg-query -l tmux) ]]; then
    sudo apt update;
    sudo apt install tmux
fi

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


rm -rf ~/.config/tmux
sudo rm -rf /usr/local/bin/fileSearch
sudo rm -rf /usr/local/bin/vimcd

mkdir -p ~/.config/tmux

ln -s "$parent_path/tmux/tmux.conf" ~/.config/tmux/tmux.conf

chmod a+u "$parent_path/tmux/plugins/fileSearch" 
sudo ln -s "$parent_path/tmux/plugins/fileSearch" /usr/local/bin/fileSearch 

chmod a+u "$parent_path/vimcd.sh" 
sudo ln -s "$parent_path/vimcd.sh" /usr/local/bin/vimcd

ln -s "$parent_path/tmux/cheatsheet.md" ~/.config/tmux/cheatsheet.md
ln -s "$parent_path/tmux/cheatsheet.sh" ~/.config/tmux/cheatsheet

tmux source ~/.config/tmux/tmux.conf


./.tmux/plugins/tpm/bindings/install_plugins

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

if [[ ! $(dpkg-query -l fzf) ]]; then
    sudo apt install fzf
fi

rm -rf ~/.config/tmux
sudo rm -rf /usr/local/bin/fileSearch
sudo rm -rf /usr/local/bin/vimcd

mkdir -p ~/.config/tmux

ln -s "$parent_path/tmux/tmux.conf" ~/.config/tmux/tmux.conf

rm -rf ~/.config/tmux/custom
mkdir ~/.config/tmux/custom

# Plugins
chmod a+u "$parent_path/tmux/plugins/fileSearch" 
sudo ln -s "$parent_path/tmux/plugins/fileSearch" /usr/local/bin/fileSearch 

chmod +x "$parent_path/tmux/plugins/cheatsheet/cheatsheet.sh"
ln -s "$parent_path/tmux/plugins/cheatsheet" ~/.config/tmux/custom/cheatsheet

chmod a+u "$parent_path/tmux/plugins/v-session.sh"
sudo ln -s "$parent_path/tmux/plugins/v-session.sh" /usr/local/bin/v-session

chmod a+u "$parent_path/vimcd.sh" 
sudo ln -s "$parent_path/vimcd.sh" /usr/local/bin/vimcd

chmod +x "$parent_path/tmux/plugins/project-builder/project-builder.sh"
ln -s "$parent_path/tmux/plugins/project-builder" ~/.config/tmux/custom/project-builder

chmod a+u "$parent_path/tmux/plugins/cht.sh"
sudo ln -s "$parent_path/tmux/plugins/cht.sh" /usr/local/bin/cht.sh

tmux source ~/.config/tmux/tmux.conf


~/.tmux/plugins/tpm/bindings/install_plugins

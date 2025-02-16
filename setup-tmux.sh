#! /usr/bin/env bash

mkdir -p ~/.config/tmux
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ ! $(which stow) ]]; then
        brew install stow;
    fi
    if [[ ! $(which glow) ]]; then
        brew install glow;
    fi

    if [[ ! $(which fd) ]]; then
        brew install fd;
    fi

    if [[ ! $(which tmux) ]]; then
        brew install tmux;
    fi

    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    if [[ ! $(which fzf) ]]; then
        brew install fzf
    fi

else
    if [[ ! $(which stow) ]]; then
        sudo apt update;
        sudo apt install stow
    fi
    if [[ ! $(which glow)  ]]; then
        echo "installing dependancies"
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
        echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
        sudo apt update && sudo apt install glow
    fi

    if [[ ! $(which tmux) ]]; then
        sudo apt update;
        sudo apt install tmux
    fi


    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    if [[ ! $(which fzf) ]]; then
        sudo apt install fzf
    fi

fi

rm -rf ~/.config/tmux
sudo rm -rf /usr/local/bin/fileSearch
sudo rm -rf /usr/local/bin/vimcd

stow tmux

rm -rf ~/.config/tmux/custom
mkdir ~/.config/tmux/custom

# Plugins
sudo rm -rf /usr/local/bin/fileSearch
chmod a+x "$parent_path/tmux/plugins/tmux/fileSearch"
sudo ln -s "$parent_path/tmux/plugins/tmux/fileSearch" /usr/local/bin/fileSearch

sudo rm -rf /usr/local/bin/v-session
sudo ln -s "$parent_path/tmux/plugins/tmux/v-session.sh" /usr/local/bin/v-session

sudo rm -rf /usr/local/bin/vimcd
sudo ln -s "$parent_path/vimcd.sh" /usr/local/bin/vimcd

mkdir -p ~/.note-taker/notes

sudo rm -rf /usr/local/bin/cht.sh
sudo ln -s "$parent_path/plugins/tmux/cht.sh" /usr/local/bin/cht.sh

sudo rm -rf /usr/local/bin/all-search
sudo ln -s "$parent_path/plugins/tmux/all-search.sh" /usr/local/bin/all-search

sudo rm -rf /usr/local/bin/keys
sudo ln -s "$parent_path/plugins/tmux/keys/keys.sh" /usr/local/bin/keys

ln -s "$parent_path/.config/zshalias" ~/.config/zshalias

tmux source ~/.config/tmux/tmux.conf

~/.tmux/plugins/tpm/bindings/install_plugins

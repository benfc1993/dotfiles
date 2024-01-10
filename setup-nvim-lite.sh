#! /bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

rm -f ~/.config/nvim
sudo rm -rf /usr/local/bin/vimcd

sudo ln -s "$parent_path/vimcd.sh" /usr/local/bin/vimcd
ln -s "$parent_path/nvim-lite" ~/.config/nvim

ln -s "$parent_path/vscode" ~/.config/vscode

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    rm -rf ~/.config/Code/User/keybindings.json 
    cp -f "$parent_path/vscode/keybindings.json" ~/.config/Code/User/keybindings.json
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Mac OS"
    cp -f "$parent_path/vscode/keybindings.json" "$HOME/Library/Application\ Support/Code/User/keybindings.json"
fi

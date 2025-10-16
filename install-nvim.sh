!#/bin/bash 

curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz -o "$HOME/Downloads/nightly-nvim.tar.gz"

mkdir "$HOME/Downloads/nvim-tar"
tar xzvf "$HOME/Downloads/nightly-nvim.tar.gz" -C "$HOME/Downloads/nvim-tar" --strip-components=1

sudo mv "$HOME/Downloads/nvim-tar/bin/nvim" "/usr/local/bin/"
sudo mv "$HOME/Downloads/nvim-tar/lib/nvim" "/usr/local/lib/"
sudo mv "$HOME/Downloads/nvim-tar/share/applications/nvim.desktop" "/usr/local/share/applications/"
sudo mv "$HOME/Downloads/nvim-tar/share/icons/hicolor/128x128/apps/nvim.png" "/usr/share/icons/hicolor/128x128/apps/"
sudo mv "$HOME/Downloads/nvim-tar/share/man/man1/nvim.1" "/usr/local/share/man/man1/"
sudo mv "$HOME/Downloads/nvim-tar/share/nvim" "/usr/local/share/"

rm -rf "$HOME/Downloads/nvim-tar"
rm -rf "$HOME/Downloads/nightly-nvim.tar.gz"

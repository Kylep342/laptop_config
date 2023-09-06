#! /usr/bin/env bash

set -e
set -o errexit pipefail



if [[ -e $HOME/.zshrc ]] && [[ ! -h $HOME/.zshrc ]]; then
    echo "You have a real .zshrc file. Would you like to save a backup at $HOME/.zshrc.backup? [Y/n]:"
    read -r bkp
    if [[ $bkp =~ "^[y|Y]$" ]]; then
        echo "Making backup of $HOME/.zshrc at $HOME/.zshrc.backup"
        mv $HOME/.zshrc $HOME/.zshrc.backup
    fi
fi

echo "Linking config/.zshrc to $HOME/.zshrc"
ln -f ./config/.zshrc $HOME/.zshrc


echo "zshrc set up"
echo "Installing Powerline fonts"

git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


echo "Powerline fonts installed"
echo "Setting up 'global' python virtualenv"

python -m venv venv
source venv/bin/activate
pip install -r config/requirements.txt

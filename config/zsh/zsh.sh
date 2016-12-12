#/bin/bash

# Function: install or uninstall oh-my-zsh
# Install: bash zsh.sh install
# Uninstall: bash zsh.sh uninstall
# Note: default theme is 'robbyrussell', and i can change it to 'steeef' by change the .zshrc file

cd ~

url=https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh

if [ "$1" = "install" ]; then
    echo "start installing..."
    sh -c "$(curl -fsSL $url)"
    echo "install zsh successfully"
elif [ "$1" = "uninstall" ]; then
    echo "start uninstalling zsh..."
    sh ~/.oh-my-zsh/tools/uninstall.sh
    echo "uninstall zsh successfully"
else
    echo "please input the correct param :install or uninstall"
    exit 1
fi

exit 0

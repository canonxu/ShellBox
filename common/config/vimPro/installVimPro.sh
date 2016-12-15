#!/bin/bash

# Function: Intsall vimPro for user, under the ~/

# Example: bash installVimPro.sh 

# install pure, install plugin, uninstall plugin 

#PS3='Please enter your choice for vimPro: '
#options=("instal" "Option 2" "Option 3" "Quit")
#select opt in "${options[@]}"
#do
#case$optin
#"Option1")
#echo"youchosechoice1"
#;;
#"Option2")
#echo"youchosechoice2"
#;;
#"Option3")
#echo"youchosechoice3"
#;;
#"Quit")
#break
#;;
#*)echoinvalidoption;;
#esac
#done

git clone TODO
mv pro_vimrc ~/.vimrc
mv pro_vimrc_bundle ~/.vimrc.bundle

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

vim +BundleInstall +pall

# install YouCompleteMe
cd ~/.vim/bundle/vundle/YouCompleteMe
python install.py || echo "error while execute install.py\n"



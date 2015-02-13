#!/bin/bash
SET_DIR=~/utility/scripts/vimdic
IS_FRST_SET=$(grep -c vimdic ~/.bashrc)
IS_LOCALE_SET=$(locale -a | grep -c ko_KR.utf8)
IS_CLIPBOARD_SET=$(vim --version | grep -c [+]clipboard)

chmod 775 $SET_DIR/vimdic.sh
if [ $IS_FRST_SET == 0 ]; then
	echo "Setting vimdic.."

	# Set locale to ko_KR.UTF-8
	if [ $IS_LOCALE_SET == 0 ]; then
		sudo locale-gen ko_KR.UTF-8
		sudo dpkg-reconfigure locales
		if [ $(locale -a | grep -c ko_KR.utf8) == 0 ]; then
			echo "Fail to setup locale"
		else
			echo "Success to setup locale"
		fi
	else
		echo "Already set locale"
	fi

	if [ $IS_CLIPBOARD_SET == 0 ]; then
		sudo apt-get install vim-gnome
		if [ $IS_CLIPBOARD_SET == 0]; then
			echo "Fail to setup vim clipboard"
		else
			echo "Success to setup vim clipboard"
		fi
	else
		echo "Already set vim clipboard"
	fi

	sudo apt-get install w3m
	mkdir -p $SET_DIR
	cp setup.sh vimdic.sh $SET_DIR
	echo "nmap tt :!vimdic.sh<Space><cword><CR>">> ~/.vimrc
	echo "xmap tt \"+y<ESC>:!vimdic.sh<Space><C-R><C-O>\"<CR>">> ~/.vimrc
	echo "export PATH=$PATH:$SET_DIR">> ~/.bashrc
	source ~/.bashrc
else
	echo "Vimdic already set"
fi

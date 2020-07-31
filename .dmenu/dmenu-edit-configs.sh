#!/bin/bash

declare options=("alacritty
bash
zsh
picom
st
vim
tmux
xmobar
xmonad
dmenu-edit-configs
")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config file: ')

case "$choice" in
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	bash)
		choice="$HOME/.bashrc"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	picom)
		choice="$HOME/.config/picom.conf"
	;;
	st)
		choice="$HOME/Proyectos/st/config.h"
	;;
	vim)
		choice="$HOME/.vimrc"
	;;
	tmux)
		choice="$HOME/.tmux.conf"
	;;
	xmobar)
		choice="$HOME/.xmobarrc"
	;;
	xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	dmenu-edit-configs)
		choice="$HOME/.dmenu/dmenu-edit-configs.sh"
	;;
	*)
		exit 1
	;;
esac

alacritty -e vim "$choice"

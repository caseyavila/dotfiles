#!/bin/bash

declare options=("alacritty
bash
dmenu-edit-configs
picom
st
tmux
vim
xmobar
xmonad
zsh
")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config file: ')

case "$choice" in
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	bash)
		choice="$HOME/.bashrc"
	;;
	dmenu-edit-configs)
		choice="$HOME/.dmenu/dmenu-edit-configs.sh"
	;;
	picom)
		choice="$HOME/.config/picom.conf"
	;;
	st)
		choice="$HOME/Proyectos/st/config.h"
	;;
	tmux)
		choice="$HOME/.tmux.conf"
	;;
	vim)
		choice="$HOME/.vimrc"
	;;
	xmobar)
		choice="$HOME/.xmobarrc"
	;;
	xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	*)
		exit 1
	;;
esac

alacritty -e vim "$choice"

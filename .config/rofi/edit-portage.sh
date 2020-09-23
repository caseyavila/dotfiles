#!/bin/sh

choice="$(find /etc/portage/ | rofi -dmenu -p 'Edit portage')"

if test "$choice" != ''; then
    alacritty -e sudo vim "$choice"
fi


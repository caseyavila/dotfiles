#!/bin/sh

choice="$(find /etc/portage/ -type f | rofi -dmenu -p 'Edit portage')"

if test "$choice" != ''; then
    alacritty -e sudo vim "$choice"
fi


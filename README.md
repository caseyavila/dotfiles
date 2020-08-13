# dotfiles
The files to accompany my linux setup.

## Programs
*Indents signify less favorable, though useful alternatives*
- alacritty
  - st
- bash
  - zsh
- feh
  - nitrogen
- firefox
- maim
- no compositor
  - picom
- rofi
- tmux
- vim
- xmobar
- xmonad

## Notes
- 10 pixels of padding for the terminal is nice
- Bitmap fonts like Neep and Terminus are also very nice

## Other Setup Info (mainly personal notes)

### X Server Configuration
Append the followoing to `~/.xinitrc`:
```
xset m 0 0 &
xset r rate 250 30 &
exec xmonad
```

To start an X server upon login, add this to `~/.zprofile` or `~/.bash_profile`:
```
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi
```

### Keyboard Layout
Setup `/etc/X11/xorg.conf.d/10-keyboard.conf` as such:
```
Section "InputClass"
        Identifier  "system-keyboard"
        Option "XkbModel" "pc105"
        Option "XkbLayout" "us"
        Option "XkbVariant" "altgr-intl"
EndSection
```

### Wireless Network
Run the following commands after using `wpa_passphrase`:
```shell
$ wpa_supplicant -B -i wlp3s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
$ dhcpcd wlp3s0
```


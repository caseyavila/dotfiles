# dotfiles
The files to accompany my linux setup.

![screenshot](https://camo.githubusercontent.com/8cb822f22c581a6ceb84135815e113b5a9530850/68747470733a2f2f696d6775722e636f6d2f5541634e4f6d772e706e67)

## Programs
- alacritty
  - st
- bash
- feh
  - nitrogen
- firefox
- maim
- picom
  - no compositor
- rofi
- tmux
- vim
- xmobar
- xmonad

## Notes
- 10 pixels of padding for the terminal is nice
- Bitmap fonts like Neep, Terminus, and Tewi are also very nice

## Other Setup Info (mainly personal notes)

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


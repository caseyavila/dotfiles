# dotfiles
The files to accompany my linux setup.

## Programs
- bash
- vim
- tmux
- alacritty (Any terminal emulator should work fine)
- xmonad
- xmobar
- dmenu
- picom
- nitrogen

## Notes
- The terminal emulator's padding should be set to 10 pixels

## Other setup info (Personal Notes)

### Keyboard Layout
Setup `/etc/X11/xorg.conf.d/00-keyboard.conf` as such:
```
Section "InputClass"
        Identifier  "system-keyboard"
        Option "XkbModel" "pc104"   # Fill in your keyboard model
        Option "XkbLayout" "us"
        Option "XkbVariant" "intl"
        Option "XkbOptions" "nodeadkeys"
EndSection
```

## Wireless Network
Run the following commands after using `wpa_passphrase`:
```Shell
# wpa_supplicant -B -i wlp3s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
# sudo dhcpcd wlp3s0
```


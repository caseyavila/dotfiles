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
- Scan for networks
```
# wpa_cli
> scan
> scan_results
```

- Edit `/etc/wpa_supplicant/wpa_supplicant.conf`
```
ctrl_interface=DIR=/run/wpa_supplicant GROUP=wheel
update_config=1

network={
	ssid="network name"
	psk="password"
	#for networks with no passwords
	key_mgmt=NONE
}
```

- Restart network interface
```
# /etc/init.d/net.wlp3s0 restart
```


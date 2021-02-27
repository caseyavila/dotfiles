# dotfiles
The files to accompany my linux setup.

![screenshot](https://imgur.com/5qDVUKY.png)

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

### Mouse Acceleration
Setup `/etc/X11/xorg.conf.d/11-mouse.conf` as such:
```
Section "InputClass"
        Identifier "mouse"
        Driver "libinput"
        Option "AccelProfile" "flat"
EndSection

```
- Keep in mind this is because libinput is the device driver.

### Keyboard Layout
Setup `/etc/X11/xorg.conf.d/10-keyboard.conf` as such:
```
Section "InputClass"
        Identifier "keyboard"
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
	# v for networks with no passwords v
	key_mgmt=NONE
}
```

- Restart network interface (OpenRC)
```
# /etc/init.d/net.wlp3s0 restart
```


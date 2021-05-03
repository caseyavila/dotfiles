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

### Laptop Touchpad
Setup `/etc/X11/xorg.conf.d/12.touchpad.conf` as such:
```
Section "InputClass"
        Identifier "touchpad"
        Driver "libinput"
        Option "Tapping" "on"
        Option "ScrollMethod" "edge"
        Option "ClickMethod" "clickfinger"
EndSection
```

### Laptop Backlight
- Add this rule to `/etc/acpi/default.sh`
```sh
    video)
        case "$action" in
            brightnessup)
                /etc/acpi/actions/backlight.sh up
                ;;
            brightnessdown)
                /etc/acpi/actions/backlight.sh down
                ;;
            *) log_unhandled
                $*
                ;;
        esac
        ;;
```

- Edit `/etc/acpi/actions/backlight.sh`
```sh
#!/bin/sh
set -e

backlight_sys_dir="/sys/class/backlight/intel_backlight"
read -r max_brightness < "${backlight_sys_dir}/max_brightness"
read -r curr_brightness < "${backlight_sys_dir}/brightness"

case "$1" in
      up) increment="+ 50" ;;
    down) increment="- 50" ;;
       *) exit 1 ;;
esac

new_brightness=$(($curr_brightness $increment))

if (($new_brightness < 1)) || (($new_brightness > $max_brightness)); then
    exit 1
else
    echo "$new_brightness" > ${backlight_sys_dir}/brightness
fi
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

### Color Emojis
- Edit `~/.config/fontconfig/fonts.conf` as such:
```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <alias>
   <family>sans-serif</family>
   <prefer>
     <family>Noto Color Emoji</family>
   </prefer>
 </alias>

 <alias>
   <family>serif</family>
   <prefer>
     <family>Noto Color Emoji</family>
   </prefer>
 </alias>

 <alias>
   <family>monospace</family>
   <prefer>
    <family>Noto Color Emoji</family>
   </prefer>
 </alias>
</fontconfig>
```

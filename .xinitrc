mkfifo /tmp/.title

xset m 0 0 &
xset r rate 250 30 &
exec xmonad


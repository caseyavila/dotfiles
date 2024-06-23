import XMonad
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

compositor = "picom"

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ def
  {
    modMask = mod4Mask,
    terminal = "alacritty",
    borderWidth = 2,
    normalBorderColor = "#404040",
    clickJustFocuses = False,
    layoutHook = lessBorders OnlyScreenFloat $
    avoidStruts $
      spacingRaw False (Border 3 3 3 3) True (Border 3 3 3 3) True $
      layoutHook def,
    startupHook = do spawnOnce compositor,
    manageHook = checkDock --> doLower
  }
  `additionalKeysP` [
    ("M-f", spawn "firefox"),
    ("M-p", spawn "rofi -show run"),
    ("M-c", spawn $ "killall " ++ compositor ++ " || " ++ compositor),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%"),
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -1.5%"),
    ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
    ("<XF86MonBrightnessUp>", spawn "brightnessctl set 5%+"),
    ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
  ]

import XMonad
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.StackSet as W
import Data.Map as M

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
    startupHook = do spawnOnce compositor >> setWMName "LG3D",
    manageHook = checkDock --> doLower
  } `additionalKeysP` [
    ("M-f", spawn "firefox"),
    ("M-p", spawn "rofi -show run"),
    ("M-c", spawn $ "killall " ++ compositor ++ " || " ++ compositor),
    ("M-a", withFocused (\w -> windows (\s ->
              if M.member w (W.floating s)
                then W.sink w s
                else W.float w (W.RationalRect (1/9) (1/7) (7/9) (5/7)) s))),
    ("M-=", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%"),
    ("M--", spawn "pactl set-sink-volume @DEFAULT_SINK@ -1.5%"),
    ("M-0", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("M-s", spawn "maim --hidecursor -s ~/image-$(ls image-*.png | wc -l).png"),
    ("M-S-s", spawn "maim --hidecursor -s | xclip -selection clipboard -t image/png")
  ]
  `removeKeysP` [
    "M-t"
  ]

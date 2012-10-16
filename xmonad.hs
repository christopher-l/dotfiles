import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig
 
main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myPP = xmobarPP
    { ppTitle = shorten 100
    , ppUrgent = xmobarColor "#ff2f2f" "" . wrap "*" "*" 
    }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = (withUrgencyHook NoUrgencyHook $ defaultConfig)
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , borderWidth = 1
    }
    `additionalKeys`
    [ (( 0, xF86XK_AudioLowerVolume), spawn "pactl -- set-sink-volume 0 -5%")
    , (( 0, xF86XK_AudioRaiseVolume), spawn "pactl -- set-sink-volume 0 +5%")
    , (( 0, xF86XK_Launch1), spawn "xset dpms force off")
    , (( 0, xF86XK_Display), spawn "x-toggle-2nd.sh")
    , (( mod4Mask, xK_BackSpace), kill)
    ]

-- vim: ts=4 sw=4 et

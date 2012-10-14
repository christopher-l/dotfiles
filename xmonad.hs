import XMonad hiding ((|||))
import XMonad.ManageHook
import XMonad.Config (defaultConfig)
import qualified XMonad.StackSet as W
import qualified XMonad.Prompt         as P
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S
import qualified Data.Map        as M

import XMonad.Actions.CycleWS
import XMonad.Actions.Promote
import XMonad.Actions.UpdatePointer
import XMonad.Actions.GridSelect
import XMonad.Actions.Search

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.DwmStyle
import XMonad.Layout.SimplestFloat
import XMonad.Layout.IM
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.OneBig

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Theme
import XMonad.Prompt.AppendFile

import XMonad.Util.EZConfig
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe, hPutStrLn)
import XMonad.Util.Font
import XMonad.Util.Scratchpad (scratchpadSpawnAction, scratchpadManageHook, scratchpadFilterOutWorkspace)
import XMonad.Util.WorkspaceCompare

import Data.Ratio ((%))

statusBarCmd = "dzen2 -e '' -ta l -fn 'Droid Sans-8' -bg '#3f3f3f' -fg #d3d7cf "

main = do
       din <- spawnPipe statusBarCmd
       xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
                     { borderWidth        = 1
                     , workspaces         = myWorkspaces
                     , terminal           = myTerminal
                     , modMask            = mod4Mask
                     , normalBorderColor  = myNormalBorderColor
                     , focusedBorderColor = myFocusedBorderColor
                     , manageHook         = newManageHook <+> manageDocks
                     , logHook            = myLogHook din
                     , layoutHook         = myLayouts
                     }
                     `additionalKeysP` myKeys din

newManageHook = myManageHook <+> manageHook defaultConfig <+> manageScratchPad

myWorkspaces = [supWsNum "1" "term"
               ,supWsNum "2" "web"
               ,supWsNum "3" "mail"
               ,supWsNum "4" "chat"
               ,supWsNum "5" "music"
               ,supWsNum "6" ""
               ,supWsNum "7" ""
               ,supWsNum "8" ""
               ,supWsNum "9" ""]
  where
    supWsNum wsNum wsName ="^ca(1,xdotool key Super_L+" ++ wsNum++ ") " ++ wsNum ++  "^p(;_TOP)^fn(xft:monospace:size=6)" ++ wsName ++ "  ^fn()^p()^ca()"


manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.3 
    w = 0.8     
    t = 0.9 - h
    l = 0.9 - w

myManageHook  = composeAll [ className =? "Pidgin"         --> moveTo 3
                           , className =? "Firefox"        --> moveTo 1
                           , manageDocks
                           ]
  where moveTo i = doF . W.shift $ if i == -1 then last myWorkspaces else myWorkspaces !! i

myKeys conf = [ ("M-s",        scratchpadSpawnAction defaultConfig { terminal = myTerminal })
              , ("M-<Esc>",    toggleWS)
              , ("M-u",        focusUrgent)
              ]

myNormalBorderColor = "#181818"
myFocusedBorderColor = "#707070"
myTerminal = "urxvt +sb -bg '#181818' -fg '#ddeedd'"
myLogHook h = (dynamicLogWithPP $ defaultPP
                 {  ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByTag
                  , ppCurrent = wrap "^fg(snow1)^bg(#357EC7) " " ^fg()^bg()"
                  , ppHidden  = dzenColor "snow1" "#3F3F3F"
                  , ppHiddenNoWindows  = dzenColor "#505050" "#3f3f3f"
                  , ppSep     = " ^fg(grey60) | ^fg() "
                  , ppWsSep   = " "
                  , ppLayout  = wrap "^ca(1,xdotool key Super_L+space)^ca(3,xdotool key Super_L+shift+space)" "^ca()^ca()" . dzenColor "white" ""
                  , ppTitle   = wrap "^ca(4,xdotool key Super_L+k)^ca(5,xdotool key Super_L+j)^ca(2,xdotool key Super_L+C)" "^ca()^ca()^ca()" . dzenColor "white" "" . shorten 100
                  , ppOutput  = hPutStrLn h
                  , ppUrgent = dzenColor "#181818" "#f02020"
                  }) >> updatePointer (Relative 0.95 0.95) 
                  where
                    namedOnly ws = if any (`elem` ws) ['a'..'z'] then pad ws else ""

myTheme = defaultTheme { decoHeight          = 16
                       , fontName            = "xft:Liberation Sans:size=8"
                       , activeColor         = "#357EC7"
                       , activeBorderColor   = "#181818"
                       , activeTextColor     = "white"
                       , inactiveColor       = "#3f3f3f"
                       , inactiveBorderColor = "#181818"
                       , inactiveTextColor   = "white"
                       }

myLayouts = avoidStruts $ smartBorders $
  onWorkspace (myWorkspaces !! 3) (named "IM" (reflectHoriz $ withIM (1%8) (Title "Buddy List") (reflectHoriz $ dwmStyle shrinkText myTheme tiled ||| (smartBorders $ tabs)))) $
  onWorkspace (myWorkspaces !! 0) (tabs) $
  (tabs ||| named "Mirror" (Mirror tiled) ||| tiled ||| (named "Float" (simplestFloat)))
    where
      tiled = named "Tall" (ResizableTall 1 (3/100) (1/2) [])
      tabs = named "Tabs" (tabbed shrinkText myTheme)

-- vim: ts=2 sw=2 et

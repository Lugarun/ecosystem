import XMonad
import XMonad.Actions.NoBorders(toggleBorder)
import XMonad.Actions.Navigation2D
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Actions.CycleWS(nextScreen)
import System.IO
import System.Exit
import Graphics.X11.ExtraTypes.XF86

-- Some defaults

myTerminal = "alacritty"

myLauncher   = "dmenu_run -m 1 -i"

myWorkspaces = map show [1..6]

myLayout = avoidStruts (smartSpacingWithEdge 3 emptyBSP)

myManageHook = composeAll
  [ className =? "MPlayer" --> doFloat
  ]

myAdditionalKeys = 
  [ ((mod4Mask, xK_c), spawn "i3lock -n -c 000000")
  , ((mod4Mask, xK_p), spawn myLauncher)
  , ((mod4Mask, xK_n), spawn "networkmanager_dmenu -i")
  , ((mod4Mask, xK_u), spawn "passmenu -i")
  , ((mod4Mask, xK_t), spawn "bash ~/.config/nixpkgs/profiles/xmonad/dunst/time.sh")
  , ((mod4Mask, xK_b), spawn "bash ~/.config/nixpkgs/profiles/xmonad/dunst/battery.sh")
  , ((mod4Mask, xK_v), spawn "bash ~/.config/nixpkgs/profiles/xmonad/dunst/volume.sh")
  , ((mod4Mask, xK_s), spawn "dunstctl set-paused toggle")
  , ((mod4Mask, xK_e), nextScreen)
  , ((mod4Mask, xK_w), nextScreen)
  , ((mod4Mask, xK_minus), decWindowSpacing 1)
  , ((mod4Mask, xK_equal), incWindowSpacing 1)
  , ((mod4Mask, xK_Return), spawn myTerminal)
  , ((mod4Mask .|. shiftMask , xK_q), kill)
  , ((mod4Mask .|. shiftMask , xK_Escape), io (exitWith ExitSuccess))

  , ((mod4Mask, xK_space),               sendMessage Balance)
  , ((mod4Mask .|. shiftMask, xK_space), sendMessage Equalize)
  , ((mod4Mask .|. mod1Mask,               xK_l     ), sendMessage $ ExpandTowards R)
  , ((mod4Mask .|. mod1Mask,               xK_h     ), sendMessage $ ExpandTowards L)
  , ((mod4Mask .|. mod1Mask,               xK_j     ), sendMessage $ ExpandTowards D)
  , ((mod4Mask .|. mod1Mask,               xK_k     ), sendMessage $ ExpandTowards U)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_l     ), sendMessage $ ShrinkFrom R)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_h     ), sendMessage $ ShrinkFrom L)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_j     ), sendMessage $ ShrinkFrom D)
  , ((mod4Mask .|. mod1Mask .|. controlMask , xK_k     ), sendMessage $ ShrinkFrom U)
  , ((mod4Mask,                           xK_r     ), sendMessage Rotate)
  , ((0, xF86XK_AudioLowerVolume ), spawn "amixer -q set Master 2%- unmute")
  , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer -q set Master 2%+ unmute")
  , ((0, xF86XK_AudioMute ), spawn "amixer -q set Master toggle")
  , ((0, xF86XK_AudioMicMute ), sequence_ [ spawn "amixer -q set Capture toggle"
                                          , spawn "bash ~/.config/nixpkgs/profiles/xmonad/toggleMicLight.sh"])
  , ((0, xF86XK_Favorites ), spawn "bash ~/.config/nixpkgs/profiles/xmonad/toggleTouchpad.sh")
  ]

defaults = defaultConfig
  { terminal        = myTerminal
  , modMask         = mod4Mask
  , borderWidth     = 0
  , workspaces = myWorkspaces

  -- Hooks
  , manageHook      = manageDocks <+> manageHook defaultConfig
  , layoutHook      = myLayout
  , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
  , logHook         = dynamicLogWithPP xmobarPP
      {  ppTitle = xmobarColor "green" "" . shorten 50
      , ppHiddenNoWindows = xmobarColor "grey" ""
      }
  , startupHook = spawn "bash ~/.xmonad/autostart"
  } `additionalKeys` myAdditionalKeys

main = do
  xmonad $ ewmh
         $ navigation2D def { defaultTiledNavigation = sideNavigation }
                        (xK_k, xK_h, xK_j, xK_l)
                        [(mod4Mask, windowGo),
                         (mod4Mask .|. shiftMask, windowSwap)]
                        False
         $ defaults

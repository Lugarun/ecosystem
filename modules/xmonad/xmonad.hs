import XMonad
import XMonad.Actions.NoBorders(toggleBorder)
import XMonad.Actions.SpawnOn
import XMonad.Actions.Navigation2D
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.Maximize
import XMonad.Actions.CycleWS(nextScreen)
import System.IO
import System.Exit
import Graphics.X11.ExtraTypes.XF86
import Data.Tree
import XMonad.Actions.TreeSelect
import XMonad.Hooks.WorkspaceHistory
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myTerminal = "alacritty"

myLauncher   = "dmenu_run -m 1 -i"

myTreeConf = TSConfig { ts_hidechildren = True
                      , ts_background   = 0xc01d1f21
                      , ts_font         = "xft:Sans-16"
                      , ts_node         = (0xffc5c8c6, 0xff1d1f21)
                      , ts_nodealt      = (0xffc5c8c6, 0xff1d1f21)
                      , ts_highlight    = (0xff1d1f21, 0xffc5c8c6)
                      , ts_extra        = 0xffc5c8c6
                      , ts_node_width   = 30
                      , ts_node_height  = 30
                      , ts_originX      = 60
                      , ts_originY      = 60
                      , ts_indent       = 10
                      , ts_navigate     = treeNavigation
                      }

treeNavigation = M.fromList
    [ ((0, xK_Escape), cancel)
    , ((0, xK_Return), select)
    , ((0, xK_space),  select)
    , ((0, xK_Up),     movePrev)
    , ((0, xK_Down),   moveNext)
    , ((0, xK_Left),   moveParent)
    , ((0, xK_Right),  moveChild)
    , ((0, xK_k),      movePrev)
    , ((0, xK_j),      moveNext)
    , ((0, xK_h),      moveParent)
    , ((0, xK_l),      moveChild)
    , ((0, xK_o),      moveHistBack)
    , ((0, xK_i),      moveHistForward)
    ]

myWorkspaces :: Forest String
myWorkspaces = [ Node "a" [Node "b" [], Node "c" [], Node "d" [], Node "e" []]
               , Node "f" [Node "g" [], Node "h" [], Node "i" [], Node "j" []]
               , Node "k" [Node "l" [], Node "m" [], Node "n" [], Node "o" []]
               , Node "p" [Node "q" [], Node "r" [], Node "s" [], Node "t" []]]

myLayout = avoidStruts (smartSpacingWithEdge 3 emptyBSP) ||| Full

myManageHook = composeAll
  [ className =? "MPlayer" --> doFloat
  ]

myAdditionalKeys = 
  [ ((mod4Mask, xK_c), spawn "i3lock -n -c 000000")
  , ((mod4Mask, xK_p), spawn myLauncher)
  , ((mod4Mask .|. shiftMask, xK_p), spawn "gnome-screenshot -a")
  , ((mod4Mask, xK_n), spawn "networkmanager_dmenu -i")
  , ((mod4Mask, xK_u), spawn "passmenu -i")
  , ((mod4Mask, xK_t), spawn "bash ~/workspace/nix/ecosystem/modules/xmonad/dunst/time.sh")
  , ((mod4Mask .|. shiftMask, xK_t), withFocused $ windows . W.sink)
  , ((mod4Mask, xK_b), spawn "bash ~/workspace/nix/ecosystem/modules/xmonad/dunst/battery.sh")
  , ((mod4Mask, xK_v), spawn "bash ~/workspace/nix/ecosystem/modules/xmonad/dunst/volume.sh")
  , ((mod4Mask, xK_s), spawn "dunstctl set-paused toggle")
  , ((mod4Mask, xK_e), nextScreen)
  , ((mod4Mask, xK_w), nextScreen)
  , ((mod4Mask, xK_f), treeselectWorkspace myTreeConf myWorkspaces W.greedyView)
  , ((mod4Mask .|. shiftMask, xK_f), treeselectWorkspace myTreeConf myWorkspaces W.shift)
  , ((mod4Mask, xK_minus), decWindowSpacing 1)
  , ((mod4Mask, xK_equal), incWindowSpacing 1)
  , ((mod4Mask, xK_Return), spawn myTerminal)
  , ((mod4Mask .|. shiftMask , xK_q), kill)
  , ((mod4Mask .|. shiftMask , xK_Escape), io (exitWith ExitSuccess))

  , ((mod4Mask, xK_comma),               sendMessage Balance)
  , ((mod4Mask, xK_period),               sendMessage Balance)
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
  , ((mod4Mask .|. shiftMask,             xK_r     ), sendMessage RotateL)
  , ((0, xF86XK_AudioLowerVolume ), spawn "amixer -q set Master 2%- unmute")
  , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer -q set Master 2%+ unmute")
  , ((0, xF86XK_AudioMute ), spawn "amixer -q set Master toggle")
  , ((0, xF86XK_AudioMicMute ), sequence_ [ spawn "amixer -q set Capture toggle"
                                          , spawn "bash ~/workspace/nix/ecosystem/modules/xmonad/toggleMicLight.sh"])
  , ((0, xF86XK_Favorites ), spawn "bash ~/workspace/nix/ecosystem/modules/xmonad/toggleTouchpad.sh")
  ]

defaults = defaultConfig
  { terminal        = myTerminal
  , modMask         = mod4Mask
  , borderWidth     = 0
  , workspaces = toWorkspaces myWorkspaces

  -- Hooks
  , manageHook      = manageDocks <+> manageHook defaultConfig
  , layoutHook      = myLayout
  , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
  , logHook         = workspaceHistoryHook
  , startupHook = do
      spawnOn "a" "chromium"
      spawnOn "b" "alacritty"
  } `additionalKeys` myAdditionalKeys

main = do
  xmonad $ ewmh
         $ navigation2D def { defaultTiledNavigation = sideNavigation }
                        (xK_k, xK_h, xK_j, xK_l)
                        [(mod4Mask, windowGo),
                         (mod4Mask .|. shiftMask, windowSwap)]
                        False
         $ defaults

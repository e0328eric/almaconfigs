{-# LANGUAGE OverloadedStrings #-}

--          ╭─────────────────────────────────────────────────────────╮
--          │           Almagest Xmonad configureation File           │
--          ╰─────────────────────────────────────────────────────────╯
--          ╭─────────────────────────────────────────────────────────╮
--          │                      Prerequisits                       │
--          ╰─────────────────────────────────────────────────────────╯
--          [] xmonad
--          [] xmonad-contrib
--          [] xmonad-log
--          [] dbus
--          [] ibus
--          [] kitty
--          [] nitrogen
--          [] pcloud
--          [] picom
--          [] taffybar
--          [] rofi
--          [] spectacle
--          [] vivaldi
--          [] haskell-data-default
--          [] haskell-dbus
--          [] haskell-utf8-string
--
--
--          ╭─────────────────────────────────────────────────────────╮
--          │                     Import Packages                     │
--          ╰─────────────────────────────────────────────────────────╯
import Control.Monad (forM_, join)
import Data.Default
import Data.Function (on)
import Data.List (sortBy)
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO
import System.Taffybar.Support.PagerHints (pagerHints)
import XMonad hiding ((|||))
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.FloatSnap
import XMonad.Actions.GroupNavigation
import XMonad.Actions.MouseResize
import XMonad.Actions.PhysicalScreens

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import qualified XMonad.Hooks.ManageDocks as HM
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place

-- Layout Modifiers
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.LayoutBuilder
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LimitWindows (decreaseLimit, increaseLimit, limitWindows)
import XMonad.Layout.MultiToggle (EOT(EOT), Toggle(..), (??), mkToggle, single)
import XMonad.Layout.MultiToggle.Instances
  ( StdTransformers(MIRROR, NBFULL, NOBORDERS)
  )
import XMonad.Layout.Reflect
  ( REFLECTX(..)
  , REFLECTY(..)
  , reflectHoriz
  , reflectVert
  )
import XMonad.Layout.SimpleDecoration (shrinkText)
import XMonad.Layout.Spacing
import qualified XMonad.Layout.ToggleLayouts as T
  ( ToggleLayout(Toggle)
  , toggleLayouts
  )
import XMonad.Layout.WindowArranger (WindowArrangerMsg(..), windowArrange)

-- Layouts
import XMonad.Layout.Dwindle
import XMonad.Layout.GridVariants as GV
import XMonad.Layout.IM (Property(Role), withIM)
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import XMonad.Layout.Renamed (Rename(CutWordsLeft, Replace), renamed)
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Tabbed as LT
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane
import XMonad.Layout.ZoomRow
  ( ZoomMessage(ZoomFullToggle)
  , zoomIn
  , zoomOut
  , zoomReset
  , zoomRow
  )

-- Util
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run (safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.WorkspaceCompare

--          ╭─────────────────────────────────────────────────────────╮
--          │                        Constants                        │
--          ╰─────────────────────────────────────────────────────────╯
myTerm = "kitty"

myBrowser = "vivaldi"

--          ╭─────────────────────────────────────────────────────────╮
--          │                    Main Entry Point                     │
--          ╰─────────────────────────────────────────────────────────╯
main :: IO ()
main = do
  xmproc <- spawnPipe "taffybar"
  xmonad . HM.docks . ewmh . pagerHints
    $ def
        { modMask = mod4Mask
        , layoutHook = myLayout
        , workspaces = myWorkspaces
        -- , handleEventHook = handleEventHook def <+> HM.docksEventHook
        , manageHook =
            placeHook (fixed (0.5, 0.3))
              <+> HM.manageDocks
              <+> myManageHook
              <+> myManageHook'
              <+> manageHook def
        , terminal = myTerm
        , keys = myKeysKeyboard
        , borderWidth = 5
        , mouseBindings = myKeysMouse
        , startupHook = myStartupHook
        -- This is the color of the borders of the windows themselves.
        , normalBorderColor = "#2f3d44"
        , focusedBorderColor = "#25cea7"
        }

--          ╭─────────────────────────────────────────────────────────╮
--          │                         Layouts                         │
--          ╰─────────────────────────────────────────────────────────╯
myLayout =
  HM.avoidStruts
    $ mouseResize
    $ windowArrange
    $ T.toggleLayouts floats
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
      tall
        ||| grid
        ||| threeCol
        ||| oneBig
        ||| noBorders monocle
        ||| space
        ||| floats

spacingBorder = spacingRaw True (Border 7 7 7 7) True (Border 7 7 7 7) True

tall =
  renamed [Replace "tall"]
    $ limitWindows 12
    $ spacingBorder
    $ ResizableTall 1 (3 / 100) (1 / 2) []

grid =
  renamed [Replace "grid"]
    $ limitWindows 12
    $ spacing 6
    $ mkToggle (single MIRROR)
    $ GV.Grid (16 / 10)

threeCol =
  renamed [Replace "threeCol"] $ limitWindows 3 $ ThreeCol 1 (3 / 100) (1 / 3)

oneBig =
  renamed [Replace "oneBig"]
    $ limitWindows 6
    $ spacing 6
    $ Mirror
    $ mkToggle (single MIRROR)
    $ mkToggle (single REFLECTX)
    $ mkToggle (single REFLECTY)
    $ OneBig (5 / 9) (8 / 12)

monocle = renamed [Replace "monocle"] $ limitWindows 20 Full

space =
  renamed [Replace "space"]
    $ limitWindows 4
    $ spacing 6
    $ Mirror
    $ mkToggle (single MIRROR)
    $ mkToggle (single REFLECTX)
    $ mkToggle (single REFLECTY)
    $ OneBig (2 / 3) (2 / 3)

floats = renamed [Replace "floats"] $ limitWindows 20 simplestFloat

--          ╭─────────────────────────────────────────────────────────╮
--          │                       Workspaces                        │
--          ╰─────────────────────────────────────────────────────────╯
myWorkspaces =
  ["1", "2", "3", "4", "5", "6", "7", "8", "9"] ++ map snd myExtraWorkspaces

myExtraWorkspaces = [(xK_0, "10")]

--          ╭─────────────────────────────────────────────────────────╮
--          │                       ManageHook                        │
--          ╰─────────────────────────────────────────────────────────╯
myManageHook =
  composeAll
    [ className =? "MPlayer" --> doFloat
    , className =? "Gimp" --> doFloat
    , className =? "Plugin-container" --> doFloat
    , className =? "keepassx" --> doFloat
    , className =? "Gpick" --> doFloat
    , className =? "Thunar" --> doFloat
    , className =? "Pcmanfm" --> doFloat
    , className =? "Nextcloud" --> doFloat
    , className =? "pcloud" --> doFloat
    , className =? "Civ6Sub" --> unFloat
    , className =? myBrowser --> unFloat
    , className =? "scrcpy" --> doFloat
    , className =? "Kakaotalk.exe" --> doFloat
    , resource =? "scratchpad" --> doFloat
    -- Used by Chromium developer tools, maybe other apps as well
    , role =? "pop-up" --> doFloat
    ]
  where
    role = stringProperty "WM_WINDOW_ROLE"
    unFloat = ask >>= doF . W.sink

myManageHook' = composeOne [isFullscreen -?> doFullFloat]

--          ╭─────────────────────────────────────────────────────────╮
--          │                       Keybinding                        │
--          ╰─────────────────────────────────────────────────────────╯
myKeysKeyboard :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeysKeyboard conf =
  mkKeymap conf
    $
    -- launch a terminal
     [ ("M-<Return>", spawn $ XMonad.terminal conf)
    -- close focused window
     , ("M-S-q", kill)
    --  Reset the layouts on the current workspace to default
     , ("M-S-h", setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
     , ("M-n", refresh)
    -- Window Navigation
     , ("M-<Tab>", windows W.focusDown)
     , ("M1-<Tab>", windows W.focusUp)
     , ("M-<R>", windows W.focusDown)
     , ("M-<L>", windows W.focusUp)
     , ("M-a", windows W.focusUp)
     , ("M-d", windows W.focusDown)
     , ("M-S-C-e", windows W.focusMaster)
     , ("M-S-<Tab>", windows W.swapDown)
     , ("M1-S-<Tab>", windows W.swapUp)
     , ("M-S-<R>", windows W.swapDown)
     , ("M-S-<L>", windows W.swapUp)
     , ("M-S-e", windows W.swapMaster)
     , ("M-C-M1-w", sendMessage Arrange)
     , ("M-C-M1-s", sendMessage DeArrange)
     , ("M-S-a", sendMessage Shrink)
     , ("M-S-d", sendMessage Expand)
     , ("M-S-w", sendMessage MirrorShrink)
     , ("M-S-s", sendMessage MirrorExpand)
    -- Layouts
     , ("M-<Space>", sendMessage NextLayout)
     , ("M-C-<Space>", sendMessage FirstLayout)
     , ("M-S-<Space>", sendMessage HM.ToggleStruts)
     , ("M-S-n", sendMessage $ Toggle NOBORDERS)
     , ( "M-S-<KP_Equal>"
       , sendMessage (Toggle NBFULL) >> sendMessage HM.ToggleStruts)
     , ("M-S-f", sendMessage (T.Toggle "floats"))
     , ("M-S-t", withFocused $ windows . W.sink)
     , ("M-S-o", sendMessage $ Toggle REFLECTX)
     , ("M-S-p", sendMessage $ Toggle REFLECTY)
     , ("M-S-m", sendMessage $ Toggle MIRROR)
     , ("M-k", sendMessage (IncMasterN 1))
     , ("M-j", sendMessage (IncMasterN (-1)))
     , ("M-S-k", increaseLimit)
     , ("M-S-j", decreaseLimit)
    -- Run Browser
     , ("M-S-<Return>", spawn myBrowser)
     , ("M1-S-2", spawn "spectacle")
     , ("M1-S-3", spawn "spectacle -u")
     , ("M1-S-4", spawn "spectacle -r")
     , ("C-M-s", spawn "rofi-filebrowser.sh")
     , ("C-M-d", spawn "rofi -show drun -config ~/.config/rofi/rofidmenu.rasi")
    -- End of Computer
     , ( "M-S-c"
       , spawn
           "check-twice.sh \"Are you sure you want to shutdown?\" \"poweroff\"")
     , ( "M-S-v"
       , spawn "check-twice.sh \"Are you sure you want to reboot?\" \"reboot\"")
     , ( "M-S-x"
       , spawn
           "check-twice.sh \"Are you sure you want to lock?\" \"light-locker-command -l\"")
     , ("M-S-z", io exitSuccess)
    -- Volume Settings
     , ("<XF86AudioLowerVolume>", spawn "volume_brightness.sh volume_down")
     , ("<XF86AudioRaiseVolume>", spawn "volume_brightness.sh volume_up")
     , ("<XF86AudioMute>", spawn "volume_brightness.sh volume_mute")
    -- Brightness Setting
     , ("<XF86MonBrightnessUp>", spawn "volume_brightness.sh brightness_up")
     , ("<XF86MonBrightnessDown>", spawn "volume_brightness.sh brightness_down")
     , ("M-C-S-<Right>", spawn "volume_brightness.sh brightness_up")
     , ("M-C-S-<Left>", spawn "volume_brightness.sh brightness_down")
    -- Reset xmonad
     , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
     ]
       ++ [ ("M-" ++ m ++ show k, windows $ f i)
          | (i, k) <- zip (XMonad.workspaces conf) ([1 .. 9] ++ [0])
          , (f, m) <- [(W.greedyView, ""), (W.shift, "S-")]
          ]

myKeysMouse conf@XConfig {XMonad.modMask = modMask} =
  M.fromList
    [ ( (modMask, button1)
      , \w ->
          focus w
            >> mouseMoveWindow w
            >> ifClick (snapMagicMove (Just 50) (Just 50) w))
    , ( (modMask .|. shiftMask, button1)
      , \w ->
          focus w
            >> mouseResizeWindow w
            >> ifClick (snapMagicResize [LT.R, LT.D] (Just 50) (Just 50) w))
    ]

--          ╭─────────────────────────────────────────────────────────╮
--          │                  Startup Applications                   │
--          ╰─────────────────────────────────────────────────────────╯
myStartupHook = do
  spawn "picom"
  spawn "nitrogen --restore"
  spawnOnce "ibus-daemon -rxRd"
  spawnOnce "light-locker"
  spawnOnce "xset s 480 dpms 600 600 600"
  spawnOnce "pcloud"
    -- Palm touchpad
  spawnOnce "syndaemon -i 1.0 -t -K -R"

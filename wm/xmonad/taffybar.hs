{-# LANGUAGE OverloadedStrings #-}

import System.Taffybar
import System.Taffybar.Context (TaffyIO)
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget.Battery
import System.Taffybar.Widget.Generic.PollingGraph
import System.Taffybar.Widget.Layout
import System.Taffybar.Widget.NetworkGraph
import System.Taffybar.Widget.SNITray
import System.Taffybar.Widget.SimpleClock
import System.Taffybar.Widget.Util
import System.Taffybar.Widget.Windows
import System.Taffybar.Widget.Workspaces

import Data.Default (def)
import qualified Data.Text as T

main :: IO ()
main = do
  let myTaffybarConfig =
        SimpleTaffyConfig
          { monitorsAction = usePrimaryMonitor
          , barHeight = ExactSize 50
          , barPadding = 0
          , barPosition = Top
          , widgetSpacing = 5
          , startWidgets =
              workspaces : map (>>= buildContentsBox) [windows, layout]
          , centerWidgets = []
          , endWidgets =
              map
                (>>= buildContentsBox)
                [batteryIconNew, batteryStr, clock, tray, cpu, mem, net]
          , cssPaths = []
          , startupHook = return ()
          }
      -- start widget settings
      windows = windowsNew def
      layout = layoutNew myLayoutConfig
      workspaces = workspacesNew myWorkspacesConfig
      -- end widget settings
      batteryStr = textBatteryNew "$percentage$%"
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      mem = pollingGraphNew memCfg 1 memCallback
      net = networkGraphNew netCfg Nothing
      clock = textClockNewWith def
      tray = sniTrayThatStartsWatcherEvenThoughThisIsABadWayToDoIt
  dyreTaffybar . toTaffyConfig $ myTaffybarConfig

myLayoutConfig = LayoutConfig {formatLayout = myFormatLayout}

myWorkspacesConfig =
  defaultWorkspacesConfig
    {minIcons = 1, widgetGap = 0, showWorkspaceFn = hideEmpty}

myFormatLayout :: T.Text -> TaffyIO T.Text
myFormatLayout txt = return . T.pack $ "[ " ++ T.unpack txt ++ " ]"

transparent, yellow1, yellow2, green1, green2, taffyBlue ::
     (Double, Double, Double, Double)
transparent = (0.0, 0.0, 0.0, 0.0)

yellow1 = (0.9453125, 0.63671875, 0.2109375, 1.0)

yellow2 = (0.9921875, 0.796875, 0.32421875, 1.0)

green1 = (0, 1, 0, 1)

green2 = (1, 0, 1, 0.5)

taffyBlue = (0.129, 0.588, 0.953, 1)

myGraphConfig, netCfg, memCfg, cpuCfg :: GraphConfig
myGraphConfig =
  def
    { graphPadding = 0
    , graphBorderWidth = 0
    , graphWidth = 75
    , graphBackgroundColor = transparent
    }

netCfg =
  myGraphConfig {graphDataColors = [yellow1, yellow2], graphLabel = Just "net"}

memCfg = myGraphConfig {graphDataColors = [taffyBlue], graphLabel = Just "mem"}

cpuCfg =
  myGraphConfig {graphDataColors = [green1, green2], graphLabel = Just "cpu"}

memCallback :: IO [Double]
memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback :: IO [Double]
cpuCallback = do
  (_, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

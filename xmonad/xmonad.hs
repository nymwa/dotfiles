import XMonad
import Data.Monoid
import System.Exit  -- M-S-qのため
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Actions.CycleWS    -- WorkSpace, Screenの切り替え
import XMonad.Actions.CopyWindow -- ウィンドウの複製
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks  -- 
import XMonad.Util.EZConfig      -- additional


-- XMonad
main = xmonad =<< statusBar myBar myPP toggleStructsKey myConfig

-- XMobarの設定 (M-bでバーの表示オンオフ)
myBar = "xmobar"
myPP  = xmobarPP { ppCurrent = xmobarColor "red" "" . wrap "<" ">" }
toggleStructsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

-- ワークスペース
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8" ,"9", "0"]

-- ターミナルエミュレータ
myTerminal = "gnome-terminal"

-- 基本設定
myConfig = defaultConfig
   { -- ターミナルエミュレータ
     terminal   = myTerminal
     -- modキー
   , modMask    = mod4Mask 
     -- ウィンドウの外枠の幅
   , borderWidth = 2 
     -- ウィンドウの外枠の色
   , normalBorderColor  = "#EDEDED"
   , focusedBorderColor = "#ED0000"
     -- ワークスペース
   , workspaces = myWorkspaces
     -- 新しいウィンドウが出たときにフォーカスをそちらに移動させる
   , focusFollowsMouse = True
     -- 可能なレイアウト
   , layoutHook = myLayout
     -- 新しいウィンドウを開いたときの挙動
   , manageHook = myManageHook <+> manageHook defaultConfig -- defaultも使う
     -- マウスの設定
   , mouseBindings = myMouseBindings
   } `additionalKeysP` myKeys

-- 可能なレイアウト
myLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

-- 新しいウィンドウを開いたときの挙動
myManageHook = composeAll
   [ className =? "ksysguard" --> doFloat
   ,(className =? "chromium" <&&> resource =? "Dialog") --> doFloat
   ,(role      =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
   , manageDocks
   ]
   where role = stringProperty "WM_WINDOW_ROLE"


-- ショートカットキー
myKeys =
   [
     ("M-S-<Return>", spawn myTerminal)
   , ("M-p"         , spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
   , ("M-w"         , spawn "chromium") 
   , ("M-s"         , spawn "deepin-screenshot") 
   , ("M-<Space>"   , sendMessage NextLayout)
   , ("M-S-<Space>" , sendMessage FirstLayout)
   , ("M-n"         , refresh)
   , ("M-<Tab>"     , windows W.focusDown)
   , ("M-j"         , windows W.focusDown)
   , ("M-k"         , windows W.focusUp)
   , ("M-m"         , windows W.focusMaster)
   , ("M-S-j"       , windows W.swapDown)
   , ("M-S-k"       , windows W.swapUp)
   , ("M-<Return>"  , windows W.swapMaster)
   , ("M-h"         , sendMessage Shrink) -- 縮小
   , ("M-l"         , sendMessage Expand) -- 拡大
   , ("M-t"         , withFocused $ windows . W.sink) -- タイルに戻す
   , ("M-,"         , sendMessage (IncMasterN 1))
   , ("M-."         , sendMessage (IncMasterN (-1)))
   , ("M-S-q"       , io (exitWith ExitSuccess))
   , ("M-q"         , spawn "xmonad --recompile; xmonad --restart")
   , ("<XF86AudioMute>"         , spawn "amixer -c 0 sset Master off; amixer -c 0 sset Master 0%")
   , ("<XF86AudioLowerVolume>"  , spawn "amixer -c 0 sset Headphone on; amixer -c 0 sset Master {on,3%-}")
   , ("<XF86AudioRaiseVolume>"  , spawn "amixer -c 0 sset Headphone on; amixer -c 0 sset Master {on,3%+}")
   , ("<XF86MonBrightnessDown>" , spawn "light -U 10")
   , ("<XF86MonBrightnessUp>"   , spawn "light -A 10")
   , ("<Print>"                 , spawn "deepin-screenshot")
   ]
   ++
   [
     ("M-<L>"       , prevWS)
   , ("M-<R>"       , nextWS)
   , ("M-<U>"       , prevScreen)
   , ("M-<D>"       , nextScreen)
   , ("M-S-<L>"     , shiftToPrev >> prevWS)
   , ("M-S-<R>"     , shiftToNext >> nextWS)
   , ("M-S-<U>"     , shiftPrevScreen)
   , ("M-S-<D>"     , shiftNextScreen)
   ]
   ++
   [ ("M-" ++ otherModMasks ++ [key], action tag)
      | (tag, key)  <- zip myWorkspaces "1234567890"
      , (otherModMasks, action) <- [ (""    , windows . W.view)
                                   , ("S-"  , windows . W.shift)]
   ]

-- マウスの設定
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Mod + 左クリックで移動
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- Mod + 中クリックでタイルの先頭に
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- Mod + 右クリックでリサイズ
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

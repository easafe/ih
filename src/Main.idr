module Main

import SDL as S
import SDL.Types
import Data.SortedMap as DS
import SDL.Foreign
import Control.Linear.LIO as LIO
import System as SS

import Renderer as R
import Level.Types
import State as ST
import Level.Basics as LC
import Player as P
import Level.Prefab.Room as LPR
import Types

defaultWindowOpts : SDLWindowOptions
defaultWindowOpts = MkSDLWindowOptions "ih" SDLWindowPosCentered SDLWindowPosCentered 1024 768 [] --[SDLWindowBorderless, SDLWindowFullscreenDesktop, SDLWindowBorderless]

putError : LinearIO io => (err : SDLError) -> L io ()
putError = putStrLn . show

onKeyEvent : LinearIO io => (event : SDLKeyboardEvent) -> L io ()
onKeyEvent evt = case evt.keycode of
      KeyR => pure ()
      _ => pure ()

--https://dewitters.com/dewitters-gameloop/
loop : (LinearIO io, Ref Current CurrentState) => (1 _ : SDL WithRenderer) -> L {use = 1} io (SDL WithRenderer)
loop s = LIO.do
      S.delaySDL 32
      pp <- S.pollEvent
      case pp of
            Just (SDLQuit ** ()) => LIO.pure1 s
            Just (SDLKeyUp ** evt) => LIO.do
                  s <- R.draw s
                  s <- render s
                  loop s
            _ => LIO.do
                  s <- R.draw s
                  s <- render s
                  loop s

run' : (LinearIO io, Ref Current CurrentState) => L io ()
run' = S.initSDL [SDLInitVideo] (\err => putStrLn $ "Fatal error: " ++ show err) $ \s => do
      Success s <- S.newWindow defaultWindowOpts s
            | Failure s err => S.handleInitedError s (putError err)

      Success s <- S.newRenderer Nothing [SDLRendererSoftware] s
            | Failure s err => S.handleWindowedError s (putError err)

      s <- R.draw s
      s <- render s
    --  s <- loop s
      SS.sleep 40

      s <- S.closeRenderer s
      s <- S.closeWindow s
      S.quitSDL s

main : IO ()
main = LIO.run $ do
            room <- LPR.create
            ST.newRef Current (MakeCurrentState Room room DS.empty P.create)
            run'


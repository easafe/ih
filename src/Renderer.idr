module Renderer

import Control.Linear.LIO as L
import SDL as S
import SDL.Types
import SDL.Foreign
import Renderer.Colors
import Data.Nat
import Data.List as DL
import Level.Basics
import Character as C
import Types

import Types
import State as ST

putError : LinearIO io => (err : SDLError) -> L io ()
putError = putStrLn . show

baseSize : Int
baseSize = 16

drawAt : (LinearIO io, Ref Current CurrentState) => Coordinate -> (1 _ : SDL WithRenderer) -> L {use = 1} io (SDL WithRenderer)
drawAt (x, y) s = L.do
      let rect = MkRect (cast x * baseSize) (cast y * baseSize) baseSize baseSize
      Success s <- S.fillRect rect s
            | Failure s err => L.do putError err; L.pure1 s
      L.pure1 s

drawLevel : (LinearIO io, Ref Current CurrentState) => List CoordinateFeature -> (1 _ : SDL WithRenderer) -> L {use = 1} io (SDL WithRenderer)
drawLevel  [] s = L.pure1 s
drawLevel ((coordinate, Wall) :: fs) s = L.do
      Success s <- S.setColor dimgray s
            | Failure s err => do putError err; pure1 s
      s <- drawAt coordinate s
      drawLevel fs s
drawLevel ((coordinate, Floor) :: fs) s = L.do
      Success s <- S.setColor gray s
            | Failure s err => do putError err; pure1 s
      s <- drawAt coordinate s
      drawLevel fs s
drawLevel ((coordinate, Door _) :: fs) s = L.do
      Success s <- S.setColor brown s
            | Failure s err => do putError err; pure1 s
      s <- drawAt coordinate s
      drawLevel fs s
drawLevel ((coordinate, _) :: fs) s = L.do
      Success s <- S.setColor black s
            | Failure s err => do putError err; pure1 s
      s <- drawAt coordinate s
      drawLevel fs s

drawCharacters : (LinearIO io, Ref Current CurrentState) => List Character -> (1 _ : SDL WithRenderer) -> L {use = 1} io (SDL WithRenderer)
drawCharacters [] s = L.pure1 s
drawCharacters (character :: cs) s = L.do
      Success s <- S.setColor green s
            | Failure s err => L.do putError err; L.pure1 s
      s <- drawAt (C.position character) s
      drawCharacters cs s

drawPlayer : (LinearIO io, Ref Current CurrentState) => Player -> (1 _ : SDL WithRenderer) -> L {use = 1} io (SDL WithRenderer)
drawPlayer player s = L.do
      Success s <- S.setColor red s
            | Failure s err => L.do putError err; L.pure1 s
      s <- drawAt player.position s
      L.pure1 s

export
draw : (LinearIO io, Ref Current CurrentState) => (1 _ : SDL WithRenderer) -> L {use = 1} io (SDL WithRenderer)
draw s = L.do
      Success s <- S.setColor black s
            | Failure s err => L.do putError err; L.pure1 s
      Success s <- S.clear s
            | Failure s err => L.do putError err; L.pure1 s
      current <- ST.get Current
      s <- drawLevel current.level.features s
      s <- drawCharacters current.level.characters s
      s <- drawPlayer current.player s
      L.pure1 s

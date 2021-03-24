module Events

import SDL as S
import SDL.Types
import SDL.Foreign as SF
import Control.Linear.LIO as L

import State as ST
import Types
import Character as C

export
processInput : (LinearIO io, Ref Current CurrentState) => SDLKeyboardEvent -> L io ()
processInput event = L.do
      state <- ST.get Current
      case event.keycode of
            Right => ST.modify Current (move (P state.player) (to Right event.mod ))
            Left => ST.modify Current (move (P state.player) (to Left event.mod ))
            Up => ST.modify Current (move (P state.player) Top)
            Down => ST.modify Current (move (P state.player) Down)
            _ => pure ()
      where to : Direction -> List Keymod -> Direction
            to side modifiers =
                  if modifiers == [RShift] || modifiers == [LShift] then
                        if side == Right then TopRight else TopLeft
                   else if modifiers == [RCtrl] || modifiers == [LCtrl] then
                        if side == Right then DownRight else DownLeft
                   else
                        side

            move : Character -> Direction -> CurrentState -> CurrentState
            move character direction state = case C.move character direction state of
                  P p => record { player = p } state
                  _ => state
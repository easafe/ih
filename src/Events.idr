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
            Right => ST.modify Current (C.move (P state.player) Right)
            Left => ST.modify Current (C.move (P state.player) Left)
            Up => ST.modify Current (C.move (P state.player) Top)
            Down => ST.modify Current (C.move (P state.player) Down)
            _ => pure ()
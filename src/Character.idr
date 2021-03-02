module Character

import Types
import Level as L

export
position : Character -> Coordinate
position character = case character of
      N npc => npc.position
      P player => player.position

export
move : Character -> Direction -> CurrentState -> CurrentState
move character direction state = case character of
      N npc => state
      P player => case L.move direction state.player.position of
            Nothing => state
            Just p =>
                  if L.isAvailable p state then
                        record { player.position = p } state
                   else
                        state
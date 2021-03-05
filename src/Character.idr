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
      P player => case L.move state.player.position direction state of
            Left _ => state
            Right (coordinate, feature) =>
                  if feature == Solid || feature == Wall then
                        state
                   else
                        record { player.position = coordinate } state

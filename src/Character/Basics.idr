module Character.Basics

import Types

export
position : Character -> Coordinate
position character = case character of
      N npc => npc.position
      P player => player.position

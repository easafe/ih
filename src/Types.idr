module Types

import Data.SortedMap as DS

import public Level.Types
import public Npc.Types
import public State.Types
import public Player.Types

public export
record CurrentState where
      constructor MakeCurrentState
      area : Area
      level: Level
      levels : SortedMap Area Level
      player: Player


module Types

import Data.SortedMap as DS

import public Level.Types
import public State.Types
import public Character.Types
import SDL.Keysym

export
data Current : Type where

public export
record CurrentState where
      constructor MakeCurrentState
      area : Area
      level: Level
      levels : SortedMap Area Level
      player : Player


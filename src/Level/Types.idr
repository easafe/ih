module Level.Types

import Data.List as L
import Data.SortedMap as M


import Character.Types

public export
Coordinate : Type
Coordinate = (Nat, Nat)

public export
data Area = Room | Hall | Easy | Medium | Hard

public export
data Direction = Left | Right | Top | TopRight | TopLeft | Down | DownRight | DownLeft

export
Eq Direction where
      Left == Left = True
      Right == Right = True
      Top == Top = True
      TopRight == TopRight = True
      TopLeft == TopLeft = True
      Down == Down = True
      DownRight == DownRight = True
      DownLeft == DownLeft = True
      _ == _ = False

export
Eq Area where
      Room == Room = True
      Hall == Hall = True
      Easy == Easy = True
      Medium == Medium = True
      Hard == Hard = True
      _ == _ = False

export
Ord Area where
      compare Room Room = EQ
      compare Room Hall = LT
      compare Room Easy = LT
      compare Room Medium = LT
      compare Room Hard = LT
      compare Hall Hall = EQ
      compare Hall Easy = LT
      compare Hall Medium = LT
      compare Hall Hard = LT
      compare Easy Hall = LT
      compare Easy Easy = EQ
      compare Easy Medium = LT
      compare Easy Hard = LT
      compare Medium Medium = EQ
      compare Medium Hard = LT
      compare Hard Hard = EQ
      compare _ _ = GT

--we can type room names better

public export
data Feature = Solid | Floor | Wall | Door (Area, String)

export
Eq Feature where
      Solid == Solid = True
      Floor == Floor = True
      Wall == Wall = True
      Door (area, level) == Door (otherArea, otherLevel) = area == otherArea && level == otherLevel
      _ == _ = False

public export
CoordinateFeature : Type
CoordinateFeature = (Coordinate, Feature)

public export
record Level where
      constructor MakeLevel
      name : String
      area : Area
      features : List CoordinateFeature
      characters : List Character

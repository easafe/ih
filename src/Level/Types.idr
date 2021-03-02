module Level.Types

import Data.Vect as V
import Data.List as L
import Character.Types
import Data.SortedMap as M

public export
Coordinate : Type
Coordinate = (Nat, Nat)

public export
data Area = Room | Hall | Easy | Medium | Hard

public export
data Direction = Left | Right | Top | TopRight | TopLeft | Down | DownRight | DownLeft

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

public export
record Level where
      constructor MakeLevel
      name : String
      area : Area
      features : List Feature
      characters : List Character

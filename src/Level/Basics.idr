module Level.Basics

import Types
import Data.List as DL
import Level.Types
import Character.Types

export
width : Nat
width = 56 -- 1024 / 16 - 8

export
height : Nat
height = 44 -- 768 / 16 - 4

export
emptyLevel : String -> Area -> Level
emptyLevel name area = MakeLevel {name = name, area = area, features = (DL.replicate (width * height) Solid), characters = [] }
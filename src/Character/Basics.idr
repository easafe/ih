module Character.Basics

import Character.Types
import Level.Types

--likey to want to use lens

public export
what : { w : Type } -> Maybe w  -> Type
what m = case m of
      Nothing => w
      Just _ => Character

export
position : {default Nothing new : Maybe Coordinate} -> Character -> what new
position character = case character of
      N common => case new of
            Nothing => common.position
            Just p => N $ record { position = p } common
      P common => case new of
            Nothing => common.position
            Just p => P $ record { position = p } common


module Character

import Types
import Level as L
import Character.Basics as CB

export
move : Character -> Direction -> CurrentState -> Character
move character direction state = case L.move (CB.position character) direction state of
      Left _ => character
      Right (coordinate, feature) =>
            if feature == Solid || feature == Wall then
                  character
             else CB.position { new = Just coordinate } character

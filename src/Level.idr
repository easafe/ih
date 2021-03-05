module Level

import Types
import Level.Basics
import Data.List as DL
import Level.Features as LF
import Character.Basics as CB

to : Direction -> Coordinate -> Maybe Coordinate
to direction (x, y) = case direction of
      Left => case x of
            Z => Nothing
            S k => Just (k, y)
      Right =>
            if x + 1 == width then Nothing else Just (x + 1, y)
      Top =>
            if y + 1 == height then Nothing else Just (x, y + 1)
      TopRight =>
            if y + 1 == height || x + 1 == width then Nothing else Just (x + 1, y + 1)
      TopLeft => case x of
            Z => Nothing
            S k => if y + 1 == height then Nothing else Just (k, y + 1)
      Down => case y of
            Z => Nothing
            S k => Just (x, k)
      DownRight => case y of
            Z => Nothing
            S k => if x + 1 == width then Nothing else Just (x + 1, k)
      DownLeft => case x of
            Z => Nothing
            S k => case y of
                  Z => Nothing
                  S l => Just (k, l)

at : Coordinate -> CurrentState -> Either Character Feature
at coordinate state =
      if state.player.position == coordinate then
            Left $ P state.player
       else case DL.find ( (coordinate ==) . CB.position) state.level.characters of
            Just character => Left character
            Nothing => Right $ LF.index coordinate state.level.features

export
move : Coordinate -> Direction -> CurrentState -> Either Character CoordinateFeature
move from direction state =
      case to direction from of
            Nothing => Right (from, Solid)
            Just coordinate => map (\feature => (coordinate, feature)) $ at coordinate state


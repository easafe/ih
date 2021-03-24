module Level

import Types
import Level.Basics
import Data.List as DL
import Data.List.Elem
import Level.Index as LI
import Character.Basics as CB

to : Direction -> Coordinate -> Maybe Coordinate
to direction (x, y) = case direction of
      Left => case x of
            Z => Nothing
            S k => Just (k, y)
      Right =>
            if x + 1 == width then Nothing else Just (x + 1, y)
      Top => case y of
            Z => Nothing
            S k => Just (x, k)
      TopRight => case y of
            Z => Nothing
            S k => if x + 1 == width then Nothing else Just (x + 1, k)
      TopLeft => case x of
            Z => Nothing
            S k => case y of
                  Z => Nothing
                  S l => Just (k, l)
      Down =>
            if y + 1 == height then Nothing else Just (x, y + 1)
      DownRight =>
            if y + 1 == height || x + 1 == width then Nothing else Just (x + 1, y + 1)
      DownLeft => case x of
            Z => Nothing
            S k => if y + 1 == height then Nothing else Just (k, y + 1)

at : Coordinate -> CurrentState -> Either Character Feature
at coordinate state =
      case DL.find ((coordinate ==) . position) (P state.player :: state.level.characters) of
            Just character => Left character
            Nothing => Right $ LI.index coordinate state.level.features

export
move : Coordinate -> Direction -> CurrentState -> Either Character CoordinateFeature
move from direction state =
      case to direction from of
            Nothing => Right (from, Solid)
            Just coordinate => map (\feature => (coordinate, feature)) $ at coordinate state


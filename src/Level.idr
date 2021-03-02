module Level

import Types
import Level.Basics

export
move : Direction -> Coordinate -> Maybe Coordinate
move direction (x, y) = case direction of
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

export
isAvailable : Coordinate -> CurrentState -> Bool
isAvailable (x, y) state =
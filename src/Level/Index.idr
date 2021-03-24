module Level.Index

import Types
import Data.List as DL

--we prolly dont want linked lists to represent levels

export
updateIndexes : List CoordinateFeature -> List CoordinateFeature -> List CoordinateFeature
updateIndexes changes list = foldl go list changes
      where go : List CoordinateFeature -> CoordinateFeature -> List CoordinateFeature
            go list cf@(coordinate, feature) = case list of
                  [] => []
                  x@(c, _) :: xs =>
                        if c == coordinate then
                              (c, feature) :: xs
                         else
                              x :: go xs cf

export
index : Coordinate -> List CoordinateFeature -> Feature
index coordinate features = case DL.find ((coordinate ==) . fst) features of
      Nothing => Solid
      Just (_, feature) => feature

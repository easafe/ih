module Level.List

import Level.Types as LT
import public Data.List as DL
import Level.Basics as LC

--we prolly dont want linked lists to represent levels

update : List Feature -> (Nat, Nat, Feature) -> List Feature
update list (x, y, feature) = go (LC.width * y + x) list
      where go : Nat -> List Feature -> List Feature
            go _ [] = []
            go 0 (z :: xs) = feature :: xs
            go (S k) (z :: xs) = z :: go k xs

export
updateIndexes : List (Nat, Nat, Feature) -> List Feature -> List Feature
updateIndexes changes vector = foldl update vector changes


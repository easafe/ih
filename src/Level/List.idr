module Level.List

import Types
import Level.Basics as LC
import Data.List as DL
--import Data.Fin as DF

--we prolly dont want linked lists to represent levels

makeIndex : Nat -> Nat -> Nat
makeIndex x y = LC.width * y + x

update : List Feature -> (Nat, Nat, Feature) -> List Feature
update list (x, y, feature) = go (makeIndex x y) list
      where go : Nat -> List Feature -> List Feature
            go _ [] = []
            go 0 (z :: xs) = feature :: xs
            go (S k) (z :: xs) = z :: go k xs

export
updateIndexes : List (Nat, Nat, Feature) -> List Feature -> List Feature
updateIndexes changes vector = foldl update vector changes

index : Coordinate -> List Feature -> Feature
index (x, y) features = DL.index (makeIndex x y) features

-- u : { h : Nat } -> Vect (LC.width * h + w) Feature -> (Fin w, Fin h, Feature) -> Vect (LC.width * h + w) Feature
-- u vect (x, y, feature) = DV.replaceAt (DF.shift (LC.width * h) x) feature vect

-- ui : { h : Nat } -> Vect n (Fin w, Fin h, Feature) -> Vect (LC.width * h + w) Feature -> Vect (LC.width * h + w) Feature
-- ui changes vector = foldl u vector changes


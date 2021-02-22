module Level.Prefab.Room

import Level.Types
import Level.Basics as LB
import Level.List as LL
import Npc.TestTaker as NT

export
create : HasIO io => io Level
create = do
      pure room
      where
            --should come from file
            roomFeatures : List (Nat, Nat, Feature)
            roomFeatures = [(0, 0, Wall), (0, 1, Wall), (0, 2, Wall), (0, 3, Wall), (0, 4, Wall), (0, 5, Wall), (0, 6, Wall),
                            (1, 0, Wall), (2, 0, Wall), (3, 0, Wall), (4, 0, Wall), (5, 0, Wall), (6, 0, Wall),
                            (1, 1, Floor), (2, 2, Floor), (3, 3, Floor), (4, 5, Floor),
                            (1, 2, Floor), (1, 3, Floor), (1, 4, Floor), (1, 5, Floor),
                            (2, 1, Floor), (2, 3, Floor), (2, 4, Floor), (2, 5, Floor),
                            (3, 1, Floor), (3, 2, Floor), (3, 4, Floor), (3, 5, Floor),
                            (4, 1, Floor), (4, 2, Floor), (4, 3, Floor), (4, 4, Floor),
                            (5, 1, Floor), (5, 2, Floor), (5, 3, Floor), (5, 4, Floor), (5, 5, Floor),
                            (6, 0, Wall), (6, 1, Wall), (6, 2, Wall), (6, 3, Door (Hall, "hall")), (6, 4, Wall), (6, 5, Wall),
                            (1, 6, Wall), (2, 6, Wall), (3, 6, Wall), (4, 6, Wall), (5, 6, Wall), (6, 6, Wall)]

            room : Level
            room = record {
                        features $= LL.updateIndexes roomFeatures,
                        npcs = [NT.create]
                  } (LB.emptyLevel "room" Room)
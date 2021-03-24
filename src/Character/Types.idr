module Character.Types

public export
record Npc where
      constructor MakeNpc
      position : (Nat, Nat)

-- public export
-- record Mob where
--       constructor MakeMob
--       position : (Nat, Nat)

public export
record Player where
      constructor MakePlayer
      position : (Nat, Nat)

public export
data Character = N Npc | P Player

module Character.Types

public export
record Npc where
    constructor MakeNpc
    position : (Nat, Nat)
    letter : String

public export
record Player where
    constructor MakePlayer
    position : (Nat, Nat)
    letter : String

public export
data Character = P Player | N Npc
module Npc.Types

public export
record Npc where
    constructor MakeNpc
    position : (Nat, Nat)
    letter : String
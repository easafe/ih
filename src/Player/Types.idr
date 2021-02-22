module Player.Types

public export
record Player where
    constructor MakePlayer
    position : (Nat, Nat)
    letter : String
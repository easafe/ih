module Character.Player

import Types

export
create : Player
create = MakePlayer { position = (4, 5), letter = "@" }



module State.Types

import Data.IORef as DI

export
data Current : Type where -- Label for State

public export
data Ref : (l : label) -> Type -> Type where
      [search l]
      MakeRef : IORef a -> Ref x a
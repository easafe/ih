module State.Types

import Data.IORef as DI

public export
data Ref : (l : label) -> Type -> Type where
      [search l]
      MakeRef : IORef a -> Ref x a
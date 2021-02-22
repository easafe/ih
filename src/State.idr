module State

import Data.IORef as DI
import State.Types

export
newRef : HasIO io => (x : label) -> t -> io (Ref x t)
newRef x val = do
      ref <- liftIO $ DI.newIORef val
      pure (MakeRef ref)

export %inline
get : HasIO io => (x : label) -> {auto ref : Ref x a} -> io a
get x {ref = MakeRef io} = liftIO $ DI.readIORef io

export %inline
put : HasIO io => (x : label) -> {auto ref : Ref x a} -> a -> io ()
put x {ref = MakeRef io} val = liftIO $ DI.writeIORef io val

export %inline
modify : HasIO io => (x : label) -> {auto ref : Ref x a} -> (a -> a) -> io ()
modify x f = do
      ref <- get x
      put x (f ref)
module Main (main) where

newtype CustomT m a = CustomT
  { runCustomT :: m a
  }

mapCustomT :: (m a -> n b) -> CustomT m a -> CustomT n b
mapCustomT f = CustomT . f . runCustomT

liftCustomT :: m a -> CustomT m a
liftCustomT = CustomT

instance Functor m => Functor (CustomT m) where
  fmap f = mapCustomT (fmap f)

{-
  TODO: impl Applicative instance
  - [x] pure
  - <*> / liftA2
-}
instance Applicative m => Applicative (CustomT m) where
  pure = liftCustomT . pure

{-
  TODO: impl Monad instance
  - [x] return
  - [ ] >>=
-}
instance Monad m => Monad (CustomT m) where
  return = liftCustomT . return

main :: IO ()
main = return ()

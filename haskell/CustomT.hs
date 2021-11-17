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
  - [x] <*>
-}
instance Applicative m => Applicative (CustomT m) where
  pure = liftCustomT . pure
  f <*> x = CustomT $ runCustomT f <*> runCustomT x

{-
  TODO: impl Monad instance
  - [x] return
  - [x] >>=
-}
instance Monad m => Monad (CustomT m) where
  return = liftCustomT . return
  m >>= k = CustomT $ do
    a <- runCustomT m
    runCustomT $ k a

main :: IO ()
main = return ()

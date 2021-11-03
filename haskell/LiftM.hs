module LiftM
  ( liftM
  , liftM2
  , liftM3
  ) where

liftM
  :: Monad m
  => (a -> b)
  -> m a
  -> m b
liftM f mx = do
  x <- mx
  return (f x)

liftM2
  :: Monad m
  => (a -> b -> c)
  -> m a
  -> m b
  -> m c
liftM2 f mx my = do
  x <- mx
  y <- my
  return (f x y)

liftM3
  :: Monad m
  => (a -> b -> c -> d)
  -> m a
  -> m b
  -> m c
  -> m d
liftM3 f mx my mz = do
  x <- mx
  y <- my
  z <- mz
  return (f x y z)

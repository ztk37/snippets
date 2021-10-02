{-# Language DeriveFunctor #-}

module Main (main) where

{-

A Haskell free monad is a list of functors. Compare:

data List a   = Nil    | Cons  a (List a  )
data Free f r = Pure r | Free (f (Free f r))

-}

data Free f a
  = Pure a
  | Free (f (Free f a))

instance Functor f => Functor (Free f) where
  fmap f (Pure a) = Pure (f a)
  fmap f (Free x) = Free (fmap (fmap f) x)
  -- fmap g (Free fx) = Free (fmap g <$> fx)

instance Functor f => Applicative (Free f) where
  pure = Pure
  (Pure f) <*> (Pure x) = pure $ f x
  (Pure f) <*> (Free wwx) = Free ((f <$>) <$> wwx)
  (Free wwf) <*> ax = Free ((<*> ax) <$> wwf)

instance Functor f => Monad (Free f) where
  return = Pure
  x >>= f = concatFree (fmap f x)

liftFree :: Functor f => f a -> Free f a
liftFree x = Free (fmap Pure x)

foldFree :: Functor f => (f r -> r) -> Free f r -> r
foldFree _ (Pure a) = a
foldFree f (Free x) = f (fmap (foldFree f) x)

concatFree :: Functor f => Free f (Free f a) -> Free f a
concatFree (Pure x) = x
concatFree (Free y) = Free (fmap concatFree y)

data EffectF next
  = EffEcho String next
  -- deriving (Functor)

-- instance Functor EffectF where
--  fmap g (EffEcho s next) = _ -- EffEcho s (g . next) 

instance Functor EffectF where
  fmap g (EffEcho s next) = EffEcho s (g next)


type Effect = Free EffectF

echo s = liftFree $ EffEcho s

main :: IO ()
main = putStrLn "Hello, World!"

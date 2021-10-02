module Main (main) where

data Wrap a = Wrap
  { unWrap :: a
  } deriving (Eq, Show)

instance Semigroup a => Semigroup (Wrap a) where
  (Wrap xs) <> (Wrap ys) = Wrap (xs <> ys)

instance Monoid a => Monoid (Wrap a) where
  mempty = Wrap mempty
  mappend = (<>)

instance Functor Wrap where
  fmap f (Wrap x) = Wrap $ f x

instance Applicative Wrap where
  pure = Wrap
  Wrap fx <*> x = fmap fx x

instance Monad Wrap where
  return = Wrap
  Wrap mx >>= k = k mx

instance Foldable Wrap where
  foldr f z (Wrap x) = f x z
  foldl f z (Wrap x) = f z x

instance Traversable Wrap where
  traverse f (Wrap x) = Wrap <$> f x

main :: IO ()
main = return ()

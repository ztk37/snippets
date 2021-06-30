import Data.Monoid

newtype WrapM a = WrapM
  { unWrapM :: a
  } deriving (Show)

instance Semigroup a => Semigroup (WrapM a) where
  WrapM a <> WrapM b = WrapM (a <> b)

instance Monoid a => Monoid (WrapM a) where
  mempty = WrapM mempty
  WrapM a `mappend` WrapM b = WrapM (a `mappend` b)

instance Functor WrapM where
  fmap f (WrapM x) = WrapM (f x)

instance Applicative WrapM where
  pure = WrapM
  WrapM f <*> mx = fmap f mx

instance Monad WrapM where
  return = pure
  WrapM a >>= k = k a

initial :: WrapM (Sum Int)
initial = pure mempty

cps :: Int -> Int -> ((Int -> Int) -> Int)
cps a b = go
  where 
    go :: (Int -> Int) -> Int
    go f = f (a + b)

main :: IO ()
main = print initial

newtype Wrap a = Wrap
  { unWrap :: [a] } deriving (Show)

instance Functor Wrap where
  fmap f (Wrap x) = Wrap (fmap f x)

newtype Sub a = Sub
  {unSub :: a } deriving (Show)

instance Functor Sub where
  fmap f (Sub x) = Sub (f x)

wrap :: Wrap (Sub Integer)
wrap = Wrap $ map Sub [0..10]

main :: IO ()
main = print $ (fmap . fmap) (*4) wrap

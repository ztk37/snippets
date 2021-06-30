{-# LANGUAGE BangPatterns #-}

data WriteTree w
  = NilWrites
  | SomeWrite w
  | MergeWrites (WriteTree w) (WriteTree w)
  deriving (Show)

instance Functor WriteTree where
  fmap _ (NilWrites) = NilWrites 
  fmap f (SomeWrite w) = SomeWrite (f w)
  fmap f (MergeWrites tw1 tw2) = MergeWrites (fmap f tw1) (fmap f tw2)

instance Semigroup (WriteTree w) where
  (<>) = appendWTs

instance Monoid (WriteTree w) where
  mempty = NilWrites

appendWTs :: WriteTree w -> WriteTree w -> WriteTree w
appendWTs NilWrites w = w
appendWTs w NilWrites = w
appendWTs w1 w2 = MergeWrites w1 w2

-- This function must be called at the end of the Haxl computation to get
-- a list of writes.
-- Haxl provides no guarantees on the order of the returned logs.
flattenWT :: WriteTree w -> [w]
flattenWT = go []
  where
    go !ws NilWrites = ws
    go !ws (SomeWrite w) = w : ws
    go !ws (MergeWrites w1 w2) = go (go ws w2) w1

dummyWrites :: [WriteTree Int]
dummyWrites =
  [ SomeWrite 1
  , SomeWrite 1
  , SomeWrite 1
  , NilWrites
  , NilWrites
  , NilWrites
  , SomeWrite 1
  , SomeWrite 1
  , NilWrites
  , SomeWrite 1
  , NilWrites
  ]

foldedWrites :: WriteTree Int
foldedWrites = foldr appendWTs NilWrites dummyWrites
  
main :: IO ()
main = print $ flattenWT foldedWrites

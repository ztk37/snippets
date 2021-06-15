import Control.Monad.Writer

data Sub = Sub
  { subA :: [String]
  , subB :: [String]
  , subC :: [String]
  } deriving (Show)

instance Semigroup Sub where
  (Sub a b c) <> (Sub a' b' c') =
    Sub (a <> a') (b <> b') (c <> c')

instance Monoid Sub where
  mempty = Sub [] [] []
  mappend = (<>)

data InternalData = InternalData
  { fieldA :: Sub
  , fieldB :: [String]
  , fieldC :: [String]
  } deriving (Show)

instance Semigroup InternalData where
  (InternalData a b c) <> (InternalData a' b' c') =
    InternalData (a <> a') (b <> b') (c <> c')

instance Monoid InternalData where
  mempty = InternalData mempty [] []
  mappend = (<>)

-- mempty can be used to let the compiler detect the type. in this case InternalData
-- InternalData is a record. So we can use record { ... } to update them.

tellASA :: String -> Writer InternalData ()
tellASA item =
  tell $ mempty { fieldA = mempty { subB = [item]}}

tellASB :: String -> Writer InternalData ()
tellASB item =
  tell $ mempty { fieldA = mempty { subB = [item] }}

tellASC :: String -> Writer InternalData ()
tellASC item =
  tell $ mempty { fieldA = mempty { subB = [item]}}

tellB :: String -> Writer InternalData ()
tellB item = tell $ mempty { fieldB = [item]}

tellC :: String -> Writer InternalData ()
tellC item = tell $ mempty { fieldC = [item]}

run0 :: Writer InternalData ()
run0 = (tellASA "foo")
  >>= const ((tellASA "bar"))
  >>= (const (tellB "fib"))

run1 :: Writer InternalData ()
run1 = do
  tellASA "foo"
  tellASA "bar"
  tellB "fib"

main :: IO ()
main = do
  print $ execWriter run0
  print $ execWriter run1

import Control.Monad.Writer

data InternalData = InternalData
  { fieldA :: [String]
  , fieldB :: [String]
  , fieldC :: [String]
  } deriving (Show)

instance Semigroup InternalData where
  (InternalData a b c) <> (InternalData a' b' c') =
    InternalData (a <> a') (b <> b') (c <> c')

instance Monoid InternalData where
  mempty = InternalData [] [] []
  mappend = (<>)

-- mempty can be used to let the compiler detect the type. in this case InternalData
-- InternalData is a record. So we can use record { ... } to update them.

tellA :: String -> Writer InternalData ()
tellA item = tell $ mempty { fieldA = [item]}

tellB :: String -> Writer InternalData ()
tellB item = tell $ mempty { fieldB = [item]}

tellC :: String -> Writer InternalData ()
tellC item = tell $ mempty { fieldC = [item]}

run0 :: Writer InternalData ()
run0 = (tellA "foo")
  >>= const ((tellA "bar"))
  >>= (const (tellB "fib"))

run1 :: Writer InternalData ()
run1 = do
  tellA "foo"
  tellA "bar"
  tellB "fib"
main :: IO ()
main = do
  print $ execWriter run0
  print $ execWriter run1

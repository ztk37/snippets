newtype Wrap a = Wrap
  { unWrap :: a
  } deriving Show

instance Functor Wrap where
  fmap f (Wrap x) = Wrap (f x)

instance Applicative Wrap where
  pure = Wrap
  Wrap f <*> x = fmap f x

instance Monad Wrap where
  return = Wrap
  Wrap x >>= k = k x

data Options = Options
  { optA :: String
  , optB :: Int
  , optC :: Bool
  } deriving Show

defaultA :: Wrap String
defaultA = Wrap "(default)"

defaultB :: Wrap Int
defaultB = Wrap 42

defaultC :: Wrap Bool
defaultC = Wrap True

options :: Wrap Options
options = Options
  <$> Wrap "Foo"
  <*> Wrap 42
  <*> Wrap True

options1 :: Wrap Options
options1 =
  Options
    <$> defaultA
    <*> defaultB
    <*> defaultC

main :: IO ()
main = do
  print $ unWrap options

  -- IO (String -> String)
  input <-  (++) <$> getLine <*> getLine
  print input

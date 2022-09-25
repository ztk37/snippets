import Control.Monad.Writer
import Data.Monoid (Endo(..))

type WriteM a = Writer (Endo a) ()

data XYZ = X A | Y B | Z C
  deriving (Eq, Show)

class HasName a where
  name :: String -> WriteM a

data A = A
  { aName :: String
  } deriving (Eq, Show)

data B = B
  { bName :: String
  } deriving (Eq, Show)

data C = C
  { cName :: String
  } deriving (Eq, Show)

instance HasName A where
  name s = tell $ Endo $ \a -> a { aName = s }

instance HasName B where
  name s = tell $ Endo $ \b -> b { bName = s }

instance HasName C where
  name s = tell $ Endo $ \c -> c { cName = s }

a :: WriteM A -> Writer [XYZ] ()
a m = tell $ [X (appEndo (execWriter m) (A ""))]

b :: WriteM B -> Writer [XYZ] ()
b m = tell $ [Y (appEndo (execWriter m) (B ""))]

c :: WriteM C -> Writer [XYZ] ()
c m = tell $ [Z (appEndo (execWriter m) (C ""))]

program :: Writer [XYZ] ()
program = do
  a $ do
    name "Foo"

  b $ do
    name "Fib"

  c $ do
    name "Bar"

main :: IO ()
main = print $ execWriter program

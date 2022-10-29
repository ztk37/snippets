import Data.Monoid (Endo(..))
import Control.Monad.Writer

class Default a where
  def :: a

instance Default Something where
  def = Something "" "" ""

main :: IO ()
main = print $ something $ do
  name "Foo"
  title "Bar"
  description "Fib"

type EndoM a = Writer (Endo a) ()

runEndoM :: a -> EndoM a -> a
runEndoM def em = appEndo (execWriter em) def

runDefEndoM :: Default a => EndoM a -> a
runDefEndoM em = appEndo (execWriter em) def

something :: EndoM Something -> Something
something = runEndoM (Something "" "" "")

data Something = Something
  { _name :: String
  , _description :: String
  , _title :: String
  } deriving (Show)

class HasNameProp a where
  name :: String -> EndoM a

instance HasNameProp Something where
  name s = tell $ Endo $ \x -> x { _name = s }

class HasTitleProp a where
  title :: String -> EndoM a

instance HasTitleProp Something where
  title s = tell $ Endo $ \x -> x { _title = s }

class HasDescriptionProp a where
  description :: String -> EndoM a

instance HasDescriptionProp Something where
  description s = tell $ Endo $ \x -> x { _name = s }

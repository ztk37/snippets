import Data.Monoid                (Endo(..), appEndo)
import Control.Monad.Trans.Writer (execWriter, tell)

data Triple = Triple
  { tripleA :: Maybe String
  , tripleB :: Int
  , tripleC :: Bool
  } deriving (Show)

setTripleA :: String -> Triple -> Triple
setTripleA val triple = triple { tripleA = Just val }

setTripleB :: Int -> Triple -> Triple
setTripleB val triple = triple { tripleB = val }

setTripleC :: Bool -> Triple -> Triple
setTripleC val triple = triple { tripleC = val }

baseTriple :: Triple
baseTriple = Triple Nothing 0 False

run :: Triple
run = flip appEndo baseTriple $ execWriter $ do
  tell $ Endo $ setTripleA "Derp"
  tell $ Endo $ setTripleB 42
  tell $ Endo $ setTripleC True

main :: IO ()
main = print run

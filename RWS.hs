import           Control.Monad.Trans.RWS (RWS, execRWS)
import qualified Control.Monad.Trans.RWS as RWS
import Data.Monoid (Endo(..), appEndo)

data Triple = Triple
  { tripleA :: String
  , tripleB :: Int
  , tripleC :: Bool
  } deriving (Show)

defaultTriple :: Triple
defaultTriple = Triple
  { tripleA = ""
  , tripleB = 0
  , tripleC = False
  }

setTripleA :: String -> Triple -> Triple
setTripleA a triple = triple { tripleA = a }

setTripleB :: Int -> Triple -> Triple
setTripleB b triple = triple { tripleB = b } 

setTripleC :: Bool -> Triple -> Triple
setTripleC c triple = triple { tripleC = c }

run :: RWS String (Endo Triple) [String] ()
run = do
  r <- RWS.ask
  RWS.tell $ Endo $ setTripleA "sad"
  RWS.tell $ Endo $ setTripleB 0
  RWS.tell $ Endo $ setTripleC True
  RWS.put ["a"]
  RWS.modify $ (++)["b"]

main :: IO ()
main = do
  case execRWS run "secret" [] of
    (xs, endo) -> print $ appEndo endo defaultTriple

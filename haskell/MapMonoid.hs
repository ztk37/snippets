import           Data.Map (Map)
import qualified Data.Map as Map

data Field
  = FA
  | FB
  | FC
  deriving (Eq, Ord, Show)

fa :: v -> Map Field v
fa = Map.singleton FA

fb :: v -> Map Field v
fb = Map.singleton FB

fc :: v -> Map Field v
fc = Map.singleton FC

main :: IO ()
main = print $ mconcat
  [ fa "a"
  , fb "b"
  , fc "c"
  ]

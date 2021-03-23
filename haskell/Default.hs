module Default (main) where

data State = State
  { unState :: Int
  } deriving (Show, Eq)

class Default a where
  fromDefault :: a

instance Default State where
   fromDefault = State 0

defaultState :: State
defaultState = fromDefault

main :: IO ()
main = print $ defaultState

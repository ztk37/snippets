module Main (main) where

-- import Control.Monad.Writer
import Control.Monad.RWS

import Data.Map (Map)
import qualified Data.Map as Map

data WrapResource = WrapResource
  {} deriving (Show)

data WrapStore = WrapStore (Map String String)
  deriving (Show)

instance Semigroup WrapStore where
  (WrapStore a) <> (WrapStore b) =
    WrapStore (a <> b)

instance Monoid WrapStore where
  mempty = WrapStore (Map.empty)

data WrapState = WrapState
  { stateValue :: String
  } deriving (Show)

type Wrap = RWS WrapResource WrapStore WrapState ()

runWrap :: Wrap -> (WrapState, WrapStore)
runWrap wrap = execRWS wrap resource state
  where
    resource = WrapResource
    state = WrapState "Init"
    
main :: IO ()
main = print $ runWrap $ do
  modify $ \state -> state
    { stateValue = reverse . stateValue $ state }
   
  tell $ WrapStore $ Map.singleton "sad" "daf"
  tell $ WrapStore $ Map.singleton "sad" "daf"

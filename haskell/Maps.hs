module Main where

import Data.Map (Map)
import qualified Data.Map.Strict as Map

newtype State = State (Map String Int) deriving Show

stateEmpty :: State
stateEmpty = State Map.empty

stateSet :: String -> Int -> State -> State
stateSet k v (State s) = State (Map.insert k v s)

stateGet :: String -> State -> Maybe Int
stateGet k (State s) =
    case Map.lookup k s of
        Nothing -> Nothing
        Just v -> Just v

main :: IO ()
main = do
    let state = stateEmpty
    let state = stateSet "a" 42 state
    let state = stateSet "b" 21 state
    putStrLn $ show state

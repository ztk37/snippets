{-# LANGUAGE GeneralizedNewtypeDeriving  #-}

module Aggregate where

import Data.Map (Map)
import qualified Data.Map as Map

type CountStore = Map Int Counter

emptyCountStore :: CountStore
emptyCountStore = Map.empty

fromListCountStore :: [(Int, Counter)] -> CountStore
fromListCountStore = Map.fromList

insertCountStore :: Int -> Counter -> CountStore -> CountStore
insertCountStore = Map.insert

data Transaction
  = Increment
  | Decrement

newtype Counter = Counter
  { getCounter :: Int
  } deriving (Show)

emptyCount :: Counter
emptyCount = Counter 0

counterList :: [(Int, Counter)]
counterList = [ (i, c) | i <- [1..10] , c <- map Counter [5,15]]

transactions :: [Transaction]
transactions =
    [ Increment
    , Increment
    , Decrement
    , Increment
    , Increment
    , Decrement
    ]

aggregate :: [Transaction] -> Counter
aggregate ts = Counter $ total
    where
        total = sum $ map asCount ts
        asCount Increment = 1
        asCount Decrement = negate 1

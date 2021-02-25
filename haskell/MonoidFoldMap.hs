module Main where

import Data.Monoid

data Record = Record
  { rAmout :: Int
  } deriving (Show, Eq)

records :: [Record]
records = map Record [1..10]

recordsTotalAmount :: [Record] -> Int
recordsTotalAmount = getSum . foldMap (Sum . rAmout)

main :: IO ()
main = print $ recordsTotalAmount records

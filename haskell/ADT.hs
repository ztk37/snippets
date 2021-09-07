module Main (main) where

data DA = DA { dA :: String } deriving (Eq, Show)
data DB = DB { dB :: String } deriving (Eq, Show)
data DC = DC { dC :: String } deriving (Eq, Show)

data ABC
  = A DA
  | B DB
  | C DC
  deriving (Eq, Show)

class HasValue a where
  getValue :: a -> String
instance HasValue DA where
  getValue = dA
instance HasValue DB where
  getValue = dB
instance HasValue DC where
  getValue = dC

instance HasValue ABC where
  getValue (A x) = getValue x 
  getValue (B x) = getValue x 
  getValue (C x) = getValue x 

samples :: [ABC]
samples =
  [ A (DA "Foo")
  , A (DA "Bar")
  , B (DB "Bar")
  , A (DA "Fib")
  , C (DC "Bar")
  , C (DC "Bar")
  , B (DB "Fib")
  ]

main :: IO ()
main = print $ map getValue samples

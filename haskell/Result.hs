module Main where

data ABCResult a =
  ABCResult a a a
  deriving Show

instance Num a => Semigroup (ABCResult a) where
  (ABCResult x1 x2 x3) <> (ABCResult y1 y2 y3) = ABCResult (x1 + y1) (x2 + y2) (x3 + y3)

instance Num a => Monoid (ABCResult a) where
  mempty = ABCResult 0 0 0
  mappend = (<>)

data ABC a =
  A a
  | B a
  | C a
  deriving Show

toABCResult :: Num a => ABC a -> ABCResult a
toABCResult (A v) = ABCResult v 0 0 
toABCResult (B v) = ABCResult 0 v 0 
toABCResult (C v) = ABCResult 0 0 v


simulate :: Num a => ABCResult a
simulate = foldMap toABCResult abcs
  where
    abcs =
      [ A 1
      , B 3
      , A 2
      , C 4
      , B 2
      , C 5
      , A 4
      ]

main :: IO ()
main = print $ simulate

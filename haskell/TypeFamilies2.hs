{-# LANGUAGE TypeFamilies #-}

module Main (main) where

import Data.Kind (Type)

class Something a where
  type Thing a :: Type

  doSomething :: a -> Thing a -> a

data ABC = A | B | C deriving (Eq, Show)

next :: ABC -> ABC
next A = B
next B = C
next C = A

instance Something ABC where
  type Thing ABC = Maybe ABC

  doSomething a b =
    case b of
      Nothing -> a
      Just c -> next c
--      case c of
--        A -> B
--        B -> C
--        C -> A

main :: IO ()
main = print $ doSomething A (Just B)

module Base
  ( id
  , map
  , filter
  , fst
  , snd
  , (||)
  , (&&)
  , not
  ) where

import Prelude hiding ( id
                      , map
                      , filter
                      , fst
                      , snd
                      , (||)
                      , (&&)
                      , not
                      )

id :: a -> a
id x = x

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs)
  | p x = x : filter p xs
  | otherwise = filter p xs

fst :: (a, b) -> a
fst (x, _) = x

snd :: (a, b) -> b
snd (_, x) = x

(&&) :: Bool -> Bool -> Bool
(&&) True True = True
(&&) False True = False
(&&) True False = False
(&&) False False = False

(||) :: Bool -> Bool -> Bool
(||) True True = True
(||) False True = True
(||) True False = True
(||) False False = False

not :: Bool -> Bool
not True = False
not False = True

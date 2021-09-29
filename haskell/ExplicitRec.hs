module Main (main) where

import Prelude hiding (map)

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

mapWithIndex :: (Int -> a -> b) -> [a] -> [b]
mapWithIndex f xs = go 0 xs
  where
    go _ [] = []
    go n (x:xs) = f n x : go (n+1) xs

filterWithIndex :: (Int -> a -> Bool) -> [a] -> [a]
filterWithIndex p xs = go 0 xs
  where
    go _ [] = []
    go n (x:xs)
      | p n x = x : go (n+1) xs
      | otherwise = go (n+1) xs

main :: IO ()
main = do
  print $ map (*2) [1..10]
  print $ mapWithIndex (+) (reverse [1..10])
  print $ mapWithIndex (,) [1..10]

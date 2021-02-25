module Main where

import Data.Char

maybeDoStuff :: (a -> b) -> Maybe a -> Maybe b
maybeDoStuff f (Just x) = Just (f x)
maybeDoStuff f Nothing = Nothing

reverseString :: [Char] -> [Char]
reverseString = reverse

reverseToUpper :: Maybe [Char] -> Maybe [Char]
reverseToUpper = f . g
  where
    f = maybeDoStuff $ map toUpper
    g = maybeDoStuff reverseString

main :: IO ()
main = writeFile "file.txt" "Damn!"

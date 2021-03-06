module Main where

import Data.Char

toUpperCase :: String -> String
toUpperCase = map toUpper

linesToUpperCase :: [String] -> [String]
linesToUpperCase = map toUpperCase

reverseLines :: [String] -> [String]
reverseLines = map reverse

dummyLines :: [String]
dummyLines =
  [ "asasd"
  , "aasfh"
  , "sdf75"
  ]

withNewLine :: [String] -> [String]
withNewLine = map (++"\n")

main :: IO ()
main = putStrLn $ concat $ reverseLines . linesToUpperCase . withNewLine $ dummyLines

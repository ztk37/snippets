module Main (main) where

import Data.Char

proc :: (Bool, Bool) -> String -> String
proc (a, b) = 
  (case a of
  True -> reverse
  False -> map toUpper) .
  (case b of
  True -> (++) "asdds"
  False -> (++ replicate 10 'A'))

main :: IO ()
main = do
  putStrLn $ proc (True, True) "Foo"
  putStrLn $ proc (True, False) "Bar"
  putStrLn $ proc (False, True) "Fib"
  putStrLn $ proc (False, False) "Bazz"

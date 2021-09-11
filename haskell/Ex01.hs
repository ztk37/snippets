module Main (main) where

import Data.Char

compute :: Int -> Either String String
compute n
  | n == 42 = Right "The answer"
  | otherwise = Left "Not the answer"

defaultMain :: IO (String, String, String)
defaultMain = do
  x <- pure $ case compute 21 of
    Left x -> map toUpper x
    Right x -> map toLower x

  y <- pure $ case compute 42 of
    Left x -> reverse x
    Right x -> x

  z <- pure $ case compute 1337 of
    Left x -> "Derp"
    Right x -> "Damn"

  pure (x, y, z)

main :: IO ()
main = do
  putStrLn $ case compute 20 of
    Left x -> x
    Right x -> x

  print =<< defaultMain

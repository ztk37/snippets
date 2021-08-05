module Main (main) where

data S
  = A
  | B
  | C
  deriving (Eq, Show)

xs :: [S]
xs = [A, A, A, B, A, C, C, A, B, B, B]

compute :: S -> Int -> Int
compute A s = s + 1
compute B s = s - 1
compute C s = s

proc :: [S] -> Int
proc xs = go xs 0
  where
    go :: [S] -> Int -> Int
    go [] s = s
    go (A:rest) s = go rest (s + 1)
    go (B:rest) s = go rest (s - 1)
    go (C:rest) s = go rest s
    
main :: IO ()
main = do
  print $ foldr compute 0 xs
  print $ proc xs

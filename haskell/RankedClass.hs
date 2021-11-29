module Main (main) where

data ABC = A | B | C deriving (Eq, Show)
data DEF = D | E | F deriving (Eq, Show)
data GHI = G | H | I deriving (Eq, Show)

data XYZ = X ABC | Y DEF | Z GHI deriving (Eq, Show)

class Ranked a where
  fromRank :: a -> Int
  toRank :: Int -> a

instance Ranked ABC where
  fromRank A = 0
  fromRank B = 1
  fromRank C = 2

  toRank 0 = A
  toRank 1 = B
  toRank 2 = C

instance Ranked DEF where
  fromRank D = 3
  fromRank E = 4
  fromRank F = 5

  toRank 3 = D
  toRank 4 = E
  toRank 5 = F

instance Ranked GHI where
  fromRank G = 6
  fromRank H = 7
  fromRank I = 8

  toRank 6 = G
  toRank 7 = H
  toRank 8 = I

instance Ranked XYZ where
  fromRank (X x) = fromRank x
  fromRank (Y x) = fromRank x
  fromRank (Z x) = fromRank x

  toRank 0 = (X A)
  toRank 1 = (X B)
  toRank 2 = (X C)
  toRank 3 = (Y D)
  toRank 4 = (Y E)
  toRank 5 = (Y F)
  toRank 6 = (Z G)
  toRank 7 = (Z H)
  toRank 8 = (Z I)

main :: IO ()
main = print $ (map toRank [0..8] :: [XYZ])

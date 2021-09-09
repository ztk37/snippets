module Main (main) where

data Coin
  = Head
  | Tail
  deriving (Eq, Enum)

data Dice
  = One
  | Two
  | Three
  | Four
  | Five
  | Six
  deriving (Eq, Enum)
  
class FromShortName a where
  fromShortName :: String -> a
class ToShortName a where
  toShortName :: a -> String
  
class FromLongName a where
  fromLongName :: String -> a
class ToShortName a where
  toShortName :: a -> String
  
class ShortName a where
    shortName :: a -> String
instance ShortName Coin where
    shortName Head = "H"
    shortName Tail = "T"
instance ShortName Dice where
    shortName One = "1"
    shortName Two = "2"
    shortName Three = "3"
    shortName Four = "4"
    shortName Five = "5"
    shortName Six = "6"

class LongName a where
    longName :: a -> String
instance LongName Coin where
    longName Head = "Head"
    longName Tail = "Tail"
instance LongName Dice where
    longName One = "One"
    longName Two = "Two"
    longName Three = "Three"
    longName Four = "Four"
    longName Five = "Five"
    longName Six = "Six"

instance Show Coin where
    show = longName
instance Show Dice where
    show = longName

main :: IO ()
main = do
  print $ map shortName [Head, Tail]
  print $ map shortName [One, Two, Three, Four, Five, Six]
  
  print $ map longName [Head, Tail]
  print $ map longName [One, Two, Three, Four, Five, Six]

import Data.List (intercalate)

class Computable a where
  compute :: a -> String

data Computer a = Computer
  { compValue :: a
  , compAction :: a -> String
  }

instance Show a => Show (Computer a) where
  show (Computer a _ ) = show a

instance Computable (Computer a) where
  compute (Computer a s) = s a

newtype Action a = Action
  { runAction :: String -> a
  }

instance Show a => Computable (Action a) where
  compute (Action f) = "foo"

rangeToString :: (Int -> Int) -> [Int] -> String
rangeToString f = intercalate "," . map (show . f)

data ABC = A | B | C deriving (Show)

main :: IO ()
main =
  let
    computer1 = Computer "foo" reverse
    computer2 = Computer [1..10] (rangeToString (*2))
    computer3 = Computer B show


  in do
    putStrLn $ compute computer1
    putStrLn $ compute computer2
    putStrLn $ compute computer3

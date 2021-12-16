{-# LANGUAGE FlexibleInstances #-}

import Data.Char (toUpper)
import Data.List (intercalate)

data A
data B
data C

newtype Formatter s a = Formatter
  { unFormatter :: a
  } deriving (Eq, Show)

class Pretty a where
  pp :: a -> String

instance Pretty (Formatter A String) where
  pp = unFormatter

instance {-# OVERLAPPABLE #-} Show a => Pretty (Formatter A a) where
  pp = show . unFormatter

instance {-# OVERLAPPABLE #-} Show a => Pretty (Formatter A [a]) where
  pp x = intercalate "," (map show . unFormatter $ x)

instance {-# OVERLAPPABLE #-} Pretty (Formatter B String) where
  pp = map toUpper . unFormatter

instance {-# OVERLAPPABLE #-} Show a => Pretty (Formatter B a) where
  pp = show . unFormatter

instance {-# OVERLAPPABLE #-} Show a => Pretty (Formatter B [a]) where
  pp x = intercalate "," (map show . reverse . unFormatter $ x)

instance {-# OVERLAPPABLE #-} Pretty (Formatter C String) where
  pp = reverse . unFormatter

instance {-# OVERLAPPABLE #-} Pretty (Formatter C [String]) where
  pp = intercalate "" . unFormatter

instance {-# OVERLAPPABLE #-} Show a => Pretty (Formatter C a) where
  pp = show . unFormatter

instance {-# OVERLAPPABLE #-} Show a => Pretty (Formatter C [a]) where
  pp x = intercalate "" (map show . unFormatter $ x)

main :: IO ()
main =
  let
    a1 = Formatter "First" :: Formatter A String
    a2 = Formatter () :: Formatter A ()
    a3 = Formatter ["A", "B", "C"] :: Formatter A [String]

    b1 = Formatter "First" :: Formatter B String
    b2 = Formatter () :: Formatter B ()
    b3 = Formatter ["A", "B", "C"] :: Formatter B [String]

    c1 = Formatter "First" :: Formatter C String
    c2 = Formatter () :: Formatter C ()
    c3 = Formatter ["A", "B", "C"] :: Formatter C [String] 
  in do
    putStrLn "A"
    putStrLn $ pp a1
    putStrLn $ pp a2
    putStrLn $ pp a3

    putStrLn "B"
    putStrLn $ pp b1
    putStrLn $ pp b2
    putStrLn $ pp b3

    putStrLn "C"
    putStrLn $ pp c1
    putStrLn $ pp c2
    putStrLn $ pp c3

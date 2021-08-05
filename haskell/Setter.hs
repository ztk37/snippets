module Main (main) where

data Record = Record
  { recordA :: String
  , recordB :: String
  , recordC :: String
  } deriving (Show)

setter :: String -> String -> Record -> Record
setter "a" v r = r { recordA = v }
setter "b" v r = r { recordB = v }
setter "c" v r = r { recordC = v }
setter _ _ r = r

xs :: [(String, String)]
xs =
  [ ("a", "damn")
  , ("c", "fib")
  , ("g", "derp")
  , ("b", "bar")
  , ("a", "foo")
  ]
    
main :: IO ()
main = print $ foldr (\(k, v) r -> setter k v r) (Record "" "" "") xs

module Main (main) where

data Props = Props
  { propA :: String
  , propB :: Maybe String
  , propC :: Bool
  , propD :: Int
  , propE :: String
  , propF :: (String -> String)
  }
  
props :: Props
props = Props
  { propA = "foo"
  , propB = Just "bar"
  , propC = False
  , propD = 42
  , propE = "fib"
  , propF = reverse
  }
  
instance Show Props where
  showsPrec p (Props a b c d e _)
    = showParen (p >= 11)
    $ showString "Props { propA = " . shows a
    . showString ", propB = " . shows b
    . showString ", propC = " . shows c
    . showString ", propD = " . shows d
    . showString ", propE = " . shows e
    . showString " }"

main :: IO ()
main = print $ props

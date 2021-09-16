import Data.Char (toUpper)
import Data.List (intercalate)

data Props = Props
  { propA :: String
  , propB :: Bool
  , propC :: Int
  , propF :: (String -> String)
  }

instance Show Props where
  show (Props a b c _) = "Props { " ++  intercalate ", " [k ++ " = " ++ v | (k, v) <- fields] ++ " }"
    where
      fields =
        [ ("propA", a)
        , ("propB", show b)
        , ("propC", show c)
        ]

props :: [Props]
props = 
  [ Props
    { propA = "Foo"
    , propB = True
    , propC = 42
    , propF = reverse
    }
  , Props
    { propA = "Bar"
    , propB = False
    , propC = 21
    , propF = id
    }
  , Props
    { propA = "Fib"
    , propB = True
    , propC = 42
    , propF = map toUpper 
    }
  ]


run :: Props -> IO ()
run (Props a b c f) =
  if b
    then putStrLn $ f a
    else print c

run' :: Props -> IO ()
run' (Props a b c f)
  | b = putStrLn $ f a
  | otherwise = print c

run'' :: Props -> IO ()
run'' (Props a True _ f) = putStrLn $ f a
run'' (Props _ False c _) = print c

main :: IO ()
main = mapM_ run props

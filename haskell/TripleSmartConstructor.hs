data Triple = Triple
  { tripleA :: String
  , tripleB :: Maybe String
  , tripleC :: Int
  } deriving (Eq, Show)

triple
  :: String
  -> Maybe String
  -> Int
  -> Either String Triple
triple a b c =
  Triple
    <$> applyA a
    <*> applyB b
    <*> applyC c

fromTriple :: (String, Maybe String, Int) -> Triple
fromTriple (a, b, c) = Triple a b c

toTriple :: Triple -> (String, Maybe String, Int)
toTriple (Triple a b c) = (a, b, c)

applyA :: String -> Either String String
applyA x
  | null x = Left "a can't be empty"
  | otherwise = Right x

applyB :: Maybe String -> Either String (Maybe String)
applyB x = Right x

applyC:: Int -> Either String Int
applyC x
  | x <= 0 = Left "c must be greater then 0"
  | otherwise = Right x

triples :: [(String, Maybe String, Int)]
triples =
  [ ("Foo", Just "Fib", 21)
  ]

main :: IO ()
main = do
  print $ triple "Damn" (Just "Derp") 42

  print $ map fromTriple triples

module Main (main) where

data Option a
  = Some a
  | None

instance Show a => Show (Option a) where
  show None = "None"
  show (Some x) = "Some(" ++ show x ++ ")"

newtype Dict a = Dict
  { getEntries :: [(String, a)]
  }

insert :: String -> a -> Dict a -> Dict a
insert k v (Dict xs) = Dict $ (k, v) : xs

find :: String -> Dict a -> Option a
find k (Dict entries) = 
  case filter ((==k) . fst) entries of
    [] -> None
    (x:_) -> Some $ snd x

remove :: String -> Dict a -> Dict a
remove k = Dict
         . filter ((/=k) . fst)
         . getEntries

main :: IO ()
main = do
  print (None :: Option ())
  print $ Some True

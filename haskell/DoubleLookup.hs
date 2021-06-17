import Data.Map (Map)
import Data.Map as Map

doubleLookup
  :: String
  -> Map String String
  -> Map String String
  -> Either String String
doubleLookup key m1 m2 =
  let v1 = Map.lookup key m1
      v2 = Map.lookup key m2
  in case (v1, v2) of
    (Just v1', Just v2') -> Right $ "both maps contains key: " ++ key
    (Just v1', Nothing)  -> Right $ "first map contains key: " ++ key
    (Nothing, Just v2')  -> Right $ "second map contains key: " ++ key
    (Nothing, Nothing)   -> Left $ "none of both maps contains key: " ++ key

samples :: Map String String
samples = Map.fromList
  [ ("A", "a")
  , ("B", "b")
  , ("C", "c")
  ]

main = print $ doubleLookup "A" samples samples

module Main (main) where

import           Data.Map (Map)
import qualified Data.Map as Map

data Compound = Compound (Map String String) (Map String String)
  deriving (Show)

instance Semigroup Compound where
  (Compound xs1 ys1) <> (Compound xs2 ys2) =
    Compound (xs1 <> xs2) (ys1 <> ys2)

instance Monoid Compound where
  mempty = emptyCompound
  mappend = (<>)

insertCompound :: String -> String -> String -> Compound -> Compound
insertCompound k v1 v2 (Compound kv1 kv2) =
  Compound (Map.insert k v1 kv1) (Map.insert k v2 kv2)

deleteCompound :: String -> String -> String -> Compound -> Compound
deleteCompound k v1 v2 (Compound kv1 kv2) =
  Compound (Map.delete k v1 kv1) (Map.delete k v2 kv2)

lookupCompound :: String -> Compound -> Maybe (String, String)
lookupCompound k (Compound kv1 kv2) =
  let
    v1 = Map.lookup k kv1
    v2 = Map.lookup k kv2
  in case (v1, v2) of
    (Just a, Just b) -> Just (a, b)
    (Nothing, Just _) -> Nothing
    (Just _, Nothing) -> Nothing
    (Nothing, Nothing) -> Nothing

emptyCompound :: Compound
emptyCompound = Compound Map.empty Map.empty

singletonCompound :: String -> String -> String -> Compound
singletonCompound k v1 v2 = Compound (Map.singleton k v1) (Map.singleton k v2)

main :: IO ()
main = do
  print $ insertCompound "k2" "v3" "v4" $ insertCompound "k1" "v1" "v2" emptyCompound

  print $ singletonCompound "k1" "v1" "v2" <> singletonCompound "k2" "v3" "v4"

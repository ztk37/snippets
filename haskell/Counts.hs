module Main where

import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map

data ABC = A | B | C deriving (Eq, Ord, Show)

abcs :: [ABC]
abcs = [A, B, A, B, C, C, A, B, A, B, A, B, C, C, A, B, A, A, B, A, A, B, C, B, C, C, A, A, C, A]

newtype Counts key = Counts
  { unCounts :: Map key Int
  }
  deriving (Show)

toCount :: (Ord k) => k -> Counts k
toCount = Counts . flip Map.singleton 1
-- toCount key = Counts (Map.singleton key 1)

instance (Ord key) => Semigroup (Counts key) where
  Counts xs <> Counts ys = Counts $ Map.unionWith (+) xs ys

instance (Ord key) => Monoid (Counts key) where
  mempty = Counts Map.empty
  mappend = (<>)

counts :: (Ord k) => [k] -> Counts k
counts = foldMap toCount
-- counts :: Ord k => [k] -> Map k Int
-- counts = foldr (Map.unionWith (+)) Map.empty . map (flip Map.singleton 1)

main :: IO ()
main = print $ counts abcs

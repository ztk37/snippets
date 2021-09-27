import Data.Maybe (catMaybes)

data Tree a
  = Leaf a
  | Node [Tree a]
  deriving (Eq, Show)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f (Leaf x) = Leaf $ f x
mapTree f (Node xs) = Node $ map (mapTree f) xs

mapForest :: (a -> b) -> [Tree a] -> [Tree b]
mapForest f = map $ mapTree f

filterTree :: (a -> Bool) -> Tree a -> Maybe (Tree a)
filterTree p (Leaf x)
  | p x = Just $ Leaf x
  | otherwise = Nothing
filterTree p (Node xs) = Just $ Node $ catMaybes $ map (filterTree p) xs

filterForest :: (a -> Bool) -> [Tree a] -> Maybe [Tree a]
filterForest p xs = sequence $ map (filterTree p) xs

tree :: Tree Bool
tree =
  Node
    [ Leaf True
    , Leaf True
    , Node
      [ Leaf False
      , Leaf True
      , Leaf False
      ]
    , Leaf False
    ]

main :: IO ()
main = do
  print $ mapTree not tree
  print $ filterTree (==True) tree

module Trees
  ( main
  ) where

data ABC
  = A
  | B
  | C
  deriving (Show, Eq, Enum)

data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)
  | Node [Tree a]
  deriving (Show)

instance Functor Tree where
  fmap f (Leaf x) = Leaf (f x)
  -- fmap _ (Node []) = Node []
  -- fmap f (Node xs) = Node (fmap (fmap f) xs)
  fmap f (Branch a b) = Branch (fmap f a) (fmap f b)
  fmap f (Node xs) = Node $ (fmap . fmap) f xs

exampleTree :: Tree ABC
exampleTree =
  Branch
    (Node
      [ Leaf A
      , Leaf B
      , Node
        [ Leaf A
        , Node []
        ]
      ]
    )
   (Leaf C)

main :: IO ()
main = print $ fromEnum <$> exampleTree

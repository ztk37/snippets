module DrawTree (main) where

import Data.Tree (Tree(..))
import qualified Data.Tree as Tree (drawTree)

printTree :: Tree String -> IO ()
printTree = putStr . Tree.drawTree

leaf :: a -> Tree a
leaf = flip Node []

tree :: Tree String
tree =
  Node "A"
    [ Node "B"
      [ Node "V"
        [ leaf "Y"
        , leaf "Z"
        ]
      , leaf "X"
      ]
    , leaf "C"
    , Node "D"
      [ leaf "E"
      , leaf "F"
      ]
    , leaf "G"
    ]

main :: IO ()
main = printTree tree

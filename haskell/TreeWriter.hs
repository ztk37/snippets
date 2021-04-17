module TreeWriter (main) where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Writer
import Data.Tree (Tree(..), Forest)
import qualified Data.Tree as Tree

type Wrap a = Writer [Tree a] ()

runWrap :: String -> Wrap String -> String
runWrap root wrap = Tree.drawTree $ combineTree root $ execWriter wrap

combineTree :: a -> Forest a -> Tree a
combineTree = Node

register :: a -> Wrap a
register x = tell $ [Node x []]

registerWith :: a -> Wrap a
registerWith x = tell $ [Node x []]

initWrap :: Wrap String
initWrap = do
  register "dasd" 
  register "dasd"
  register "dasd"
  register "dasd"
  register "dasd"

directWrap :: String -> String
directWrap root = runWrap root $ do
  register "dasd" 
  register "dasd"
  register "dasd"
  register "dasd"
  register "dasd"

main :: IO ()
main = do
  putStr $ runWrap "Root" initWrap
  putStr $ directWrap "Root"

module Main where

import           Data.Map (Map)
import qualified Data.Map as Map

import Control.Monad.Writer

type Store = Map String [Int]
type Wrap = Writer Store ()
type Items = Writer [Int] ()

run :: Wrap -> (Map String [Int])
run = execWriter

list :: String -> Items -> Wrap
list s xs = tell $ Map.fromList [(s, execWriter xs)]

item :: Int -> Items
item n = tell [n]

main :: IO ()
main =
  let
    store = run $ do
      list "a" $ do
        item 1
        item 2
        item 3

      list "b" $ do
        item 4
        item 5
        item 6

      list "c" $ do
        item 7
        item 8
        item 9

  in print store

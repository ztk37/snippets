module Main (main) where

import Data.Maybe
import Control.Monad
import Control.Applicative
import System.Exit

maybes :: [Maybe Int]
maybes =
  [ Nothing
  , Just 42
  , Just 21
  , Nothing
  , Just 13
  ]

main :: IO ()
main = do
  when False $ do
    print 42
    -- exitWith $ ExitFailure 2
    die "^^ The answer is all you need to print"

  unless False $ do
    print 21
    die "^^ Half of the answer"

  print $ foldl (<|>) Nothing maybes
  print $ catMaybes maybes

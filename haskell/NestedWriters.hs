module Main (main) where

import           Data.Maybe (fromMaybe)
import           Data.Monoid (Endo(..))
import           Data.Map (Map)
import qualified Data.Map as Map

import Control.Monad.Writer

data Props = Props
  { propTitle :: String
  , propDescription :: String
  } deriving Show

defaultProps :: Props
defaultProps = Props "" ""

item
  :: String
  -> Writer (Endo Props) ()
  -> Writer (Map String Props) ()
item k v = do
  tell $ Map.singleton k (appEndo (execWriter v) defaultProps)
  return ()

title
  :: String
  -> Writer (Endo Props) ()
title s = tell $ Endo $ \props ->
  props { propTitle = s }

description
  :: String
  -> Writer (Endo Props) ()
description s = tell $ Endo $ \props ->
  props { propDescription = s }

items :: Writer (Map String Props) () 
items = do
  item "a" $ do
    title "bli"
    description "foo"
  item "c" $ do
    title "bla"
    description "bar"
  item "b" $ do
    title "blub"
    description "fib"

main :: IO ()
main = do
  mapM_ print $ execWriter items

  mapM_ print $ Map.toList $ execWriter items

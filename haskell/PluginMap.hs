module Main (main) where

import Control.Monad.Trans.Writer
import Data.Map (Map)
import qualified Data.Map as Map

type Identifier = String

data Plugin = Plugin
  { pluginID :: Identifier
  } deriving (Show)

pluginA :: Plugin
pluginA = Plugin "PA"

pluginB :: Plugin
pluginB = Plugin "PB"

pluginC :: Plugin
pluginC = Plugin "PC"

type Registry = Writer (Map Identifier Plugin) ()

register :: Plugin -> Registry
register p = tell $ Map.singleton (pluginID p) p

plugin :: Identifier -> Registry
plugin idr = tell $ Map.singleton idr (Plugin idr)

run :: Map Identifier Plugin
run = execWriter $ do
  register $ pluginA
  register $ pluginB
  register $ pluginC
  plugin "PD"

main :: IO ()
main = putStrLn $ unlines . map show . Map.elems $ run
-- mapM_ print run

module Main where

import           Data.Map (Map)
import qualified Data.Map as Map

data Room
  = R0
  | R1
  | R2
  | R3
  | R4
  deriving (Eq, Ord, Show)

type World = Map Room [Room]

canMove :: Room -> Room -> World -> Bool
canMove from to w =
  case Map.lookup from w of
    Just paths -> elem to paths
    Nothing -> False

goto :: Room -> Context -> Context
goto to (current, world)
  | canMove current to world = (to, world)
  | otherwise = (current, world)

world :: World
world = Map.fromList
  [ (R0, [R1, R2])
  , (R1, [R3, R4])
  , (R2, [R4])
  ]

type Context = (Room, World)

initContext :: Context
initContext = (R0, world)

main :: IO ()
main = print $ goto R1 initContext

module Main (main) where

import Data.Monoid (Endo(..))
import Control.Monad.Writer.Strict
import Control.Monad.State.Strict

data Something = MkSomething
  { somethingFlag :: !Bool
  , somethingValues :: ![String]
  } deriving (Eq, Show)

toggleFlag :: Something -> Something
toggleFlag s = s
  { somethingFlag = not $ somethingFlag s }

addValue :: String -> Something -> Something
addValue v s = s
  { somethingValues = v : somethingValues s }

defaultSomething :: Something
defaultSomething = MkSomething False []

------------------------------------------------

type EndoW a = Writer (Endo a) ()

modifyW :: (a -> a) -> EndoW a
modifyW = tell . Endo

runEndoW :: a -> EndoW a -> a
runEndoW defs = flip appEndo defs . execWriter

endoW :: EndoW Something
endoW = do
  modifyW toggleFlag
  modifyW $ addValue "A"
  modifyW $ addValue "B"
  modifyW $ addValue "C"

------------------------------------------------

type EndoS a = State (Endo a) ()

modifyS' :: (a -> a) -> EndoS a
modifyS' f = modify' (`mappend` Endo f)

runEndoS :: a -> EndoS a -> a
runEndoS defs = flip appEndo defs . flip execState mempty

endoS :: EndoS Something
endoS = do
  modifyS' toggleFlag
  modifyS' $ addValue "A"
  modifyS' $ addValue "B"
  modifyS' $ addValue "C"

------------------------------------------------

type S a = State a ()

runS :: a -> S a -> a
runS = flip execState

s :: S Something
s = do
  modify' toggleFlag
  modify' $ addValue "A"
  modify' $ addValue "B"
  modify' $ addValue "C"

------------------------------------------------

{--

See:https://hackage.haskell.org/package/mtl-2.3.1/docs/Control-Monad-Writer-CPS.html#g:1

Strict writer monads that use continuation-passing-style to achieve constant space usage.

--}

-- import Control.Monad.Writer.CSP

type UpdateM a = Writer (Endo a) ()

runUpdateM :: a -> UpdateM a -> a
runUpdateM defs = flip appEndo defs . execWriter

main :: IO ()
main = do
  print $ runEndoW defaultSomething endoW

  print $ runEndoS defaultSomething endoS
  print $ runS defaultSomething s

  print $ runUpdateM defaultSomething $ do
    tell $ Endo toggleFlag
    tell $ Endo $ addValue "A"
    tell $ Endo $ addValue "B"
    tell $ Endo $ addValue "C"

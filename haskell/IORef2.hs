module Main (main) where

import Data.IORef
import Data.Map (Map)
import qualified Data.Map as Map

type Registry = IORef [String]

emptyRegistry :: IO Registry
emptyRegistry = newIORef []

modifyRegistry
  :: ([String] -> [String])
  -> Registry
  -> IO ()
modifyRegistry = flip modifyIORef

addItem :: String -> Registry -> IO ()
addItem i = modifyRegistry (i:)

run :: IO Registry
run = do
  r <- emptyRegistry

  addItem "foo" r
  addItem "bar" r
  addItem "fib" r

  return r

main :: IO ()
main = run >>= readIORef >>= print

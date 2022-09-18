module Main where

import Control.Monad
import System.IO

type ShouldExit = Bool

prompt :: IO String
prompt = do
    putStr "> "
    hFlush stdout
    getLine

loop :: ShouldExit -> IO ()
loop shouldExit =
  unless shouldExit $ do
    line <- prompt

    loop (line == ":q")

runLoop :: IO ()
runLoop = loop False

main :: IO ()
main = runLoop

module Main (main) where

import System.Environment (getArgs)

main :: IO ()
main = getArgs >>= mainWithArgs

mainWithArgs :: [String] -> IO ()
mainWithArgs [] = putStrLn "no args"
mainWithArgs args = print args

module Main (main) where

import Data.Char
import System.Environment

data Options = Options
  { optNoFoo :: Bool
  , optNoBar :: Bool
  , optNoFib :: Bool
  } deriving (Show)

data OptionParseError = UnknownOption String deriving (Show)

defaultOptions :: Options
defaultOptions = Options False False False

setNoFoo :: Bool -> Options -> Options
setNoFoo o opts = opts { optNoFoo = o}

setNoBar :: Bool -> Options -> Options
setNoBar o opts = opts { optNoBar = o}

setNoFib :: Bool -> Options -> Options
setNoFib o opts = opts { optNoFib = o}

normalizeArgs :: [String] -> [String]
normalizeArgs = map . map $ toLower

withDefaultArgs :: [String] -> [String]
withDefaultArgs =  (++) ["--nO-foo", "--no-Bar", "--no-fiB"]

parseArgs :: [String] -> Options
parseArgs args = foldr applyOptions defaultOptions args
  where
    applyOptions :: String -> Options -> Options
    applyOptions "--no-foo" opts = setNoFoo True opts
    applyOptions "--no-fib" opts = setNoBar True opts
    applyOptions "--no-bar" opts = setNoFib True opts
    applyOptions _ opts = opts

main :: IO ()
main = do
  args <- normalizeArgs <$> withDefaultArgs <$> getArgs

  case args of
    [] -> putStrLn "no args provided"
    args -> print $ parseArgs args

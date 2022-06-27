module Main (main) where

import Data.Maybe (fromMaybe)
import Text.Read (readMaybe)
import System.Console.GetOpt
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure, exitSuccess)

data Options = Options
  { optShowHelp :: Bool
  , optShowVersion :: Bool
  , optPort :: Int
  } deriving (Show)

defaultOptions :: Options
defaultOptions = Options
  { optShowHelp = False
  , optShowVersion = False
  , optPort = 4004
  }

data Opt = OptHelp | OptVersion | OptPort Int
  deriving (Eq, Ord, Show)

options :: [OptDescr Opt]
options =
  [ Option "h" ["help"] (NoArg OptHelp) "Show help"
  , Option "v" ["version"] (NoArg OptVersion) "Show version"
  , Option "p" ["port"] (ReqArg setPort "PORT") "Set port"
  ]

-- Replace Int with Maybe Int and use them for validation?
setPort :: String -> Opt
setPort = OptPort . fromMaybe 4004 . readMaybe

applyOpt :: Opt -> Options -> Options
applyOpt OptHelp opts = opts { optShowHelp = True }
applyOpt OptVersion opts = opts { optShowVersion = True }
applyOpt (OptPort port) opts = opts { optPort = port }

parseArgs :: [String] -> Either [String] Options
parseArgs args =
  case getOpt RequireOrder options args of
    (opts, [], []) -> Right $ foldr applyOpt defaultOptions opts
    ([], [], errs) -> Left errs

showHelp :: [String] -> IO ()
showHelp errs = do
  progName <- getProgName

  putStr $ unlines errs
  putStrLn $ usageInfo ("Usage: " ++ progName ++ " [OPTIONS]\n\nOptions:") options
    
showVersion :: IO ()
showVersion = putStrLn "v0.0.0"

main :: IO ()
main = do
  parsedOpts <- parseArgs <$> getArgs
  
  case parsedOpts of
    Left errs -> do
      showHelp errs
      exitFailure
    Right opts
      | optShowHelp opts -> showHelp []
      | optShowVersion opts -> showVersion
      | otherwise -> do
          print opts
          exitSuccess

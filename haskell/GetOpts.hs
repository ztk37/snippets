module Main (main) where

-- Docs: https://hackage.haskell.org/package/base-4.15.0.0/docs/System-Console-GetOpt.html
-- Examples:
--   https://github.com/GaloisInc/cryptol/blob/master/cryptol/Main.hs
--   https://github.com/GaloisInc/cryptol/blob/master/cryptol/OptParser.hs

import Data.List (nub)
import Data.Maybe (catMaybes, fromMaybe)
import Data.Monoid (Endo(..))

import System.Console.GetOpt
import System.Environment

type OptMod = Endo Options

data Env = Env
  { envHost :: String
  , envPort :: String
  } deriving (Show)

readEnv :: String -> String -> IO String
readEnv def key = fromMaybe def <$> lookupEnv key

initEnv :: IO Env
initEnv = do
  host <- readEnv "https://localhost" "HOST"
  port <- readEnv "4000" "PORT"

  return Env
    { envHost = host
    , envPort = port
    }

modify :: (Options -> Options) -> OptMod
modify = Endo

setVerbose :: OptMod
setVerbose = modify $ \opt -> opt { optHelp = True }

setHelp :: OptMod
setHelp = modify $ \opt -> opt { optVerbose = True }

data Options = Options
  { optVerbose :: Bool
  , optHelp :: Bool
  } deriving (Show)

defaultOptions :: Options
defaultOptions = Options
  { optVerbose = False
  , optHelp = False
  }

options :: [OptDescr (Maybe String)]
options =
  [ Option "v" ["verbose"] (NoArg $ Just "verbose") "verbose option"
  , Option "h" ["help"] (NoArg $ Just "help") "help option"
  ]

options' :: [OptDescr OptMod]
options' =
  [ Option "v" ["verbose"] (NoArg setVerbose) "verbose option"
  , Option "h" ["help"] (NoArg setHelp) "help option"
  ]

args :: [String]
args = ["-v", "-h", "--help", "derp"]

parseArgs :: Either [String] [String]
parseArgs =
  case getOpt (ReturnInOrder (const Nothing)) options args of
    (ps, [], []) -> Right $ nub $ catMaybes ps
    (_, _, errs) -> Left errs

parseArgs' :: Either [String] Options
parseArgs' =
  case getOpt (ReturnInOrder mempty) options' args of
    (ps, [], []) -> Right $ appEndo (mconcat ps) defaultOptions
    (_, _, errs) -> Left errs

main :: IO ()
main = do
  env <- initEnv

  print env
  print parseArgs
  print parseArgs'

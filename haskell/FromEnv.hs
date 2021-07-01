module Main (main) where

import Data.Maybe (fromMaybe)
import Control.Monad.Reader

import qualified System.Environment as SE

data Env = Env
  { envPath :: [String]
  , envDummy :: String
  } deriving (Show)

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

type App = ReaderT Env IO ()

fromEnvOrDefault :: String -> String -> IO String
fromEnvOrDefault d k = fromMaybe d <$> SE.lookupEnv k

app :: App
app = do
  return ()

run :: IO ()
run = flip runReaderT (Env [] "") app

env :: IO Env
env = Env
  <$> (wordsWhen (==':')) <$> fromEnvOrDefault "PATH_DEFAULT" "PATH"
  <*> fromEnvOrDefault "DERP_DEFAULT" "DERP"

main :: IO ()
main = do
  run

  env >>= print

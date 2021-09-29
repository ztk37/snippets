module Main (main) where

import Control.Monad.Reader

data Env = Env
  { envA :: String
  , envB :: Int
  , envC :: Bool
  } deriving (Show)

env :: Env
env = Env
  { envA = "Foo"
  , envB = 42
  , envC = True
  }

type App a = Reader Env a

askEnvA :: App String
askEnvA = envA <$> ask

askEnvB :: App Int
askEnvB = envB <$> ask

askEnvC :: App Bool
askEnvC = envC <$> ask

r :: App (String, Int, Bool)
r = do
  a <- askEnvA
  b <- askEnvB
  c <- askEnvC

  return (a, b, c)

run :: App a -> a
run = flip runReader env

main :: IO ()
main = print $ run r

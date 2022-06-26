{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Data.Maybe
import Control.Monad.Reader
import System.Environment

data AppConfig = AppConfig
  { acRootPath :: FilePath
  } deriving (Show)

newtype AppM a = AppM
  { unAppM :: ReaderT AppConfig IO a
  } deriving ( Functor
             , Applicative
             , Monad
             , MonadIO
             , MonadReader AppConfig
             )

type App = AppM ()

askRootPath :: AppM FilePath
askRootPath = asks acRootPath

runAppM :: AppConfig -> AppM a -> IO a
runAppM config (AppM action) = runReaderT action config

readEnv :: String -> String -> IO String
readEnv def name = fromMaybe def <$> lookupEnv name

class Monad m => MonadLogger m where
  logMsg :: String -> m ()
  logInfo :: Show msg => msg -> m ()

instance MonadLogger AppM where
  logMsg msg = liftIO $ putStrLn msg
  logInfo msg = liftIO $ print msg
  -- logMsg = liftM liftIO putStrLn
  -- logInfo = liftM liftIO print

app :: AppM ()
app = do
  rootPath <- askRootPath

  logMsg rootPath

main :: IO ()
main = print =<< runAppM (AppConfig ".") app

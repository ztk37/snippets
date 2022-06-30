{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Control.Monad.Reader
import System.IO (hFlush, stdout)

data Environment = Environment
  { envSomeValue :: String
  } deriving (Show)

env :: Environment
env = Environment "SomeValue"

newtype AppM a = AppM
  { unAppM :: ReaderT Environment IO a
  } deriving ( Functor
             , Applicative
             , Monad
             , MonadIO
             , MonadReader Environment
             )

runAppM :: Environment -> AppM a -> IO a
runAppM env = flip runReaderT env . unAppM

askSomeValue :: AppM String
askSomeValue = asks envSomeValue

class MonadReader env m => HasSomeValue env m where
  getSomeValue :: m String

instance HasSomeValue Environment AppM where
  getSomeValue = asks envSomeValue

class MonadIO m => MonadPrompt m where
  prompt :: String -> m String

instance MonadPrompt AppM where
  prompt s = do
    liftIO $ putStr s
    liftIO $ hFlush stdout
    liftIO getLine

class MonadIO m => MonadConsole m where
  logStrLn :: String -> m ()
  logStr :: String -> m ()

instance MonadConsole AppM where
  logStrLn s = liftIO $ putStrLn s
  logStr s = liftIO $ putStr s

-- Very uncreative name. It just groups multiple constraints together under a new name. This requires ConstraintKinds as well.
type MonadApp env m
  = ( MonadPrompt m
    , MonadConsole m
    , HasSomeValue env m
    )

-- app :: AppM ()
app :: MonadApp Environment m => m ()
app = do
  v <- getSomeValue
  i <- prompt "Some other value> "

  logStrLn $ show (v, i)

main :: IO ()
main = runAppM env app

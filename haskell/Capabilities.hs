{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- {-# LANGUAGE ConstraintKinds #-}

import Control.Monad.Reader
import System.IO (hFlush, stdout)

data Environment = Environment
  { envSomeValue :: String
  }

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

-- Very uncreative name. It just groups multiple constraints together under a new name. This requires ConstraintKinds as well. TODO: Create a typeclass for askSomeValue aka HasSomeValue
-- type MonadApp m = (MonadPrompt m, MonadConsole m)

-- app :: MonadPromptConsole m => m ()
app :: AppM ()
app = do
  v <- askSomeValue
  i <- prompt "Some other value> "

  logStrLn $ show (v, i)

main :: IO ()
main = runAppM env app

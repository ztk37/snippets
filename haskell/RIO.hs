{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Control.Monad.Reader
import System.Directory

data Connection = Connection
  deriving (Eq, Show)

connect :: IO Connection
connect = return Connection -- fake implementation

data Ctx = Ctx
  { _rootPath :: !FilePath
  , _connection :: !Connection
  } deriving (Eq, Show)

-- | RIO is just a wrapper around ReaderT over IO
newtype RIO a = RIO
  { unRIO :: ReaderT Ctx IO a
  } deriving ( Functor
             , Applicative
             , Monad
             , MonadIO
             , MonadReader Ctx
             )

runRIO :: RIO a -> Ctx -> IO a
runRIO = runReaderT . unRIO

run :: RIO ()
run = do
  cd <- useRootPath
  liftIO $ putStrLn cd

initCtx :: IO Ctx
initCtx = Ctx <$> getCurrentDirectory <*> connect 

useRootPath :: RIO FilePath
useRootPath = _rootPath <$> ask

useConnection :: RIO Connection
useConnection = _connection <$> ask

main :: IO ()
main = do
  ctx <- initCtx
  runRIO run ctx

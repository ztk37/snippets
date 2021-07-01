module Main (main) where

import Data.Functor.Identity

import Control.Monad.Reader
import Control.Monad.State

type App = AppWith ()
type AppWith a = AppT Identity a

newtype AppT m a = AppT
  { unAppT :: (ReaderT [String] (StateT [String] m) a) }

dummyAppT :: Monad m => AppT m ()
dummyAppT = AppT $ do
  return ()

dummyApp :: App
dummyApp = AppT $ do
  return ()

-- alternative:
-- flip runStateT [] . flip runReaderT [] . unAppT :: AppT m a -> m (a, [String])

runAppT :: Monad m => AppT m a -> m [String]
runAppT = flip execStateT [] . flip runReaderT [] . unAppT

runApp :: AppWith a -> [String]
runApp = runIdentity . runAppT

main :: IO ()
main = return ()

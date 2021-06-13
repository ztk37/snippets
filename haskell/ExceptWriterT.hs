{-# LANGUAGE CPP, PackageImports, RankNTypes #-}

import "mtl" Control.Monad.Trans
import "mtl" Control.Monad.Identity hiding (fail)
import "transformers" Control.Monad.Trans.Except
import "transformers" Control.Monad.Trans.Writer

import Data.Functor.Identity

newtype WM m a = WM
  { unWM :: ExceptT String (WriterT [String] m) a }

type W a = WM Identity a

instance Functor m => Functor (WM m) where
  fmap f = WM . fmap f . unWM

instance (Functor m, Monad m) => Applicative (WM m) where
  pure = WM . pure
  WM mf <*> WM mx = WM (mf <*> mx)

instance Monad m => Monad (WM m) where
  return = WM . return
  WM mx >>= f = WM (mx >>= unWM . f)

instance MonadTrans WM where
  lift = WM . lift . lift

instance MonadIO m => MonadIO (WM m) where
  liftIO = lift . liftIO

addItem :: Monad m => String -> WM m ()
addItem s = WM $ lift $ tell [s]

w :: W ()
w = do
  addItem "foo"
  addItem "bar"
  addItem "fib"
  -- fail "derp"

  -- (Left "derp",["foo","bar","fib"])
  -- WM $ throwE "derp"

  return ()

runWM = runWriterT . runExceptT . unWM

runW =  runIdentity . runWM

main = print $ runW w

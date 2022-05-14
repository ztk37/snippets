{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Control.Monad.Reader

newtype T m a = T
  { runT :: (String, Int) -> m a
  } deriving ( Functor
             , Applicative
             , Monad
             , MonadIO
             , MonadReader (String, Int)
             ) via (ReaderT (String, Int) m)

t :: T IO Int
t = T $ \(s, n) -> return (length s + n)

main :: IO ()
main = do
  r <- runT t ("Foo", 2)

  print r

{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main (main) where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.Except

newtype App a = App
  { unApp :: ReaderT String (ExceptT String IO) a
  } deriving ( Functor
             , Applicative
             , Monad
             , MonadError String
             )

runApp :: String -> App a -> IO (Either String a)
runApp env = runExceptT . flip runReaderT env . unApp


main :: IO ()
main = do
  result <- runApp "env" $ do
    throwError "not the answer"

    return ()

  print result

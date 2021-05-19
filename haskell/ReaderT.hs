{-# LANGUAGE FlexibleContexts #-}

module Main (main) where

import Control.Monad.Reader

data Context = Context
  { ctxName :: String
  }

type App a = ReaderT Context IO a

askCtxName :: MonadReader Context f => f String
askCtxName = ctxName <$> ask

runApp :: App a -> IO a
runApp app = runReaderT app ctx
  where
    ctx = Context
      { ctxName = "App"
      }

run :: IO String
run = runApp $ do
  name <- ctxName <$> ask
  return $ name

main :: IO ()
main = run >>= putStrLn

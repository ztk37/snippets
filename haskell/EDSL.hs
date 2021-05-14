{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main (main) where

import           Control.Monad.Trans.Writer

import           Data.Map (Map)
import qualified Data.Map as Map

type Store = Map String Int

newtype EDSL a = EDSL
  { unEDSL :: (WriterT Store IO a) }
  deriving (Functor, Applicative, Monad)

runEDSL :: EDSL a -> IO (a, Store)
runEDSL = runWriterT . unEDSL

execEDSL :: EDSL a -> IO Store
execEDSL = execWriterT . unEDSL

tellStoreEntry :: String -> Int -> EDSL ()
tellStoreEntry k v = EDSL $ tell $ Map.singleton k v

example :: EDSL ()
example = do
  tellStoreEntry "Alpha" 1
  tellStoreEntry "Beta" 2
  tellStoreEntry "Gamma" 3

main :: IO ()
main = execEDSL example >>= print

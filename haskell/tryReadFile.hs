{-# LANGUAGE ExistentialQuantification #-}

module Main (main) where

import Data.Maybe

import Control.Exception
import Control.Monad

import System.IO.Error

data MyError = MyError
  { unMyError :: String
  } deriving Show

instance Exception MyError where

data Thing = forall a. Show a => Thing a

instance Show Thing where
  show (Thing x) = show x

tryReadFile :: FilePath -> IO (Maybe String)
tryReadFile file = do
  r <- tryJust (guard . isDoesNotExistError) (readFile file)
  return $ either (const Nothing) Just r

main :: IO ()
main = tryReadFile "main.hs"
  >>= return . fromMaybe "no content"
  >>= putStrLn

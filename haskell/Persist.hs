{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Main (main) where

newtype Content a = Content
  { contentBody :: a
  } deriving Show

class Savable a where
  save :: FilePath -> Content a -> IO ()

instance Savable String where
  save fp = writeFile fp . contentBody

class Loadable a where
  load :: FilePath -> IO (Content a)

instance Loadable String where
  load fp = Content <$> readFile fp

  
main :: IO ()
main = do
  save "file.txt" (Content "some content")

  load "file.txt" >>= putStrLn . contentBody

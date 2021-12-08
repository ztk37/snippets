module Main (main) where

import Control.Monad
import System.Directory
import System.FilePath
import System.Posix.Files

-- | Traverse from 'top' directory and return all the files by
-- filtering out the 'exclude' predicate.
traverseDir :: FilePath -> (FilePath -> Bool) -> IO [FilePath]
traverseDir top exclude = do
  ds <- getDirectoryContents top
  paths <- forM (filter (not.exclude) ds) $ \d -> do
    let path = top </> d
    s <- getFileStatus path
    if isDirectory s
      then traverseDir path exclude
      else return [path]
  return (concat paths)

main :: IO ()
main = traverseDir "<root>" (`elem` [".", ".."]) >>= print

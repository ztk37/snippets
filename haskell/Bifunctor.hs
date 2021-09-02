module Main (main) where

import Data.Bifunctor

data RemoteData e a
  = NotLoaded
  | Loading
  | Success a
  | Failure e
  deriving (Eq, Show)

instance Functor (RemoteData e) where
  fmap _ NotLoaded = NotLoaded
  fmap _ Loading = Loading
  fmap f (Success a) = Success (f a)
  fmap _ (Failure e) = Failure e

instance Bifunctor RemoteData where
  bimap _ _ NotLoaded = NotLoaded
  bimap _ _ Loading = Loading
  bimap _ g (Success a) = Success (g a)
  bimap f _ (Failure e) = Failure (f e)

main :: IO ()
main = putStrLn "Hello, World!"

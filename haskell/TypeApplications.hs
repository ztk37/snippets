{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Data.Proxy (Proxy(..))

data A
data B
data C

type ABC = Proxy

abc :: forall a. ABC a
abc = Proxy

main :: IO ()
main = do
  print $ abc @A
  print $ abc @B
  print $ abc @C

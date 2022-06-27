{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Proxy
import GHC.TypeLits

data Count (n :: Nat)

countZero :: Proxy (Count 0)
countZero = Proxy

inc :: Proxy (Count n) -> Proxy (Count (n + 1))
inc _ = Proxy

reset :: Proxy (Count n) -> Proxy (Count 0)
reset _ = Proxy

main :: IO ()
main = print $ inc $ inc $ inc $ countZero

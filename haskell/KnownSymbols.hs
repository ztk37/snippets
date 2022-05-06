{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE KindSignatures             #-}
-- ScopedTypeVariables is needed, or it crushes}
{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE TypeOperators              #-}

module Main (main) where

import Data.Proxy (Proxy(..))
import GHC.TypeLits

class KnownSymbols (s :: [Symbol]) where
    symbolVals :: Proxy s -> [String]

instance KnownSymbols '[] where
    symbolVals _ = []

instance (KnownSymbol s, KnownSymbols ss) => KnownSymbols (s ': ss) where
    symbolVals _ = symbolVal (Proxy :: Proxy s) : symbolVals (Proxy :: Proxy ss)

symbols :: Proxy ["A", "B", "C"]
symbols = Proxy

main :: IO ()
main = print $ symbolVals symbols -- => ["A", "B", "C"]

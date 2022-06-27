{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PolyKinds  #-}
{-# LANGUAGE FlexibleInstances  #-}

module Main where

import Data.Proxy
import GHC.TypeLits

data (a :: k) :=> (b :: k)

class ToDict (xs :: [*]) where
  toDict :: Proxy xs -> [(String, String)]

class ToTuple (a :: Symbol) (b :: Symbol) where
  toTuple :: Proxy (a :=> b) -> (String, String)

instance ( KnownSymbol a, KnownSymbol b) => ToTuple a b where
  toTuple _ = (symbolVal (Proxy :: Proxy a), symbolVal (Proxy :: Proxy b))

instance ToDict '[] where
  toDict _ = []

instance (ToTuple key value, ToDict xs) => ToDict ((key :=> value) ': xs) where
  toDict _ = toTuple (Proxy :: Proxy (key :=> value)) : toDict (Proxy :: Proxy xs)

pair :: Proxy ("K" :=> "V")
pair = Proxy

dict :: Proxy '[("A" :=> "a"), ("B" :=> "b"), ("C" :=> "c")]
dict = Proxy

main :: IO ()
main = do
  print $ toTuple pair
  print $ toDict dict

{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE KindSignatures             #-}
{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE TypeOperators              #-}

module Main (main) where

import Data.Proxy (Proxy(..))
import GHC.TypeLits

data Triple (a :: Symbol) (b :: Symbol) (c :: Symbol) = Triple
  deriving (Eq, Show)

tripleValues
  :: forall a b c.
    ( KnownSymbol a
    , KnownSymbol b
    , KnownSymbol c
    )
  => Triple a b c
  -> [String]
tripleValues _ =
  [ symbolVal (Proxy :: Proxy a)
  , symbolVal (Proxy :: Proxy b)
  , symbolVal (Proxy :: Proxy c)
  ]

triple :: Triple "A" "B" "C"
triple = Triple

main :: IO ()
main = print $ tripleValues triple

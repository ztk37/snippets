{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables  #-}
{-# LANGUAGE DataKinds #-}

module Main where

import Data.Proxy (Proxy(..))

data A
data B
data C

data Item = Item Char
  deriving (Eq, Show)

class ToItem a where
  toItem :: Proxy a -> Item
instance ToItem A where
  toItem Proxy = Item 'A'
instance ToItem B where
  toItem Proxy = Item 'B'
instance ToItem C where
  toItem Proxy = Item 'C'

class ToItems (a :: [*]) where
  toItems :: Proxy a -> [Item]

instance ToItems '[] where
  toItems Proxy = []

instance (ToItem x, ToItems xs) => ToItems (x ': xs) where
  toItems Proxy = toItem (Proxy :: Proxy x) : toItems (Proxy :: Proxy xs)

main :: IO ()
main = do
  print $ toItem (Proxy :: Proxy A)
  print $ toItem (Proxy :: Proxy B)
  print $ toItem (Proxy :: Proxy C)
  print $ toItems (Proxy :: Proxy '[])
  print $ toItems (Proxy :: Proxy '[A, A, B, B, C, A, C, A])


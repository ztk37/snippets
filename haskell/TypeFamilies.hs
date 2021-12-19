{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RankNTypes #-}

module Main (main) where

type Not = Bool -> Bool

type family Not' a where
  Not' True = False
  Not' False = True

type And = Bool -> Bool -> Bool

type family And' a b where
  And' True True = True
  And'    _    _ = False

type Or = Bool -> Bool -> Bool

type family Or' a b where
  Or' False False = False
  Or'     _     _ = True

-- :kind! Or' True True => True'

type ToMaybe = forall a. a -> Maybe a

type family ToMaybe' a where
  ToMaybe' a = Just a

newtype X = X
  { unX :: ToMaybe
  }

main :: IO ()
main =
  let
    x = X Just
  in
    print $ unX x True

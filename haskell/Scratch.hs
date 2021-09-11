module Scratch where

{-# LANGUAGE NoImplicitPrelude #-}

data Option a = Some a | None

instance Show a => Show (Option a) where
  show (Some x) = "Some(" ++ show x ++ ")"
  show None = "None"

instance Functor Option where
  fmap f (Some x) = Some (f x)
  fmap _ None = None

instance Applicative Option where
  pure = Some
  Some f <*> m = fmap f m
  None <*> _m = None

instance Monad Option where
  return = pure
  Some x >>= k = k x
  None >>= _ = None

data Result e a = Ok a | Err e

instance (Show e, Show a) => Show (Result e a) where
   show (Ok x) = "Ok(" ++ show x ++ ")"
   show (Err e) = "Err(" ++ show e ++ ")"

instance Functor (Result e) where
  fmap f (Ok x) = Ok (f x)
  fmap _ (Err e) = Err e

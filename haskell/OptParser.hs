module Main (main) where

import Data.Char (toUpper)
import Data.Monoid (Endo(..))

data OptParser a
  = OptSuccess (Endo a)
  | OptFailure [String]

instance Semigroup (OptParser a) where
  a <> b =
    case (a, b) of
      (OptSuccess x, OptSuccess y) -> OptSuccess (x <> y)
      (OptFailure xs, OptFailure ys) -> OptFailure (xs <> ys)
      (OptFailure _, _) -> a
      (_, OptFailure _) -> b

instance Monoid (OptParser a) where
  mempty = OptSuccess (Endo id)
  mappend = (<>)

runOptParser :: a -> OptParser a -> Either [String] a
runOptParser def op = case op of
  (OptSuccess p) -> Right $ appEndo p def
  (OptFailure errs) -> Left errs

modify :: (a -> a) -> OptParser a
modify = OptSuccess . Endo

abort :: String -> OptParser a
abort x = OptFailure [x]

main :: IO ()
main =
  let
    mod = mconcat
     [ modify reverse
     , modify (map toUpper)
     , abort "foo"
     , abort "bar"
     ]
    output = runOptParser "foo" mod
  in print outputmodule Main (main) where

import Data.Char (toUpper)
import Data.Monoid (Endo(..))

data OptParser a
  = OptSuccess (Endo a)
  | OptFailure [String]

instance Semigroup (OptParser a) where
  a <> b =
    case (a, b) of
      (OptSuccess x, OptSuccess y) -> OptSuccess (x <> y)
      (OptFailure xs, OptFailure ys) -> OptFailure (xs <> ys)
      (OptFailure _, _) -> a
      (_, OptFailure _) -> b

instance Monoid (OptParser a) where
  mempty = OptSuccess (Endo id)
  mappend = (<>)

runOptParser :: a -> OptParser a -> Either [String] a
runOptParser def op = case op of
  (OptSuccess p) -> Right $ appEndo p def
  (OptFailure errs) -> Left errs

modify :: (a -> a) -> OptParser a
modify = OptSuccess . Endo

abort :: String -> OptParser a
abort x = OptFailure [x]

main :: IO ()
main =
  let
    mod = mconcat
     [ modify reverse
     , modify (map toUpper)
     , abort "foo"
     , abort "bar"
     ]
    output = runOptParser "foo" mod
  in print output

{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.List (intercalate)
import           Data.Text (Text)
import qualified Data.Text as T

data Term
  = Term Text
  | CompoundTerm [Text]
  deriving (Eq)

{--
   TBD: make Term a phantom Type?
   @Term tag@ for example @Term Label@
--}
type Category = Term
type Topic = Term
type Label = Term

instance Show Term where
  show (Term t) = T.unpack t
  show (CompoundTerm ts) = T.unpack $ T.intercalate "-" ts

mkTerm :: String -> Maybe Term
mkTerm s
  | null s = Nothing
  | otherwise = Just $ Term (T.pack s)

toTerm :: String -> Maybe Term
toTerm s =
  case T.splitOn "-" (T.pack s) of
    []  -> Nothing
    [t] -> Just $ Term t
    ts  -> Just $ CompoundTerm ts

fromTerm :: Term -> String
fromTerm (Term t) = T.unpack t
fromTerm (CompoundTerm ts) = T.unpack $ T.intercalate "." ts

isCompoundTerm :: Term -> Bool
isCompoundTerm (CompoundTerm _) = True
isCompoundTerm _ = False

isTerm :: Term -> Bool
isTerm (Term _) = True
isTerm _ = False

instance Semigroup Term where
  Term          a <>      Term     b = CompoundTerm [a, b]
  Term          a <> CompoundTerm bs = CompoundTerm ([a] <> bs)
  CompoundTerm as <>      Term     b = CompoundTerm (as <> [b])
  CompoundTerm as <> CompoundTerm bs = CompoundTerm (as <> bs)

main :: IO ()
main = do
  let term1 = mkTerm "A"
  let term2 = mkTerm "B"
  let term3 = mkTerm "C"
  let term4 = mkTerm "D"
  let compound1 = term1 <> term2
  let compound2 = compound1 <> term3
  let compound3 = term3 <> term4
  let compound4 = compound1 <> compound3

  print compound1
  print compound2
  print compound3
  print compound4

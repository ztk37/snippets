{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

module TypeFamilies where

import Data.Proxy (Proxy (..))
import GHC.TypeLits

data SBool (a :: Bool) where
  STrue :: SBool 'True
  SFalse :: SBool 'False

instance Show (SBool a) where
  showsPrec _ STrue = showString "STrue"
  showsPrec _ SFalse = showString "SFalse"

class SBoolI (a :: Bool) where
  sbool :: SBool a

instance SBoolI 'True where
  sbool = STrue

instance SBoolI 'False where
  sbool = SFalse

fromSBool :: SBool b -> Bool
fromSBool STrue = True
fromSBool SFalse = False

data ABC = A | B | C
  deriving (Eq, Show)

type IncludedA xs = IncludedA' 'False xs

type family IncludedA' (acc :: Bool) (xs :: [ABC]) :: Bool where
  IncludedA' acc '[] = acc
  IncludedA' acc (A : _) = True
  IncludedA' acc (_ : xs) = IncludedA' acc xs

type Counts xs = Counts' '(0, 0, 0) xs

type family Counts' (acc :: (Nat, Nat, Nat)) (xs :: [ABC]) :: (Nat, Nat, Nat) where
  Counts' acc '[] = acc
  Counts' '(as, bs, cs) (A : xs) = Counts' '(1 + as, bs, cs) xs
  Counts' '(as, bs, cs) (B : xs) = Counts' '(as, 1 + bs, cs) xs
  Counts' '(as, bs, cs) (C : xs) = Counts' '(as, bs, 1 + cs) xs

type Count = Counts '[A, A, B, B, A, B, B, C, C, B, C, A, A, A, C, C, A, A, C, C, C, B, A, A, A, C, B, A, C, A]

type family When (cond :: Bool) (body :: *) :: * where
  When 'True body = body
  When 'False _ = ()

module IsBoolLike where

{-# OPTIONS_GHC
    -ddump-deriv
    -dsuppress-idinfo
    -dsuppress-coercions
    -dsuppress-type-applications
    -dsuppress-uniques
    -dsuppress-module-prefixes
#-}

data YesNo = Yes | No
  deriving (Eq, Show)

data KnownUnknown = Known | Unknown
  deriving (Eq, Show)

class IsBoolLike a where
  toBool :: a -> Bool
  fromBool :: Bool -> a

instance IsBoolLike YesNo where
  toBool Yes = True
  toBool No = False
  
  fromBool True = Yes
  fromBool False = No

instance IsBoolLike KnownUnknown where
  toBool Known = True
  toBool Unknown = False
  
  fromBool True = Known
  fromBool False = Unknown

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
-- {-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE FlexibleInstances #-}

import Data.Proxy
import GHC.TypeLits

data Prop k v

type Props =
  '[ Prop "A" 1
   , Prop "B" "b"
   , Prop "C" True
   , Prop "C" False
   ]

data Value
  = VInteger Integer
  | VString String
  | VBool Bool
  deriving (Eq, Show)

class KnownValue a where
  getKnownValue :: Proxy a -> Value

instance KnownSymbol a => KnownValue a where
  getKnownValue _ = VString (symbolVal (Proxy @a))

instance KnownNat a => KnownValue a where
  getKnownValue _ = VInteger (natVal (Proxy @a))

instance KnownValue 'True where
  getKnownValue _ = VBool True

instance KnownValue 'False where
  getKnownValue _ = VBool False

props :: Proxy Props
props = Proxy

class KnownProp p where
  propVal :: Proxy p -> (String, Value)

instance (KnownSymbol k, KnownValue v) => KnownProp (Prop k v) where
  propVal _ = (symbolVal (Proxy @k), getKnownValue (Proxy @v))

class KnownProps ps where
  propVals :: Proxy ps -> [(String, Value)]

instance KnownProps '[] where
  propVals _ = []

instance (KnownProp p, KnownProps ps) => KnownProps (p ': ps) where
  propVals _ = propVal (Proxy @p): propVals (Proxy @ps)


main :: IO ()
main = print $ propVals props

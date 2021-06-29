{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE OverloadedStrings #-}

import           Data.Text (Text)
import qualified Data.Text as Text
import           Data.Map (Map)
import qualified Data.Map as Map

type Identifier = Text

data Attributes = Attributes
  { attrs :: [Attribute]
  } deriving (Eq, Show)

data AttributeMap = AttributeMap (Map Identifier Attribute)
  deriving (Semigroup, Monoid) via AttributeMap

singleton :: Identifier -> Attribute -> AttributeMap
singleton k v = AttributeMap $ Map.singleton k v

instance Semigroup Attributes where
  (Attributes xs) <> (Attributes ys) =
    Attributes (xs <> ys)

instance Monoid Attributes where
  mempty = Attributes []

data Attribute = Attribute
  { attrId :: Identifier
  } deriving (Eq, Show)

main = putStrLn "Hello, World!"

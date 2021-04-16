module Main
  ( Config(..)
  , entry
  , entryWith
  , main
  ) where

import Control.Monad.Trans.Writer

type WriteM = Writer PropWrap ()

data PropWrap = PropWrap [Props]
  deriving (Eq)

instance Show PropWrap where
  show (PropWrap props) = unlines $ map show props


instance Semigroup PropWrap where
  (PropWrap props1) <> (PropWrap props2) =
    PropWrap (props1 <> props2)

instance Monoid PropWrap where
   mempty = PropWrap []
   mappend = (<>)

data Props = Props
  { propA :: String
  , propB :: Int
  } deriving (Eq)

data Mod = Mod (Props -> Props)

instance Semigroup Mod where
  Mod f <> Mod g = Mod (f . g)

instance Monoid Mod where
  mempty = Mod id

modPropA :: String -> Mod
modPropA x = Mod $ \props -> props { propA = x }

modPropB :: Int -> Mod
modPropB x = Mod $ \props -> props { propB = x }

setPropA :: String -> Props -> Props
setPropA x props = props { propA = x }

setPropB :: Int -> Props -> Props
setPropB x props = props { propB = x }

emptyProps :: Props
emptyProps = Props "" 0

applyMod :: Mod -> Props
applyMod (Mod f) = f emptyProps

instance Show Props where
  show (Props a b) = "Props (" ++ a ++ ", " ++ show b ++ ")"

data AuthorInfo = AuthorInfo
  { authorName :: String
  , authorEmail :: String
  } deriving (Eq, Show)

data Config = Config
  { confAnswer :: Int
  , confAuthorInfo :: AuthorInfo
  }

defaultConfig :: Config
defaultConfig = Config
  { confAnswer = 42
  , confAuthorInfo = AuthorInfo
    { authorName = ""
    , authorEmail = ""
    }
  }

entry :: WriteM -> IO ()
entry = entryWith defaultConfig

entryWith :: Config -> WriteM -> IO ()
entryWith config = print . execWriter

wrap :: Props -> WriteM
wrap props = tell $ PropWrap [props]

main :: IO ()
main = entry $ do
  tell $ PropWrap [Props "A" 1]
  tell $ PropWrap [Props "B" 2]
  tell $ PropWrap [Props "C" 3]
  wrap $ do
    Props "D" 4
  wrap $ setPropA "Foo" emptyProps
  wrap $ applyMod $ modPropA "Derp" <> modPropB 42

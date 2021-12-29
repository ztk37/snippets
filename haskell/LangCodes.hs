module Main (main) where

import Data.Proxy (Proxy(..))

data DE
data EN

data LangCode
  = DE
  | EN
  deriving (Eq, Show)

type Lang a = Proxy a

de :: Lang DE
de = Proxy

en :: Lang EN
en = Proxy

class ToLangCode a where
  toLangCode :: Lang a -> LangCode

instance ToLangCode DE where
  toLangCode _ = DE
instance ToLangCode EN where
  toLangCode _ = EN

class FromLangCode a where
  fromLangCode :: LangCode -> Lang a

instance FromLangCode DE where
  fromLangCode DE = Proxy
instance FromLangCode EN where
  fromLangCode EN = Proxy

main :: IO ()
main = do
  print $ de -- Output => Proxy
  print $ en -- Output => Proxy

  print $ toLangCode de -- Output => DE
  print $ toLangCode en -- Output => EN

  print $ (fromLangCode DE :: Lang DE) -- Output => Proxy
  print $ (fromLangCode EN :: Lang EN) -- Output => Proxy

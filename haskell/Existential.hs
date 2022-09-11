{-# LANGUAGE ExistentialQuantification #-}

import Data.Proxy

data DE
data EN

-- sum type
data LangCode
  = DE
  | EN
  deriving (Eq, Show)

-- existential for type-level proxies
type Lang = Proxy
data SomeLang = forall a. ToLangCode a => SomeLang (Lang a)
instance Show SomeLang where
  show (SomeLang lang) = "SomeLang Proxy<" ++ show (toLangCode' lang) ++ ">"

-- convert from LangCode to SomeLang
fromLangCode :: LangCode -> SomeLang
fromLangCode EN = SomeLang (Proxy :: Lang EN)
fromLangCode DE = SomeLang (Proxy :: Lang DE)

-- convert from SomeLang to LangCode
class ToLangCode lang where
  toLangCode' :: Lang lang -> LangCode
instance ToLangCode EN where
  toLangCode' Proxy = EN
instance ToLangCode DE where
  toLangCode' Proxy = DE
toLangCode :: SomeLang -> LangCode
toLangCode (SomeLang lang) = toLangCode' lang

de :: SomeLang
de = SomeLang (Proxy :: Lang DE)

en :: SomeLang
en = SomeLang (Proxy :: Lang EN)

main :: IO ()
main = do
  print $ de -- Output => SomeLang Proxy<DE>
  print $ en -- Output => SomeLang Proxy<EN>

  print $ toLangCode de -- Output => DE
  print $ toLangCode en -- Output => EN

  print $ fromLangCode DE -- Output => SomeLang Proxy<DE>
  print $ fromLangCode EN -- Output => SomeLang Proxy<EN>

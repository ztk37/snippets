{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module QQ where

import Language.Haskell.TH
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Syntax

qq :: QuasiQuoter
qq = QuasiQuoter
  { quoteExp = liftString
  , quotePat = const $ error "quotePat not implemented for qq"
  , quoteType = const $ error "quoteType not implemented for qq"
  , quoteDec = const $ error "quoteDec not implemented for qq"
  }

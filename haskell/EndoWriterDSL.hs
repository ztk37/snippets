{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Data.Monoid
import Control.Monad.Trans.Writer

data Context = Context
  { ctxName :: String
  , ctxVersion :: String
  , ctxDescription :: Maybe String
  } deriving (Show)

emptyContext :: Context
emptyContext =
  Context
    { ctxName = ""
    , ctxVersion = ""
    , ctxDescription = Nothing
    }

type DSL = DslM ()

newtype DslM a = DslM (Writer (Endo Context) a)
  deriving (Functor, Applicative, Monad)

-- No Wrapper Type
-- type DSL = Writer (Endo Context) ()
-- tellDSL = tell . Endo

tellDSL :: (Context -> Context) -> DSL
tellDSL = DslM . tell . Endo

name :: String -> DSL
name val = tellDSL $ \ctx -> ctx { ctxName = val }

version :: String -> DSL
version val = tellDSL $ \ctx -> ctx { ctxVersion = val }

description :: String -> DSL
description val = tellDSL $ \ctx -> ctx { ctxDescription =  Just val }

runDSL :: DSL -> Context
runDSL (DslM builder) = appEndo (execWriter builder) emptyContext 

main :: IO ()
main = print $ runDSL $ do
  name "Foo"
  version "0.1.0"
  description "dasddasd"

{-# LANGUAGE DeriveGeneric #-}

import           GHC.Generics
import           Data.Map (Map)
import qualified Data.Map as Map
import System.Environment

newtype Env = Env (Map String String)
  deriving (Eq, Show, Generic)

emptyEnv :: Env
emptyEnv = Env Map.empty

prettyEnvVar :: (String, String) -> String
prettyEnvVar (k, v) = k ++ ": " ++ v

main :: IO ()
main = getEnvironment
  >>= return . unlines . fmap prettyEnvVar
  >>= putStr

main' :: IO ()
main' = putStr
  =<< return . unlines . fmap prettyEnvVar
  =<< getEnvironment 

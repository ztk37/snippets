module Main where

import Data.Map (Map)
import Data.Map as Map

type Settings = Map String String

emptySettings :: Settings
emptySettings = Map.empty

withNameS :: String -> Settings -> Settings
withNameS = Map.insert "name"

withVersionS :: String -> Settings -> Settings
withVersionS = Map.insert "version"

data SettingsM = SettingsM
  { unSettingsM :: [(String, String)]
  } deriving (Show)

instance Semigroup SettingsM where
  (<>) = mappend

instance Monoid SettingsM where
  mempty = SettingsM []
  (SettingsM sx) `mappend` (SettingsM sy) = SettingsM (sx ++ sy)

emptySettingsM :: SettingsM
emptySettingsM = mempty

withNameM :: String -> SettingsM
withNameM name = SettingsM [("name", name)]

withVersionM :: String -> SettingsM
withVersionM version = SettingsM [("version", version)]

emptyOptions :: [(String, String)]
emptyOptions = []

withName :: String -> [(String, String)] -> [(String, String)]
withName value = (++)[("name", value)]

withVersion:: String -> [(String, String)] -> [(String, String)]
withVersion value = (++)[("name", value)]

main' :: IO ()
main' = print $ (withVersion "0.1.0") $ (withName "sad") $ emptyOptions

main :: IO ()
main = print $ (withVersionS "0.1.0") $ (withNameS "sad") $ emptySettings

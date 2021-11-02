module Main (main) where

import Data.Monoid (Endo(..))

import Control.Monad.Writer

data Options = Options
  { optHome     :: FilePath
  , optVerbose  :: Bool
  , optIncludes :: [String] 
  , optExcludes :: [String] 
  } deriving Show

type OptionBuilder = Writer (Endo Options) () 

emptyOptions :: Options
emptyOptions =
  Options
    { optHome     = ""
    , optVerbose  = False
    , optIncludes = []
    , optExcludes = []
    }

execOptionBuilder :: OptionBuilder -> Options
execOptionBuilder = flip appEndo emptyOptions . execWriter

home :: FilePath -> OptionBuilder
home opt = tell $ Endo $ \opts -> opts { optHome = opt }

verbose :: OptionBuilder
verbose = tell $ Endo $ \opts -> opts { optVerbose = True }

include :: String -> OptionBuilder
include opt = tell $ Endo $ \opts -> opts { optIncludes = opt : optIncludes opts }

exclude :: String -> OptionBuilder
exclude opt = tell $ Endo $ \opts -> opts { optExcludes = opt : optExcludes opts }

options :: OptionBuilder
options = do
  home "foo"
  verbose
  include "foo"
  include "bar"
  exclude "derp"

main :: IO ()
main = print $ execOptionBuilder options

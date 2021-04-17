import Data.Char (isSpace)
import Data.List (isPrefixOf)

data CmdKind
  = Run
  | Log
  deriving (Show)

data Command = Command
  { cmdKind :: CmdKind
  , cmdDebug :: String
  } deriving (Show)

fromString :: String -> Maybe Command
fromString input
  | isPrefixOf "RUN" input =
      parseNext Run $ (dropWhile isSpace . drop 3) input
  | isPrefixOf "LOG" input =
      parseNext Log $ (dropWhile isSpace . drop 3) input
  | otherwise = Nothing

parseNext :: CmdKind -> String -> Maybe Command
parseNext kind input = Just $ Command kind input

main = print $ fromString "RUN abcdefghijklmnopqrstuvwxyz"

module Main (main) where

import Text.Read (readMaybe)
import Text.Parsec as P

type Parser = P.Parsec String () String

run :: Parser
run = do
  P.string "Feature"
  P.spaces

  return "Feature"

run0 :: Parser
run0 = do
  P.string "Task"
  P.spaces

  return "Task"

runParser :: String -> Either ParseError String
runParser = P.parse run "(source)"

useParser
  :: String
  -> Parser
  -> Either ParseError String
useParser s p = P.parse p "(source)" s

input :: String
input = "Feature ( )"

data Scope
  = Feature
  | Task
  | Bug
  deriving (Eq, Show, Read)

readScope :: String -> Either String Scope
readScope str =
  case readMaybe str of
    Just scope -> Right scope
    Nothing -> Left $ "Unknown: " ++ str

data FeatureW = FeatureW String deriving (Eq, Show)

parseScope :: P.Parsec String () FeatureW
parseScope = do
  P.string "Feature"
  P.spaces
  P.char '('
  P.spaces
  scope <- P.many1 P.letter
  P.spaces
  P.char ')'
  P.spaces
  P.char ':'

  return $ FeatureW scope

main :: IO ()
main = do
  print $ Main.runParser input
  print $ P.parse run0 "(source)" input

  print $ useParser "Feature ( )" $ do
    token <- P.many P.anyChar
    return token

  print $ P.parse parseScope "(source)" "Feature (sdasd)"

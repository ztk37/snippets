module Main where

import Text.Parsec

input :: String
input = unlines
  [ ""
  , ""
  , "PACKAGE foo"
  , ""
  , ""
  , "ECHO bar"
  , ""
  , ""
  , "ECHO bar"
  , ""
  , "EXPORT fib"
  ]

data Token
  = Package String
  | Echo String
  | Export String
  deriving (Eq, Show)

packageP :: Parsec String () Token
packageP =
  Package
    <$ string "PACKAGE"
    <* spaces
    <*> many1 letter
    <* spaces

echoP :: Parsec String () Token
echoP =
  Echo
    <$ string "ECHO"
    <* spaces
    <*> many1 letter
    <* spaces

exportP :: Parsec String () Token
exportP =
  Export
    <$ string "EXPORT"
    <* spaces
    <*> many1 letter
    <* spaces

tokenP :: Parsec String () Token
tokenP = choice $ try <$> [packageP, echoP, exportP]

data Module = Module [Token]
  deriving (Eq, Show)

moduleP :: Parsec String () (Module)
moduleP =
  Module
    <$ spaces
    <*> many tokenP
    <* eof

parseModule :: String -> Either ParseError Module
parseModule = parse moduleP "(source)"

main :: IO ()
main = print $ parseModule input

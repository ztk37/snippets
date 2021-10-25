module Main (main) where

import Text.Parsec as P

input :: String
input = unlines
  [ "let foo = asdasfdsgs"
  , "let foo = true"
  , "let foo = 42"
  ]

parseBoolLit :: Parsec String () AST
parseBoolLit = do
  P.string "let"
  P.spaces
  ident <- P.many1 P.letter
  P.spaces
  P.char '='
  P.spaces
  value <- P.choice $ map P.string ["true", "false"]
  P.newline

  case value of
    "true" -> return $ BoolLit ident True
    "false" -> return $ BoolLit ident False

parseIntLit :: Parsec String () AST
parseIntLit = do
  P.string "let"
  P.spaces
  ident <- P.many1 P.letter
  P.spaces
  P.char '='
  P.spaces
  value <- read <$> P.many P.digit
  P.newline

  return $ IntLit ident value

parseStringLit :: Parsec String () AST
parseStringLit = do
  P.string "let"
  P.spaces
  ident <- P.many1 P.letter
  P.spaces
  P.char '='
  P.spaces
  value <- P.many P.letter
  P.newline

  return $ StringLit ident value

parseLit :: Parsec String () AST
parseLit = parseIntLit <|> parseBoolLit <|> parseStringLit
  
data AST
  = StringLit String String
  | IntLit String Int
  | BoolLit String Bool
  deriving (Eq, Show)

parseRoot :: String -> Either ParseError [AST]
parseRoot = P.parse (P.manyTill parseLit P.eof) "(source)"

main :: IO ()
main = print $ parseRoot input

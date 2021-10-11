module Main (main) where

import Text.Parsec as P

type Parser a = P.Parsec String () a

data ABC
  = A
  | B
  | C
  deriving (Eq, Show)

parseA :: Parser ABC
parseA = A <$ P.char 'A'

parseB :: Parser ABC
parseB = B <$ P.char 'B'

parseC :: Parser ABC
parseC = C <$ P.char 'C'

parseABC :: Parser ABC
parseABC = parseA <|> parseB <|> parseC

abc :: Parser [ABC]
abc = P.manyTill (P.choice [parseA, parseB, parseC]) P.eof

runABCParser :: String -> Either ParseError [ABC]
runABCParser = P.parse abc "(source)"

main :: IO ()
main = do
  case runABCParser "ABBABCABBCCAB" of
    Right parsed -> print parsed
    Left err -> print err
  
  case runABCParser "ABBABCABXBCCAB" of
    Right parsed -> print parsed
    Left err -> print err

  case P.parse (P.many1 parseABC) "(source)" "ABBABCABXBCCAB" of
    Right parsed -> print parsed
    Left err -> print err

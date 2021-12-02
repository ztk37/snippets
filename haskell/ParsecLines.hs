module Main (main) where

import Text.Parsec
import Text.Parsec.Error

type Parser m a = ParsecT String () m a

manyTill1
  :: Stream s m t
  => ParsecT s u m a
  -> ParsecT s u m end
  -> ParsecT s u m [a]
manyTill1 p e = (:) <$> p <*> manyTill p e

numberLineP :: Monad m => Parser m String
numberLineP =
  manyTill1 digit endl <* spaces <?> "number"

stringLineP :: Monad m => Parser m String
stringLineP =
  manyTill1 letter endl <* spaces <?> "string"

alphaNumLineP :: Monad m => Parser m String
alphaNumLineP =
  manyTill1 alphaNum endl <* spaces <?> "alphaNum"

p :: Monad m => Parser m [String]
p = manyTill (alphaNumLineP <|> numberLineP <|> stringLineP) eof

parseInput :: String -> Either ParseError [String]
parseInput = parse p "(source)"

endl :: Monad m => Parser m Char
endl = char '\n' <|> (char '\r' >> char '\n')

prettyPrint :: Either ParseError [String] -> IO ()
prettyPrint = either print print

input :: String
input = unlines
  [ "3423432"
  , ""
  , "sadasdsd"
  , "ddsad23da"
  , ""
  , "dasd"
  ]

main :: IO ()
main = prettyPrint $ parseInput input

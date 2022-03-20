{-# LANGUAGE OverloadedStrings #-}

import           Data.Char (toLower)
import           Data.Map (Map)
import qualified Data.Map as Map
import           Data.Text (Text)
import qualified Data.Text as Text

data BagOfWords = BagOfWords (Map Text Int)
  deriving (Eq, Show)

instance Semigroup BagOfWords where
  (BagOfWords bow) <> (BagOfWords bow') = BagOfWords (bow <> bow')

instance Monoid BagOfWords where
  mempty = BagOfWords mempty
  mappend = (<>)

fromSentence :: Text -> BagOfWords
fromSentence = fromWords . Text.words . Text.toLower

fromWords :: [Text] -> BagOfWords
fromWords = foldMap toBagOfWords

toBagOfWords :: Text -> BagOfWords
toBagOfWords s = BagOfWords (Map.fromList [(s, 1)])

normalize :: Text -> Text
normalize = Text.replace "." "" . Text.replace "," ""

lorem :: Text
lorem = Text.unlines
  [ "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"
  , ", sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est "
  , "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore"
  , " et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,"
  , " no sea takimata sanctus est Lorem ipsum dolor sit amet."
  ]

main :: IO ()
main = print $ fromSentence lorem

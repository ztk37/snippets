module Document where

data Document = Document
  { docHeader :: Maybe String
  , docBody :: [String]
  , docFooter :: Maybe String
  } deriving (Eq, Show)

emptyDocument :: Document
emptyDocument =
 Document Nothing [] Nothing

setDocHeader :: String -> Document -> Document
setDocHeader s doc = doc { docHeader = Just s }

addToDocBody :: String -> Document -> Document
addToDocBody s doc = doc { docBody = s : docBody doc }

setDocFooter :: String -> Document -> Document
setDocFooter s doc = doc { docFooter = Just s }

pprintDoc :: Document -> String
pprintDoc (Document h b f) = unlines chunks
  where
    prettyHeader :: Maybe String -> [String]
    prettyHeader (Just s) = [s, ""]
    prettyHeader Nothing = []

    prettyFooter :: Maybe String -> [String]
    prettyFooter (Just s) = ["", s, ""]
    prettyFooter Nothing = []

    chunks = prettyHeader h ++ reverse b ++ prettyFooter f

doc :: Document
doc = setDocHeader "Welcome!"
    $ addToDocBody "Some awesome text 1"
    $ addToDocBody "Some awesome text 2"
    $ addToDocBody "Some awesome text 3"
    $ setDocFooter "Good Bye"
    $ emptyDocument

main :: IO ()
main = putStr $ pprintDoc doc

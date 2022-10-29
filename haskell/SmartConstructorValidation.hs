module Main where

main :: IO ()
main = do
  print $ mkCategory "" "" ""
  print $ mkTag "" "" ""

type Name = String
type Description = String
type Slug = String

validate :: String -> String -> Either String String
validate s msg
  | null s = Left msg
  | otherwise = Right s

data Category = Category
  { categoryName :: !Name
  , categoryDescription :: !Description
  , categorySlug :: !Slug
  } deriving (Show)

mkCategory
  :: Name
  -> Description
  -> Slug
  -> Either String Category
mkCategory n d s =
  Category
    <$> validate n "name can't be empty"
    <*> validate d "description can't be empty"
    <*> validate s "slug can't be empty"
  
data Tag = Tag
  { tagName :: !Name
  , tagDescription :: !Description
  , tagSlug :: !Slug
  } deriving (Show)

mkTag :: Name -> Description -> Slug -> Either String Tag
mkTag n d s =
  Tag
    <$> validate n "name can't be empty"
    <*> validate d "description can't be empty"
    <*> validate s "slug can't be empty"

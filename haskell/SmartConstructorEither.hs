data Position = Position
  { posX :: Int
  , posY :: Int
  , posZ :: Int
  } deriving (Eq, Show)

mkPosition :: Int -> Int -> Int -> Either String Position
mkPosition x y z =
  case (x > 5) of
   True -> case (y < 5) of
     True ->  case (z /= 42) of
       True -> Right $ Position x y z
       False -> Left "z can't be the answer"
     False -> Left "y must be higher then 5"
   
   False -> Left "x must be higher then 5"

validateX :: Int -> Either String Int
validateX x
  | x > 5 = Right x
  | otherwise = Left "x must be higher then 5"

validateY :: Int -> Either String Int
validateY y
  | y < 5 = Right y
  | otherwise = Left "x must be higher then 5"

validateZ :: Int -> Either String Int
validateZ z
  | z /= 42 = Right z
  | otherwise = Left "z can't be the answer"

mkPosition'
  :: Int -- x
  -> Int -- y
  -> Int -- z
  -> Either String Position
mkPosition' x y z =
  Position
    <$> validateX x
    <*> validateY y
    <*> validateZ z

main :: IO ()
main = do
  print $ mkPosition 7 2 3
  print $ mkPosition' 7 2 3

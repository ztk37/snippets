data Position = Position
  { posX :: Int
  , posY :: Int
  , posZ :: Int
  } deriving (Eq, Show)
  
validatePos
  :: String
  -> (Int -> Bool)
  -> Int
  -> Either String Int
validatePos msg pred n
  | pred n = Right n
  | otherwise = Left msg


mkPosition :: Int -> Int -> Int -> Either String Position
mkPosition x y z =
  if (x > 5) then
    if (y < 5) then
      if (z /= 42) then
        Right $ Position x y z
      else
        Left "z can't be the answer"
    else
      Left "y must be higher then 5"
  else
    Left "x must be higher then 5"
-- Never - Nested Case Hell xD
--  case (x > 5) of
--    True -> case (y < 5) of
--      True ->  case (z /= 42) of
--        True -> Right $ Position x y z
--       False -> Left "z can't be the answer"
--      False -> Left "y must be higher then 5"
--    False -> Left "x must be higher then 5"

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
  print $ Position
    <$> validatePos "A" (const True) 5
    <*> validatePos "B" (const False) 5
    <*> validatePos "C" (const True) 5

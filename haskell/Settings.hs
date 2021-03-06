import Data.Char

data Settings = Settings
    { settingsPath :: String
    , settingsTitle :: Maybe String
    , settingsDescription :: Maybe String
    } deriving (Show, Eq)

emptySettings :: Settings
emptySettings =
    Settings
        { settingsPath        = ""
        , settingsTitle       = Nothing
        , settingsDescription = Nothing
        }

mkSettings :: String -> Maybe String -> Maybe String -> Settings
mkSettings sp st sd =
    Settings
        { settingsPath        = sp
        , settingsTitle       = st
        , settingsDescription = sd
        }

foo :: Int -> Maybe Int
foo x
    | x > 5
    , x /= 21 = Just x
    | otherwise = Nothing

main :: IO ()
main = do
    putStrLn $ "Foo: "
        <> maybe "" reverse (Just "default")
        <> " - "
        <> maybe "" (map toUpper) (Just "derp")
    print $ foo 21
    
    print $ mkSettings "Foo" (Just "title") (Just "description")

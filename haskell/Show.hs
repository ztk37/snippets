import Text.Printf (printf)

data ProjectName
    = Project String
    | LanguageSpecific String String
    | FrontendProject String
    | BackendProject String
    deriving (Eq)
    
instance Show ProjectName where
    show (Project name) = name
    show (LanguageSpecific prefix lang) =
        printf "%s-in-%s" prefix lang
    show (FrontendProject name) = name ++ "-frontend"
    show (BackendProject name) = name ++ "-backend"

data Portfolio = Portfolio
    { _projects :: [Project] }
    
data Project = Project
    { _name :: ProjectName
    } deriving (Show, Eq)

main :: IO ()
main = do
    print $ Project "foo"
    print $ LanguageSpecific "pattern" "haskell"
    print $ FrontendProject "react-redux"
    print $ BackendProject "express"

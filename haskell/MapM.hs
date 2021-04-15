module Main (main) where

data AuthState
  = LoggedIn
  | LoggedOut
  deriving (Show, Eq)

isLoggedIn :: AuthState -> Bool
isLoggedIn = (== LoggedIn)

isLoggedOut :: AuthState -> Bool
isLoggedOut = (== LoggedOut)

cases :: [Bool]
cases =
    [ isLoggedIn LoggedIn
    , isLoggedIn LoggedOut
    , isLoggedOut LoggedIn
    , isLoggedOut LoggedOut
    ]
    
main :: IO ()
main = mapM_ print cases

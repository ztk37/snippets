{-# LANGUAGE LambdaCase #-}

module Main (main) where

data Command
  = Help (Maybe String)
  | Build String
  | Version
  | New
  | Init
  deriving (Eq, Show)

fromArgs :: [String] -> Either String Command
fromArgs ["help"] = Right $ Help Nothing
fromArgs ("help":cmd:[]) = Right $ Help (Just cmd)
fromArgs ["version"] = Right $ Version
fromArgs ["new"] = Right $ New
fromArgs ["init"] = Right $ Init
fromArgs _ = Left "cli error"

mainWithArgs :: [String] -> IO ()
mainWithArgs = \case
  ["help"] -> putStrLn "run help command"
  ("help":cmd:[]) -> putStrLn $ "run help command for " ++ cmd
  ("build":target:[]) -> putStrLn $ "run build command with " ++ target
  ["init"] -> putStrLn "run init command"
  ["new"] -> putStrLn "run new command"
  ["version"] -> putStrLn "run version command"
  args -> print args

getArgs0 :: IO [String]
getArgs0 = return ["-h"]

getArgs1 :: IO [String]
getArgs1 = return ["help"]

getArgs2 :: IO [String]
getArgs2 = return ["build", "target"]

getArgs3 :: IO [String]
getArgs3 = return ["help", "build"]

samples :: IO [Either String Command]
samples =
  mapM
    (fmap fromArgs)
    [ getArgs0
    , getArgs1
    , getArgs2
    , getArgs3
    ]

main :: IO ()
main = samples >>= mapM_ print

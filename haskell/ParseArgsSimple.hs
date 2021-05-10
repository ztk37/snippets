module Main (main) where

fakeArgs0 :: IO [String]
fakeArgs0 = return
  [ "--help" ]

fakeArgs1 :: IO [String]
fakeArgs1 = return
  [ "--version" ]

fakeArgs2 :: IO [String]
fakeArgs2 = return
  [ "--input", "/path/to/your/file" ]

fakeArgs3 :: IO [String]
fakeArgs3 = return
  [ "--unknown" ]

main :: IO ()
main = foldMap (>>= mainWithArgs)
  [ fakeArgs0
  , fakeArgs1
  , fakeArgs2
  , fakeArgs3
  ]

mainWithArgs :: [String] -> IO ()
mainWithArgs args =
  case parseArgs args of
    (Just output) -> putStrLn output
    Nothing -> putStrLn "Invalid Args"

parseArgs :: [String] -> Maybe String
parseArgs args
  |  "--help" `elem` args = Just "help"
  |  "--version" `elem` args = Just "version"
  | otherwise = case args of
    "--input": path -> Just $ unwords path
    _ -> Nothing

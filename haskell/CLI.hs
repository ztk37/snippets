import System.IO

prompt :: String -> IO String
prompt s = do
  putStr s
  hFlush stdout -- prevents buffering
  getLine
  
main :: IO ()
main = do
    pair <- (,) <$> prompt "first: " <*> prompt "second: "
    
    putStrLn $ "Pair: " ++ show pair

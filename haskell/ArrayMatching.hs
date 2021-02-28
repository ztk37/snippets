compute :: [String] -> String
compute str =
  case str of
    [a, b] -> a ++ b
    [a]    -> a
    []     -> "empty"
    _      -> "error"

main :: IO ()
main = do
    putStrLn $ compute []
    putStrLn $ compute ["sad"]
    putStrLn $ compute ["fi", "aasd"]
    putStrLn $ compute ["fi", "aasd", "derp"]

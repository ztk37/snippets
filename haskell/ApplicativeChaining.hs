-- Applicatives allow chaining without the need of a full monad

main :: IO ()
main = do
  -- IO (String -> String)
  input <-  (++) <$> getLine <*> getLine
  print input


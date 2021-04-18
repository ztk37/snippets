import Control.Monad.Trans.State

foo :: State String String
foo = do
  state <- get
  put $ "derp" ++ state
  state <- get
  put $ "wtf" ++ state
  return "foo"

bar :: State Int String
bar = do
  return "asd"

replaceState :: String -> String -> State Int String
replaceState x _ = return x

main :: IO ()
main = do
  print $ runState foo "damn"
  print $ runState bar 42

  -- ( ... ) are required for type checking
  print $ flip runState 42 ((do { return "" })
      >>= (\_ -> do { return "X"})
      >>= (\_ -> do { return "Y"})
      >>= replaceState "Z")

  print $ flip runState 42 $ bar
    >>= replaceState "derp"
    >>= replaceState "wupp"

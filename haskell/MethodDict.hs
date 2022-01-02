module Main (main) where

data MDict m = MDict
  { _foo :: String -> m ()
  , _bar :: Bool -> m ()
  , _fib :: Int -> m ()
  }

useMDict :: Monad m => MDict m -> m ()
useMDict md = do
  _foo md "foo"
  _bar md True
  _fib md 42

main :: IO ()
main = useMDict $ MDict putStrLn print print

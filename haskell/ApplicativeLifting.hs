module Main where

import Control.Applicative.Lift

foo :: Num a => [a] -> [a]
foo xs = f <$> xs
  where
    f = (+3)

bar :: (Monad m, Num (m b)) => b -> m b -> m b 
bar a b = c >>= d
  where
    c = return a
    d = \x -> return x * b

fibM :: (Monad m, Num a) => m a
fibM = return 42

fib :: (Monad m, Num a) => m a -> m a
fib fm = fm >>= d
  where
    d = \x -> return (x * 2)

fib' :: (Monad m, Num a) => m a
fib' = c >>= d
  where
    c = return 42
    d = \x -> return (x * 2)

chainP :: (Applicative f, Num b) => f b
chainP = a <$> b <*> c
  where
    a = pure (*2)
    b = pure (+3)
    c = pure 42

data A a = A { runA :: a -> a }

makeA :: (Num a) => A a
makeA = A $ \x -> x * 2

main :: IO ()
main = do
  let a = makeA

  print $ runA a 42

import Control.Monad.Trans.State
import Control.Monad.Trans.Writer
import Control.Monad.Trans.Reader

import Data.Set (Set)
import qualified Data.Set as Set

newtype W = W
  { unW :: StateT (Set [String]) IO ()
  }

type M a = StateT (Set [String]) Maybe a

m :: (Set [String] -> Maybe (a, Set [String])) -> M a
m = StateT

evalM :: M a -> Maybe a
evalM x = evalStateT x mempty

evalM_ :: M () -> Maybe ()
evalM_ = evalM

evalW :: W -> Set [String] -> IO ()
evalW = evalStateT . unW

execW :: W -> Set [String] -> IO (Set [String])
execW = execStateT . unW

runW :: W -> Set [String] -> IO ((), Set [String])
runW = runStateT . unW

s :: W
s = W $ StateT $ \x -> return ((), mempty)

r :: ReaderT [String] IO [Int]
r = do
  r1
  r1

r0 :: ReaderT [String] IO ()
r0 = return ()

r1 :: ReaderT [String] IO [Int]
r1 = return [1..10]

w :: WriterT [String] IO ()
w = do
  w0
  w1
  w2
  tellW "foo"
  tellW "baz"
  tellW "fib"

tellW :: String -> WriterT [String] IO ()
tellW x = tell [x]

w0 :: WriterT [String] IO ()
w0 = do
  tellW "bar"
  return ()

w1 :: WriterT [String] IO ()
w1 = return ()

w2 :: WriterT [String] IO ()
w2 = return ()

main :: IO ()
main = do
  evalW s mempty
  -- execW s mempty
  -- runW s mempty

  print $ evalM $ m $ \x -> Just (x, mempty)
  print $ (evalM $ m $ \_ -> Nothing :: Maybe ((), Set [String]))
  print $ evalM_ $ m $ \_ -> Nothing
  print =<< snd <$> runWriterT w

import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer

newtype M m a = M
  { unM :: ReaderT [String] (WriterT [String] m) a }

instance Functor m => Functor (M m) where
    fmap f (M x) = M (fmap f x)
    (<$) x (M y) = M ((<$) x y)

runM :: M m a-> m (a, [String])
runM = runWriterT . flip runReaderT [] . unM

newtype T a = T
  { unT :: ReaderT [String] (StateT [String] IO) a }

instance Functor T where
  fmap f (T x) = T (fmap f x)

runT :: T a -> IO (a, [String])
runT = flip runStateT [] . flip runReaderT [] . unT

t :: T ()
t = T $ do
  modify ("foo":)
  modify ("fib":)
  modify ("bar":)

  return ()

main :: IO ()
main = print =<< runT t

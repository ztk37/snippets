-- http://michaelxavier.net/posts/2016-04-03-Enterprise-Haskell-Pattern-Lensed-Reader.html

import           Data.Map (Map)
import qualified Data.Map as Map
import Control.Monad.Reader

data AppError
    = AppCantByStarted
    deriving (Show)
    
type Env = Map String String

type AppEither a = Either AppError a

newtype AppT m a = AppT
    { unAppT :: ReaderT Env m a}
    deriving ( Functor
             , Applicative
             , Monad
             , MonadIO
             , MonadReader Env)

runAppT :: Env -> AppT m a -> m a
runAppT s m = runReaderT (unAppT m) s

right :: AppEither (Maybe String)
right = Right $ Just "asda"

left :: AppEither (Maybe String)
left = Left AppCantByStarted

maybeError :: Maybe a -> AppEither a
maybeError Nothing = Left AppCantByStarted
maybeError (Just x) = Right x

printAppT :: String -> AppT IO ()
printAppT msg = do
    liftIO $ print msg

main :: IO ()
main = do
    print $ right
    print $ left
    putStrLn "Hello, World!"
    
    runAppT (Map.fromList []) (printAppT "asdasd")

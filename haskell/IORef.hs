import           Data.IORef
import           Data.Map (Map)
import qualified Data.Map as Map

type InMemoryCache = Map String Int

insert
  :: IORef InMemoryCache
  -> String
  -> Int
  -> IO String
insert ref k v = do
  modifyIORef ref (Map.insert k v)
  return k

emptyCache :: IO (IORef InMemoryCache)
emptyCache = newIORef Map.empty

main :: IO ()
main = do
  cacheRef <- emptyCache

  insert cacheRef "Foo" 1
  insert cacheRef "Fib" 2
  insert cacheRef "Bar" 3

  kv <- readIORef cacheRef

  print kv

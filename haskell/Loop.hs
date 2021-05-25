import System.IO
import Control.Monad
import Control.Monad.State

data StateData = StateData
  { _quit       :: Bool
  , _quiet :: Bool
  } deriving (Show)

loop :: StateT StateData IO ()
loop = do
    shouldQuit <- _quit <$> get
    quietUnknownCmd <- _quiet <$> get
    

    unless shouldQuit $ do
      lift $ putStr "> "
      lift $ hFlush stdout
      line <- lift $ getLine

      case line of
        "quit" -> modify (\state -> state {_quit = True})
        _ -> lift $ unless quietUnknownCmd $ do
            putStrLn $ "unknown command: " ++ line
      loop

main :: IO ()
main = evalStateT loop (StateData False True)

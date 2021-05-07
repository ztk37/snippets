import Control.Monad.Trans.State

data ABC
  = A
  | B
  | C
  deriving (Show)

data AppState = AppState
  { apABC :: ABC
  , apN :: Int
  } deriving (Show)

incAppN :: AppState -> AppState
incAppN state = state { apN = apN state + 1 }

setAppABC :: ABC -> AppState -> AppState
setAppABC abc state = state { apABC = abc }

emptyAppState :: AppState
emptyAppState = AppState A 0

app :: State AppState Int
app = do
  modify incAppN
  modify incAppN
  modify $ setAppABC C
  modify incAppN
  modify incAppN
  getAppN

getAppN :: State AppState Int
getAppN = do
  state <- get
  return $ apN state
  
main :: IO ()
main = do
  print $ runState app emptyAppState
  print $ evalState app emptyAppState
  print $ execState app emptyAppState

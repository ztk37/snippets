import Control.Monad.Writer
import Control.Monad.State

data Ctx = Ctx
  { unCtx :: String }
  deriving (Eq, Show)

type CtxBuilder a = StateT Ctx (Writer [String]) a

initCtx :: Ctx
initCtx = Ctx "Init"

builder :: CtxBuilder a -> [String]
builder = execWriter . flip evalStateT initCtx

builderS :: CtxBuilder a -> ((a, Ctx), [String])
builderS = runWriter . flip runStateT initCtx

add :: CtxBuilder ()
add = do
  ctx <- unCtx <$> get
  tell ["bar", ctx]

main :: IO ()
main = do
  print $ builder $ do
    tell ["Derp"]

    add
    add
    add

    put $ (Ctx "Foo")

  print $ builderS $ do
    tell ["Derp"]
    put $ (Ctx "Foo")

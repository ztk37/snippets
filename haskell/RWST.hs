import Control.Monad.Trans.RWS

-- newtype RWST r w s (m :: * -> *) a = RWST
--   { runRWST :: r -> s -> m (a, s, w) }

wrap :: RWS () () () ()
wrap = rws $ \_ _ -> ((), (), ())

wrapT :: RWST () () () IO ()
wrapT = RWST $ \_ _ -> return ((), (), ())

main :: IO ()
main = do
  -- runRWST :: RWST r w s m a -> r -> s -> m (a, s, w)
  runRWST wrapT () () >>= print
  -- evalRWST :: Monad m => RWST r w s m a -> r -> s -> m (a, w)
  evalRWST wrapT () () >>= print
  -- execRWST :: Monad m => RWST r w s m a -> r -> s -> m (s, w)
  execRWST wrapT () () >>= print

  -- runRWS :: RWS r w s a -> r -> s -> (a, s, w)
  print $ runRWS wrap () ()
  -- evalRWS :: RWS r w s a -> r -> s -> (a, w)
  print $ evalRWS wrap () ()
  -- execRWS :: RWS r w s a -> r -> s -> (s, w)
  print $ execRWS wrap () ()

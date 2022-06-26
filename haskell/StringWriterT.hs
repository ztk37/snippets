module StringWriterT where

newtype StringWriterT m a = StringWriterT
  { unStringWriterT :: m (a, [String])
  }

instance Functor m => Functor (StringWriterT m) where
  fmap f (StringWriterT m) = StringWriterT $
    fmap (\(a, msgs) -> (f a, msgs)) m

instance Applicative m => Applicative (StringWriterT m) where
  pure a = StringWriterT $ pure (a, [])
  StringWriterT mf <*> StringWriterT ma = StringWriterT $
    fmap (\((f, msgs), (a, msgs')) -> (f a, msgs ++ msgs')) ((,) <$> mf <*> ma)

instance Monad m => Monad (StringWriterT m) where
  return = pure
  (StringWriterT ma) >>= k = StringWriterT $ do
    (a, msgs) <- ma
    (a', msgs') <- unStringWriterT $ k a

    return (a', msgs ++ msgs')

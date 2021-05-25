module DSL where

data DSL next
    = Get String (String -> next)
    | Set String String next
    | End

instance Functor DSL where
    fmap f (Get name k)          = Get name (f . k)
    fmap f (Set name value next) = Set name value (f next)
    fmap f End                   = End

data Free f a
  = Pure a
  | Free (f (Free f a))

instance Functor f => Functor (Free f) where
  fmap f (Pure a) = Pure (f a)
  fmap f (Free x) = Free (fmap f <$> x)

instance Functor f => Applicative (Free f) where
  pure = Pure
  Pure f <*> Pure a = Pure (f a)
  Pure f <*> Free x = Free (fmap f <$> x)
  Free x <*> my     = Free ((<*> my) <$> x)

instance Functor f => Monad (Free f) where
  return = pure
  Pure a >>= f = f a
  Free x >>= f = Free ((>>= f) <$> x)

liftF :: Functor f => f a -> Free f a
liftF = Free . fmap return

get key       = liftF (Get key id)
set key value = liftF (Set key value ())
end           = liftF End

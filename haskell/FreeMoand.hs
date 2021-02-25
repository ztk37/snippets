module DSL where

data DSL next
    = Get String (String -> next)
    | Set String String next
    | End

instance Functor DSL where
    fmap f (Get name k)          = Get name (f . k)
    fmap f (Set name value next) = Set name value (f next)
    fmap f End                   = End

instance Functor f => Applicative (Free f) where
    pure = Return

instance Functor f => Monad (Free f) where
  return         = Return
  Free a >>= f   = Free (fmap (>>= f) a)
  Return a >>= f = f a

data Free f a
    = Free (f (Free f a))
    | Return a

liftFree :: Functor f => f a -> Free f a
liftFree action = Free (fmap Return action)

get key       = liftFree (Get key id)
set key value = liftFree (Set key value ())
end           = liftFree End

{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE LambdaCase #-}

module Main (main) where

{-

A Haskell free monad is a list of functors. Compare:

data List a   = Nil    | Cons  a (List a  )
data Free f r = Pure r | Free (f (Free f r))

-}

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

data EffectF next
  = EchoEff String next
  | PromptEff (String -> next)
  | PromptWithPrefixEff String (String -> next)
  deriving Functor

type Effect next = Free EffectF next

liftF :: Functor f => f a -> Free f a
liftF = Free . fmap return

foldF
    :: (Functor f, Monad m)
    => (forall a. f a -> m a)
    -> Free f a
    -> m a
foldF morph (Pure a) = return a
foldF morph (Free f) = do
    a <- morph f
    foldF morph a
   
concatF :: Functor f => Free f (Free f a) -> Free f a
concatF (Pure x) = x
concatF (Free y) = Free (fmap concatF y)

echo :: String -> Effect ()
echo s = liftF $ EchoEff s ()

prompt :: Effect String
prompt = Free $ PromptEff return

promptWithPrefix :: String -> Effect String
promptWithPrefix s = Free $ PromptWithPrefixEff s return

programm :: Effect ()
programm = do
  s <- prompt
  echo "Foo"
  echo s
  p <- promptWithPrefix "> "
  echo p
  

interpret :: Effect a -> IO a
interpret = foldF morph
  where
    morph :: EffectF a -> IO a
    morph (EchoEff s next) = do
      putStrLn s
      pure next
    morph (PromptEff next) = do
      s <- getLine
      pure $ next s
    morph (PromptWithPrefixEff prefix next) = do
      putStr prefix
      s <- getLine
      pure $ next s

interpret' :: Effect a -> IO a
interpret' = foldF $ \case 
    (EchoEff s next) -> do
      putStrLn s
      pure next
    (PromptEff next) -> do
      s <- getLine
      pure $ next s
    (PromptWithPrefixEff prefix next) -> do
      putStr prefix
      s <- getLine
      pure $ next s

interpret'' :: Effect a -> IO a
interpret'' = foldF $ \case 
    (EchoEff s next) -> 
      next <$ putStrLn s
    (PromptEff next) ->
      next <$> getLine
    (PromptWithPrefixEff prefix next) -> do
      next <$> getLine <* putStr prefix

main :: IO ()
main = do
  interpret programm

  putStrLn ""

  interpret' programm

  putStrLn ""

  interpret'' programm

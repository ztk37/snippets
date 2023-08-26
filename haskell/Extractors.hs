{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}

data Context = Context String Int Bool
  deriving (Show)
  
data Result = Result
  deriving (Show)
  
class FromContext a where
  fromContext :: Context -> a
  
instance FromContext String where
  fromContext (Context x _ _) = x
  
instance FromContext Int where
  fromContext (Context _ x _) = x
  
instance FromContext Bool where
  fromContext (Context _ _ x ) = x

ctx :: Context
ctx = Context "S" 42 True

type F1 a = a -> IO ()
type F2 a b = a -> b -> IO ()
type F3 a b c = a -> b -> c -> IO ()
type F4 a b c d = a -> b -> c -> d -> IO ()
type F5 a b c d e = a -> b -> c -> d -> e -> IO ()
type F6 a b c d e f = a -> b -> c -> d -> e -> f -> IO ()
type F7 a b c d e f g = a -> b -> c -> d -> e -> f -> g -> IO ()

class Handler a where
  call :: Context -> a -> IO ()
  
instance FromContext a => Handler (F1 a) where
  call ctx f = f (fromContext @a ctx)
  
instance (FromContext a, FromContext b) => Handler (F2 a b) where
  call ctx f = f (fromContext @a ctx) (fromContext @b ctx)
  
instance (FromContext a, FromContext b, FromContext c) => Handler (F3 a b c) where
  call ctx f = f (fromContext @a ctx) (fromContext @b ctx) (fromContext @c ctx)

instance (FromContext a, FromContext b, FromContext c, FromContext d) => Handler (F4 a b c d) where
  call ctx f = f (fromContext @a ctx) (fromContext @b ctx) (fromContext @c ctx) (fromContext @d ctx)

instance (FromContext a, FromContext b, FromContext c, FromContext d, FromContext e) => Handler (F5 a b c d e) where
  call ctx f = f (fromContext @a ctx) (fromContext @b ctx) (fromContext @c ctx) (fromContext @d ctx) (fromContext @e ctx)

instance (FromContext a, FromContext b, FromContext c, FromContext d, FromContext e, FromContext f) => Handler (F6 a b c d e f) where
  call ctx f = f (fromContext @a ctx) (fromContext @b ctx) (fromContext @c ctx) (fromContext @d ctx) (fromContext @e ctx) (fromContext @f ctx)

instance (FromContext a, FromContext b, FromContext c, FromContext d, FromContext e, FromContext f, FromContext g) => Handler (F7 a b c d e f g) where
  call ctx f = f (fromContext @a ctx) (fromContext @b ctx) (fromContext @c ctx) (fromContext @d ctx) (fromContext @e ctx) (fromContext @f ctx) (fromContext @g ctx)

f :: String -> IO ()
f s = do
  putStrLn s
  
g :: String -> Bool -> IO ()
g a c = do
  print a
  print c
  
h :: String -> Int -> Bool -> IO ()
h a b c = do
  putStrLn a
  print b
  print c
  
trigger :: Handler h => Context -> h -> IO ()
trigger = call

main :: IO ()
main = do
  putStrLn (fromContext @String ctx)
  print (fromContext @Int ctx)
  print (fromContext @Bool ctx)
  
  trigger ctx f
  trigger ctx g
  trigger ctx h

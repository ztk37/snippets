module Main (main) where

type Tag = String

data A = A
  { aTag :: Tag }
  deriving (Show)

data B = B
  { bTags :: [Tag] }
  deriving (Show)

data C = C 
  { cTag :: Maybe Tag }
  deriving (Show)

a :: Tag -> A
a = mk

b :: Tag -> B
b = mk

c :: Tag -> C
c = mk

class Make a where
  mk :: Tag -> a

instance Make A where
  mk t = A t

instance Make B where
  mk t = B [t]

instance Make C where
  mk t = C (Just t)

class HasTag a where
  tag :: Tag -> a -> a

instance HasTag A where
  tag t a = a { aTag = t }

instance HasTag B where
  tag t a = a { bTags = t : (bTags a) }

instance HasTag C where
  tag t a = a { cTag = Just t }

main :: IO ()
main = do
  print $ a "Foo"
  print $ b "Fib"
  print $ c "Bar"
  print $ (mk "Foo" :: A)
  print $ (mk "Fib" :: B)
  print $ (mk "Bar" :: C)

module Main (main) where

data List a
  = Nil
  | Cons a (List a)
  deriving (Eq, Show)

mapList :: (a -> b) -> List a -> List b
mapList _ Nil = Nil
mapList f (Cons x xs) = Cons (f x) (mapList f xs)

-- unflattenList ?
toList :: [a] -> List a
toList [] = Nil
toList (x:xs) = Cons x (toList xs)

len :: List a -> Int
len Nil = 0
len (Cons _ xs) = 1 + len xs

foldList :: (a -> b -> b) -> b -> List a -> b
foldList k acc xs = go xs
  where
    go Nil = acc
    go (Cons x xs) = x `k` go xs

flattenList :: List a -> [a]
flattenList = foldList (:) []

sample :: List Bool
sample = Cons True (Cons False (Cons True (Cons True (Cons False Nil))))

instance Functor List where
  fmap = mapList

instance Foldable List where
  foldr = foldList

main :: IO ()
main = do
  print $ mapList not sample
  print $ toList [1..10]
  print $ foldList (+) 0 $ toList [1..10]

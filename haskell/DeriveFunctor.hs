{-# LANGUAGE DeriveFunctor #-}

import Data.Char
import Data.List

data Option a = Option
  { optName:: String
  , optDefault:: Maybe a
  , optReader:: String -> Maybe a
  } deriving Functor

testOption :: Option String
testOption = Option "foo" (Just "default") (Just . reverse)

data Wrapper a = Wrapper
    { getValue :: a
    , getMaybeValue :: String -> Maybe a
    }

instance Functor Wrapper where
  fmap f (Wrapper a g) = Wrapper (f a) (\x -> do
    v <- g x
    Just (f v))

initialWrapper :: Wrapper String
initialWrapper = Wrapper "a" (id . Just)

main :: IO ()
main = print
     $ getValue
     $ (map chr)
    <$> (map (+5))
    <$> (map ord)
    <$> (map toUpper)
    <$> (intercalate "" . replicate 10)
    <$> initialWrapper

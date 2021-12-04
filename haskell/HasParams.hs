module Main (main) where

data Foo = Foo
  { fooParams :: [Param]
  } deriving (Eq, Show)

data BarMeta = BarMeta
  { bmParams :: [Param]
  } deriving (Eq, Show)

data Bar = Bar
  { barMeta :: BarMeta
  } deriving (Eq, Show)

data Fib = Fib
  { fibA :: String
  , fibParams :: [Param]
  , fibZ :: Bool
  } deriving (Eq, Show)

data Param = Param
  { pValue :: String
  } deriving (Eq, Show)

class HasParams a where
  {-# MINIMAL getParams, addParam #-}
  getParams :: a -> [Param]
  addParam :: Param -> a -> a
  addParams :: [Param] -> a -> a
  addParams ps x = foldr addParam x ps

instance HasParams Foo where
  getParams = fooParams
  addParam p (Foo ps) = Foo (p : ps)
instance HasParams Bar where
  getParams = bmParams . barMeta
  addParam p (Bar (BarMeta ps)) = Bar (BarMeta (p : ps))
instance HasParams Fib where
  getParams = fibParams
  addParam p (Fib a ps z) = Fib a (p : ps) z

main :: IO ()
main =
  let
    p1 = Param "A"
    p2 = Param "B"
    p3 = Param "C"

    foo = Foo []
    bar = Bar (BarMeta [])
    fib = Fib "Fib" [] False

    foo' = addParam p1 foo
    bar' = addParam p1 bar
    fib' = addParam p1 fib

    foo'' = addParams [p1, p2, p3] foo
    bar'' = addParams [p1, p2, p3] bar
    fib'' = addParams [p1, p2, p3] fib
  in do
    print foo'
    print bar'
    print fib'
    print foo''
    print bar''
    print fib''

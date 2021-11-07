{-# LANGUAGE AllowAmbiguousTypes #-}

type Key = String

class HasKey a where
  getKey :: String

class Default a where
  def :: a

type ID = String

class HasID a where
  getID ::  a -> ID

class Combine a where
  combine :: a -> a -> a

type Something = String

class FromSomething a where
  fromSomething :: Something -> a

class ToSomething a where
  toSomething :: a -> Something

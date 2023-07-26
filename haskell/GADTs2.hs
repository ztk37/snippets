{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}

module GADTs2 where

data ABC = A | B | C
  deriving (Show)

data Container (kind :: ABC) a where
    CA :: a -> Container 'A a
    CB :: a -> Container 'B a
    CC :: a -> Container 'C a

deriving instance Show a => Show (Container kind a)

deriving instance Functor (Container kind)

instance Applicative (Container 'A) where
    pure = CA
    CA f <*> fa = fmap f fa
instance Applicative (Container 'B) where
    pure = CB
    CB f <*> fa = fmap f fa
instance Applicative (Container 'C) where
    pure = CC
    CC f <*> fa = fmap f fa

instance Monad (Container 'A) where
    CA a >>= k = k a
instance Monad (Container 'B) where
    CB a >>= k = k a
instance Monad (Container 'C) where
    CC a >>= k = k a

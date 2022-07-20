{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Scorable where

import Data.Monoid (Sum(..), Product(..))

newtype Score = Score
  { getScore :: Int
  } deriving (Eq, Show, Num)

modifyScore :: (Int -> Int) -> Score -> Score
modifyScore f (Score a) = Score (f a)

zeroScore :: Score
zeroScore = Score 0
{-# INLINE zeroScore #-}

scoreSum :: Score -> Score -> Score
scoreSum (Score a) (Score b) = Score (a + b)

toSum :: Score -> Sum Int
toSum = Sum . getScore

scoreProduct :: Score -> Score -> Score
scoreProduct (Score a) (Score b) = Score (a * b)

toProduct :: Score -> Product Int
toProduct = Product . getScore

class Scorable a where
  toScore :: a -> Score

instance Scorable Int where
  toScore = Score

data Priority
  = PriorityBlocker
  | PriorityCritical
  | PriorityHigh
  | PriorityMedium
  | PriorityLow
  | PriorityNone
  deriving (Eq, Ord, Show)

instance Scorable Priority where
  toScore priority =
    case priority of
      PriorityBlocker  -> 5
      PriorityCritical -> 4
      PriorityHigh     -> 3
      PriorityMedium   -> 2
      PriorityLow      -> 1
      PriorityNone     -> 0

data Effort
  = EffortLow
  | EffortMedium
  | EffortHigh 
  | EffortUnknown
  deriving (Eq, Ord, Show)

instance Scorable Effort where
  toScore effort =
    case effort of
      EffortUnknown -> 4
      EffortHigh    -> 3
      EffortMedium  -> 2
      EffortLow     -> 1

data Urgency = Urgent | NotUrgent
  deriving (Eq, Show)

instance Scorable Urgency where
  toScore Urgent = 1
  toScore NotUrgent = 0

data Importancy = Important | NotImportant
  deriving (Eq, Show)

instance Scorable Importancy where
  toScore Important = 1
  toScore NotImportant = 0

factor :: (Scorable a , Scorable b) => a -> b -> Score
factor a b = toScore a * toScore b

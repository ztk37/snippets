{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}

data A
data B
data C

data State a = State
  deriving (Eq, Show)

type StateA = State A
type StateB = State B
type StateC = State C

data StateG a where
  GStateA :: StateG A
  GStateB :: StateG B
  GStateC :: StateG C

deriving instance Show (StateG a)

gAtoB :: StateG A -> StateG B
gAtoB GStateA = GStateB

gBtoC :: StateG B -> StateG C
gBtoC GStateB = GStateC

gAtoC :: StateG A -> StateG C
gAtoC = gBtoC . gAtoB

gStateA :: StateG A
gStateA = GStateA

gStateB :: StateG B
gStateB = GStateB

gStateC :: StateG C
gStateC = GStateC

aToB :: State A -> State B
aToB State = State

bToC :: State B -> State C
bToC State = State

aTtoC :: State A -> State C
aTtoC State = State

stateA :: StateA
stateA = State

stateB :: StateB
stateB = State

stateC :: StateC
stateC = State

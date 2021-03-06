import Data.Monoid

data ABC = A | B | C

data State = State
  { a :: Int
  , b :: Int
  , c :: Int
  } deriving (Show)

instance Semigroup State where
  (<>) = mappend

instance Monoid State where
  mempty = State 0 0 0
  mappend (State a1 b1 c1) (State a2 b2 c2) = State (a1 + a2) (b1 + b2) (c1 + c2)

update :: ABC -> Int -> State -> State
update abc n (State a b c) =
  case abc of
    A -> State (a + n) b c
    B -> State a (b + n) c
    C -> State a b (c + n)

updateA :: Int -> State -> State
updateA = update A

updateB :: Int -> State -> State
updateB = update B

updateC :: Int -> State -> State
updateC = update C

updateA' :: Int -> State
updateA' n = State n 0 0

updateB' :: Int -> State
updateB' n = State 0 n 0

updateC' :: Int -> State
updateC' n = State 0 0 n

chain :: State
chain =
  let
    u1 = updateA' 3
    u2 = updateC' 10
    u3 = updateB' 5
    u4 = updateA' 8
    u5 = updateC' 7
    u6 = updateB' 12
  in foldr mappend mempty [u1, u2, u3, u4, u5, u6]

-- Garbage <> (Stuff (Sum 42)) <> Garbage <> (Stuff (Sum 21))

data Thing a = Stuff a | Garbage deriving (Show)

instance Monoid a => Semigroup (Thing a) where
  (<>) = mappend

instance Monoid a => Monoid (Thing a) where
  mempty = Garbage
  mappend (Stuff x) (Stuff y) = Stuff (x <> y)
  mappend (Stuff x) Garbage = Stuff x
  mappend Garbage (Stuff x) = Stuff x
  mappend Garbage Garbage = Garbage

fromStuff :: Thing a -> a
fromStuff (Stuff a) = a 

fromThing :: a -> Thing a -> a
fromThing _ (Stuff a) = a
fromThing a Garbage = a

-- Garbage <> (Stuff [42]) <> Garbage <> (Stuff [21])

main :: IO ()
main = do
  print $ chain
  print $ update A 10 (State 0 0 0)
  print $ updateA' 4 <> updateB' 5 <> mempty
  print $ getSum $ fromStuff $ Garbage <> Stuff (Sum 42) <> Garbage <> Stuff (Sum 21)

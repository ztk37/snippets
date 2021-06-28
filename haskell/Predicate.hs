newtype Predicate a = Predicate
  { runPredicate :: a -> Bool }

composePredicates :: Predicate a -> Predicate a -> Predicate a
composePredicates (Predicate p1) (Predicate p2) =
  Predicate $ \x -> p1 x && p2 x

instance Semigroup (Predicate a) where
  (<>) = composePredicates

instance Monoid (Predicate a) where
  mempty = Predicate $ \_ -> True

pred1 :: Predicate Bool
pred1 = Predicate $ \_ -> True

pred2 :: Predicate Bool
pred2 = Predicate $ \_ -> False

pred3 :: Predicate Bool
pred3 = Predicate $ \_ -> True

main :: IO ()
main = print $ flip runPredicate False $ pred1 <> pred1 <> pred3

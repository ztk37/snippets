data Pair = Pair Bool Bool

pairToTuple :: Pair -> (Bool, Bool)
pairToTuple (Pair a b) = (a, b)

pair :: Pair
pair = Pair True False

main :: IO ()
main = putStrLn $ case pairToTuple pair of
   (True, True)   -> "T-T"
   (True, False)  -> "T-F"
   (False, True)  -> "F-T"
   (False, False) -> "F-F"

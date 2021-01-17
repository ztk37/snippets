data A
  = AA
  | AB
  | AC

data B
  = BA
  | BB
  | BC

data C
  = CA
  | CB
  | CC

type ABC = (A, B, C)

compute :: ABC -> Int
compute (a, b, c) =
  case a of
    AA ->
      case b of
        BA -> 4
        BB -> 5
        BC ->
          case c of
            CA -> 6
            CB -> 7
            CC -> 8
    AB -> 2
    AC ->
      case c of
        CA -> 9
        CB ->
         case b of
          BA -> 11
          BB -> 12
          BC -> 13
        CC -> 10

samples :: [ABC]
samples =
  [ (AA, BA, CA)
  , (AB, BB, CA)
  , (AC, BC, CC)
  , (AA, BB, CC)
  , (AB, BA, CB)
  ]

main :: IO ()
main = print $ map compute samples

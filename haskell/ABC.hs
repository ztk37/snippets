data ABC = A | B | C deriving (Eq, Show)

parse :: String -> Either String [ABC]
parse ('a':rest) = (A:) <$> parse rest
parse ('b':rest) = (B:) <$> parse rest
parse ('c':rest) = (C:) <$> parse rest
parse [] = pure [] -- aka Right []
parse (c:_) = Left $ "unknown char: " <> [c]

pretty :: [(ABC, Int)] -> String
pretty xs = unlines $ map formatter xs
  where
    formatter :: (ABC, Int) -> String
    formatter (k, n) = show k ++ ": " ++ show n

count :: [ABC] -> [(ABC, Int)]
count xs = foldr f [(A, 0), (B, 0), (C, 0)] xs
  where
    -- 100% - There is a "simpler" solution
    f :: ABC -> [(ABC, Int)] -> [(ABC, Int)]
    f A [(k, n), bs, cs] = [(k, succ n), bs, cs]
    f B [as, (k, n), cs] = [as, (k, succ n), cs]
    f C [as, bs, (k, n)] = [as, bs, (k, succ n)]

main :: IO ()
main = putStrLn  $ either id (pretty . count) (parse "abbacabccbcaabbabcbaba")

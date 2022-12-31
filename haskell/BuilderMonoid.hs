-- Lazy?
newtype Builder = Builder
  { unBuilder :: (String -> String) -> String -> String
  }

empty :: Builder
empty = Builder ($)
-- empty = Builder (\k s -> k s)

append :: Builder -> Builder -> Builder
append (Builder f) (Builder g) = Builder (f . g)

singleton :: String -> Builder
singleton s = Builder (\k buf -> k (buf ++ s))

runBuilder :: Builder -> String
runBuilder (Builder f) = f id "" 

instance Semigroup Builder where
  (<>) = append

instance Monoid Builder where
  mempty = empty
  mappend = append

main :: IO ()
main =
  let
    builder = singleton "a" <> singleton "b" <> singleton "c"
  in
    print $ runBuilder builder

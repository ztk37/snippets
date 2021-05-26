newtype Wrap a = Wrap
  { unWrap :: a
  } deriving (Eq, Show)

class HasItems a where
   addItem :: String -> a -> a

item :: HasItems a => String -> Wrap a -> Wrap a
item item' = Wrap . addItem item' . unWrap

data Intern = Intern
  { items :: [String]
  } deriving (Eq, Show)

instance HasItems Intern where
  addItem item intern = intern { items = item : items intern } 

main :: IO ()
main = print $ "foo" `item` (Wrap $ Intern ["bar"])

data ABC = A | B | C | None
  deriving (Show, Eq)


-- Use Maybe instead? '-'
instance Semigroup ABC where
  None <> m = m
  m <> None = m
  m <> _    = m
  -- or
  -- _ <> m = m

instance Monoid ABC where
  mempty = None

data XYZ = X | Y | Z
  deriving (Show, Eq)

instance Semigroup XYZ where
   _ <> m = m

data Whole = Whole [Int] [String] [Bool] ABC (Maybe XYZ)
  deriving (Show, Eq)

instance Semigroup Whole where
  (Whole is ss bs ts xs) <> (Whole is' ss' bs' ts' xs')
    = Whole (is <> is') (ss <> ss') (bs <> bs') (ts <> ts') (xs <> xs')

instance Monoid Whole where
  mempty = emptyWhole

setWholeA :: Whole
setWholeA = Whole mempty mempty mempty A Nothing

setWholeB :: Whole
setWholeB = Whole mempty mempty mempty B Nothing

setWholeC :: Whole
setWholeC = Whole mempty mempty mempty C Nothing

setWholeX :: Whole
setWholeX = Whole mempty mempty mempty C (Just X)

setWholeNone :: Whole
setWholeNone = Whole mempty mempty mempty None Nothing

addFirst :: Int -> Whole
addFirst x = Whole [x] mempty mempty None Nothing

addSecond :: String -> Whole
addSecond x = Whole mempty [x] mempty None Nothing

addThird :: Bool -> Whole
addThird x = Whole mempty mempty [x] None Nothing

emptyWhole :: Whole
emptyWhole = Whole mempty mempty mempty None Nothing

wholeA :: Whole
wholeA = Whole mempty mempty mempty A Nothing

main = print $ wholeA
  <> addFirst 42
  <> addSecond "sad"
  <> addFirst 21
  <> addThird True
  <> addThird False
  <> setWholeX

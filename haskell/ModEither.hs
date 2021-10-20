import Data.Char (toUpper)

newtype Endo a = Endo
  { appEndo :: a -> a
  }

instance Semigroup (Endo a) where
  (Endo f) <> (Endo g) = Endo (f . g)

instance Monoid (Endo a) where
  mempty = Endo id
  mappend = (<>)

data Mod a
  = ModSuccess (Endo a)
  | ModFailure [String]

instance Semigroup (Mod a) where
  l <> r = case (l, r) of
    (ModSuccess x, ModSuccess y) -> ModSuccess (mappend x y)
    (ModFailure x, ModFailure y) -> ModFailure (mappend x y)
    (ModFailure _, _) -> l
    (_, ModFailure _) -> r

instance Monoid (Mod a) where
  mempty = ModSuccess mempty
  mappend = (<>)

success :: (a -> a) -> Mod a
success = ModSuccess . Endo

failure :: String -> Mod a
failure x = ModFailure [x]

mod1 :: Mod String
mod1 = mconcat
  [ success reverse
  , success (map toUpper)
  ]

mod2 :: Mod String
mod2 = mconcat
  [ success reverse
  , failure "Failure 1"
  , success (map toUpper)
  ]

mod3 :: Mod String
mod3 = mconcat
  [ success reverse
  , failure "Failure 1"
  , success (map toUpper)
  , failure "Failure 2"
  , failure "Failure 3"
  ]

applyMod :: a -> Mod a -> Either [String] a
applyMod def mod =
  case mod of
    ModSuccess f -> Right $ appEndo f def
    ModFailure errs -> Left errs

report :: Show a => Either [String] a -> IO ()
report result =
  case result of
    Right x -> print x
    Left errs -> putStrLn $ unlines errs

main :: IO ()
main = do
  report $ applyMod "Input1" mod1
  report $ applyMod "Input2" mod2
  report $ applyMod "Input3" mod3

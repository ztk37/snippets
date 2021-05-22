{-# LANGUAGE GADTs #-}

data ResultADT
  = ContinueADT String
  | DoneADT

instance Show ResultADT where
  show (ContinueADT x) = "Continue with " ++ show x
  show DoneADT = "Done"

data ResultGADT where
  ContinueGADT :: String -> ResultGADT
  DoneGADT :: ResultGADT

instance Show ResultGADT where
  show (ContinueGADT x) = "Continue with " ++ show x
  show DoneGADT = "Done"

main :: IO ()
main = do
  print $ ContinueGADT "Foo"
  print DoneGADT

  print $ ContinueADT "Foo"
  print DoneADT

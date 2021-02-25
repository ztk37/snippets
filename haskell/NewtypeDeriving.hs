{-# LANGUAGE GeneralisedNewtypeDeriving #-}

data Record = Record
  { recordValue :: String }
  
instance Show Record where
  show (Record v) = "Record - value: " ++ v

class Monad m => Logging m where
  logMsg :: String -> m ()

newtype InCache a = InCache
  { unInCache :: IO a }
  deriving (Monad, Applicative, Functor)

instance Logging InCache where
  logMsg = InCache . putStrLn

fakeRecords :: (Logging m) => m [Record]
fakeRecords = return records
  where
    records =
      [ Record "A"
      , Record "B"
      , Record "C"
      ]

main :: IO ()
main = (unInCache $ fakeRecords) >>= (putStrLn . show)

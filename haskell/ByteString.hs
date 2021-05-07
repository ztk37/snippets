import Data.Char
import Data.Binary.Put
import Data.Binary (Binary (..))
import qualified Data.ByteString.Lazy.Char8 as BL

data Triple = Triple
  { tripleA :: Maybe String
  , tripleB :: String
  , tripleC :: Bool
  }

instance Binary Triple where
  put (Triple a b c) = put a >> put b >> put c
  get = Triple <$> get <*> get <*> get

triple :: Triple
triple = Triple (Just "damn") "derp" False

main :: IO ()
main = do
  BL.putStrLn $ (runPut $ put triple)
  print $ map ord $ BL.unpack $ (runPut $ put triple)

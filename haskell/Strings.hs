-- Cheat sheet taken from https://stackoverflow.com/a/40491001/13033259

import Data.ByteString.Lazy as BL
import Data.ByteString as BS
import Data.Text as TS
import Data.Text.Lazy as TL
import Data.ByteString.Lazy.UTF8 as BLU -- from utf8-string
import Data.ByteString.UTF8 as BSU      -- from utf8-string
import Data.Text.Encoding as TSE
import Data.Text.Lazy.Encoding as TLE

-- String <-> ByteString

BLU.toString   :: BL.ByteString -> String
BLU.fromString :: String -> BL.ByteString
BSU.toString   :: BS.ByteString -> String
BSU.fromString :: String -> BS.ByteString

-- String <-> Text

TL.unpack :: TL.Text -> String
TL.pack   :: String -> TL.Text
TS.unpack :: TS.Text -> String
TS.pack   :: String -> TS.Text

-- ByteString <-> Text

TLE.encodeUtf8 :: TL.Text -> BL.ByteString
TLE.decodeUtf8 :: BL.ByteString -> TL.Text
TSE.encodeUtf8 :: TS.Text -> BS.ByteString
TSE.decodeUtf8 :: BS.ByteString -> TS.Text

-- Lazy <-> Strict

BL.fromStrict :: BS.ByteString -> BL.ByteString
BL.toStrict   :: BL.ByteString -> BS.ByteString
TL.fromStrict :: TS.Text -> TL.Text
TL.toStrict   :: TL.Text -> TS.Text

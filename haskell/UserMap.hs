import Control.Arrow

import           Data.Map (Map)
import qualified Data.Map as M

data User = User
 { _id :: String
 , _username :: String
 , _email :: String
 , _password :: String
 } deriving (Eq, Show)

type UserMap = Map String User

fakeUsers :: UserMap
fakeUsers = M.fromList $ map f users
  where
    -- f :: User -> (String, User)
    -- f user = (_id user, user)

    f :: User -> (String, User)
    f = _id &&& id

    users :: [User]
    users =
      [ User "1" "A" "A@mymail.com" "aaa42"
      , User "2" "C" "B@mymail.com" "bbb42"
      , User "3" "C" "C@mymail.com" "ccc42"
      ]

lookupUser :: String -> IO (Maybe User)
lookupUser = return . flip M.lookup fakeUsers

main :: IO ()
main = (mapM lookupUser $ map show [1..5]) >>= print

import Html exposing (text)

type RemoteData e a
  = NotLoaded
  | Loading
  | Success a
  | Failure e

bimapRemoteData
  : (a -> b)
  -> (c -> d)
  -> RemoteData c a
  -> RemoteData d b
bimapRemoteData f g rd =
  case rd of
    NotLoaded -> NotLoaded
    Loading -> Loading
    Success a -> Success (f a)
    Failure e -> Failure (g e)


mapSuccess : (a -> b) -> RemoteData e a -> RemoteData e b
mapSuccess f rd = bimapRemoteData f identity rd

mapFailure : (c -> d) -> RemoteData c a -> RemoteData d a
mapFailure g rd = bimapRemoteData identity g rd

main =
  text "Meow!~"

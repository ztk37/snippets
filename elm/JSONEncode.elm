import Html exposing (text, pre)

import Dict exposing (Dict)
import Json.Encode as Encode

type alias AppSettings =
  { properties : Dict String String
  }
  
emptySettings : AppSettings
emptySettings = { properties = Dict.empty }
  
addProperty : String -> String -> AppSettings -> AppSettings
addProperty k v s =
  { s | properties = Dict.insert k v s.properties
  }
  
settings : AppSettings
settings =
  emptySettings
  |> addProperty "A" "a"
  |> addProperty "B" "b"  
  |> addProperty "C" "c"
  
encodeProperty : (String, String) -> Encode.Value
encodeProperty (k, v) =
  Encode.object
    [ ("key", Encode.string k)
    , ("value", Encode.string v)
    ]

encodeAppSettings : AppSettings -> Encode.Value
encodeAppSettings s =
  Encode.object
        [ ( "properties", Dict.toList s.properties |> Encode.list encodeProperty )
        ]

main = pre [] [settings |> encodeAppSettings |> Encode.encode 2 |> text ]

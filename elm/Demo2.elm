import Html exposing (..)
import Html.Events exposing (..)
import Browser

type alias Model =
  { count : Int
  , items : List Item
  }
  
type alias Item =
  { id : String
  , value : Int
  }

type Msg
  = Inc
  | Dec
  | Add Item

init : Model
init =
  { count = 0
  , items = []
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
    Inc ->
      { model | count = model.count + 1 }
    Dec ->
      { model | count = model.count - 1 }
    Add item ->
      { model | items = item :: model.items }

view : Model -> Html Msg
view model =
  div
    []
    [ div
      []
      [ button
        [ onClick (Add {id = "sdas", value = 1})
        ]
        [ text "add"
        ]
      , ul
        []
        (List.map (\item -> li [] [text (String.fromInt item.value)]) model.items)
      ]
    , div
      []
      [ button [onClick Inc] [text "+"]
      , text (String.fromInt model.count)
      , button [onClick Dec] [text "-"]
      ]
    ]

main : Program () Model Msg
main =
  Browser.sandbox
    { init = init
    , view = view
    , update = update
    }

module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html

import Url exposing (Url)

type Msg
  = SomeMsg

type Model
  = SomeModel
  
-- main : Program () () ()
-- main = Browser.application
--   { init = \_ _ _ -> ((), Cmd.none)
--   , onUrlChange = \_ -> ()
--   , onUrlRequest = \_ -> ()
--   , update = \_ model -> (model, Cmd.none)
--   , subscriptions = \_ -> Sub.none
--   , view = \_ ->
--     { title = "Title"
--     , body = [Html.text "App"]
--     }
--   }

main : Program () Model Msg
main = Browser.application
  { init = init
  , onUrlChange = onUrlChange
  , onUrlRequest = onUrlRequest
  , update = update
  , subscriptions = subscriptions
  , view = view
  }

onUrlChange : Url -> Msg
onUrlChange _ = SomeMsg

onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ = SomeMsg

init : () -> Url -> Navigation.Key -> (Model, Cmd Msg)
init _ _ _ = (SomeModel, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update _ model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

view : Model -> Browser.Document Msg
view _ =
  { title = "Title"
  , body =
    [ Html.text "App"
    ]
  }

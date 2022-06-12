module Main exposing (main)

import Browser
import Html

main : Program () () ()
main = Browser.application
  { init = \_ _ _ -> ((), Cmd.none)
  , onUrlChange = \_ -> ()
  , onUrlRequest = \_ -> ()
  , update = \_ model -> (model, Cmd.none)
  , subscriptions = \_ -> Sub.none
  , view = \_ ->
    { title = "Title"
    , body = [Html.text "App"]
    }
  }

import Browser
import Html exposing (Html)

type alias Model = String

type Msg = M

init : () -> (Model, Cmd Msg)
init _ = ("State", Cmd.none)

view : Model -> Html Msg
view model = Html.text model

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program () Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

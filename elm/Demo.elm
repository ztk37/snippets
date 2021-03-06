import Html exposing (Html, text, div, ul, li)

import List exposing (range, map)
import Tuple exposing (first)

import Random

type Msg = String

type Point = Point (Int, Int)

randomPoint : Random.Generator (Int, Int)
randomPoint = Random.pair (Random.int 0 10) (Random.int 0 10)

aView : String -> Html Msg
aView str = text str

bView : Html Msg
bView =
  range 1 10
  |> map(String.fromInt >> lView)
  |> ul []

cView : Point -> Html Msg
cView (Point (x, y)) =
  let
    items =
      map String.fromInt [x, y]
      |> String.join " "
      |> text
  in li [] [items]

lView : String -> Html Msg
lView str = li [] [text str]

main =
  div []
  [ aView "foo"
  , bView
  , cView (Point (1, 3))
  ]

module Main exposing (..)

import Html exposing (text)

run : String
run =
    "Hello, world!"
    
type Action
    = Inc
    | Dec
    | Double
    | Mul Int
    | Add Int
    | Sub Int

type alias State = Int

update : Action -> State -> State
update action state =
    case action of
        Inc -> state + 1
        Dec -> state - 1
        Double -> state * 2
        (Mul n) -> state * n
        (Add n) -> state + n
        (Sub n) -> state - n
        
main =
  update Inc 0 |> String.fromInt |> text

module Tuple = struct
  type t = int * string
           
  let create a b = (a, b)
                   
  let first (a, _) = a
    
  let secound (_, b) = b
                   
  let to_string (a, b) = Printf.sprintf "%d %s" a b
end

let () =
  Tuple.create 1 "2"
  |> Tuple.to_string
  |> print_string

let () =
  Tuple.create 1 "2"
  |> Tuple.first
  |> Printf.printf "%d"

let () =
  Tuple.create 1 "2"
  |> Tuple.secound
  |> Printf.printf "%s"

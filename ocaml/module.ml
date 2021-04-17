type abc
  = A 
  | B
  | C
  
let to_string = function 
  | A->"A"
  | B->"B"
  | C->"C"
    
module ABC = struct
  type t
    = A
    | B
    | C 
      
  type u
    = X
    | Y
    | Z
  
  (* types are accessable direclty via Module.Type *)
           
  let xyz_to_string = function
    | X -> "X"
    | Y -> "Y"
    | Z -> "Z" 
      
  let to_string = function
    | A -> "A"
    | B -> "B"
    | C -> "C" 
end

    
let () = ABC.A |> ABC.to_string |> print_string
let () = ABC.A |> ABC.to_string |> print_string
let () = ABC.A |> ABC.to_string |> print_string
         
let () = ABC.X |> ABC.xyz_to_string |> print_string
let () = ABC.Y |> ABC.xyz_to_string |> print_string
let () = ABC.Z |> ABC.xyz_to_string |> print_string
         
let () = A |> to_string |> print_string
let () = B |> to_string |> print_string
let () = C |> to_string |> print_string
         
         

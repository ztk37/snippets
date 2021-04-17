module type FooModuleType = sig
  type t = X | Y | Z
    
  val to_string : t -> string
end
         
module FooModule = (struct
  type t = X | Y | Z
    
  let to_string = function
    | X -> "X"
    | Y -> "Y"
    | Z -> "Z"
      
end : FooModuleType)

let () = FooModule.X |> FooModule.to_string |> print_string 
let () = FooModule.Y |> FooModule.to_string |> print_string 
let () = FooModule.Z |> FooModule.to_string |> print_string

(*
 * https://stackoverflow.com/questions/27762815/can-we-define-a-function-with-0-argument-in-ocaml
 *)
 
exception ToShort of string
 
module Todo = struct
  type t = { value : string}
           
  let create value = { value }
           
  let to_string todo = 
    if String.length(todo.value) > 5
    then print_string todo.value
    else raise (ToShort "value")

end
 
let main () = Todo.create "foo" |> Todo.to_string
  
let _ = main ()

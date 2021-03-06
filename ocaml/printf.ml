open Printf
    
let printf = Printf.printf

module Foo : sig
  val answer : int
  val foo : x:int -> int
  val bar : ?x:int -> int -> int 
  val fib : ?v:int -> unit -> int
end = struct
  let answer = 42
   
  let foo ~x = x 
    
  let bar ?(x=1) v = x + v
                     
  let fib ?v () =
    match v with
    | Some x -> x
    | None -> 42
end

let _ = Foo.foo ~x:3 |> printf "%d\n"
let _ = Foo.bar 4 |> printf "%d\n"
let _ = Foo.bar ~x:5 4 |> printf "%d\n"
let _ = Foo.fib () |> printf "%d\n"

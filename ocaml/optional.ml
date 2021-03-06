module type Foo = sig
  (** [of_int_exn t < cardinality] for all [t]. *)
  val answer : int
end

module Foo : sig
  val answer : int
  val foo : x:int -> int
  val bar : ?x:int -> int -> int 
end = struct
  let answer = 42
   
  let foo ~x = x 
    
  let bar ?(x=1) v = x + v
end

let _ = Foo.foo ~x:3 |> print_int
let _ = Foo.bar 4 |> print_int
let _ = Foo.bar ~x:5 4 |> print_int

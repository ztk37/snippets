module User = struct
  type t = { 
    id : int ;
    name : string ;
  }
  
  let create id name = { id ; name ; }

  let to_string user =
    Printf.sprintf "ID: %d - %s" user.id user.name
end


module UserCollection = struct 
  type t = { items : User.t list }
      
  let from items = { items }         
  
  let empty = { items = [] }
              
  let to_string col = List.map User.to_string col.items |> String.concat "\n"  
end

let users =
  UserCollection.from
    [ User.create 1 "foo"
    ; User.create 2 "bar"
    ; User.create 3 "fib"
    ] |> UserCollection.to_string
    
let () = Printf.printf "%s\n" users

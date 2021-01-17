type a =
  | AA
  | AB
  | AC
    
type b =
  | BA
  | BB
  | BC
    
type c =
  | CA
  | CB
  | CC
    
type abc = a * b * c
           
let compute (a, b, c) =
  match a with
  | AA ->
      (match b with
       | BA -> 4
       | BB -> 5
       | BC ->
           (match c with
            | CA -> 6
            | CB -> 7
            | CC -> 8))
  | AB -> 2
  | AC -> (match c with
      |CA -> 9
      | CB ->
          (match b with
           | BA -> 11
           | BB -> 12
           | BC -> 13)
      | CC -> 10)
  
let samples    =
  [ (AA, BA, CA)
  ; (AB, BB, CA)
  ; (AC, BC, CC)
  ; (AA, BB, CC)
  ; (AB, BA, CB)
  ]
  
let result = samples |> List.map compute
                
let rec print_result = function 
  | [] -> ()
  | hd::tl -> print_int hd ; print_string " " ; print_result tl
  
let () = result |> print_result

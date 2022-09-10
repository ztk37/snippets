module TemplateFile = struct
  type t = { file: string ; template: string }
  
  let empty = { file = ""; template = "" }
              
  let create file template = { file ; template }
              
  let file t = t.file
                 
  let template t = t.template
end

let () =
  TemplateFile.create "Foo" "Bar"
  |> TemplateFile.file
  |> print_string

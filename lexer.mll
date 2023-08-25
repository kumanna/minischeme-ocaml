{
open Parser
}

let white = [' ' '\t']*

let digit = ['0'-'9']
let int = '-'? digit+

rule read =
  parse
   white { read lexbuf }
  | int { INT (Lexing.lexeme lexbuf |> int_of_string) }
  | eof { EOF }

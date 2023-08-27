{
open Parser
}

let white = [' ' '\t']*

let digit = ['0'-'9']
let int = '-'? digit+
let float = '-'? int '.' int

rule read =
  parse
   white { read lexbuf }
  | "-" { MINUS }
  | "/" { DIVIDE }
  | "+" { PLUS }
  | "*" { MULT }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | int { INT (Lexing.lexeme lexbuf |> int_of_string) }
  | float { FLOAT (Lexing.lexeme lexbuf |> Float.of_string) }
  | eof { EOF }

{
open Parser
}

let white = [' ' '\t']*

rule read =
  parse
   white { read lexbuf }
  | eof { EOF }

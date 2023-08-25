open Ast


let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let string_of_val = function
  | Int i -> string_of_int i

let is_value = function
  | Int _ -> true

let step = function
  | Int _ -> failwith "Can't step integers!"

let rec eval e =
  if is_value e then e else (e |> step |> eval)

let interp s =
  s |> parse |> eval |> string_of_val

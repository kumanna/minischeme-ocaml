open Ast

let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let string_of_val = function
  | Int i -> string_of_int i
  | Multiop _ -> failwith "Parsing error!"

let is_value = function
  | Int _ -> true
  | Multiop _ -> false

let rec step = function
  | Int _ -> failwith "Can't step integers!"
  | Multiop (op, ilist) ->
    step_multiop op ilist

and step_multiop op ilist =
  let binop a b =
    match op with
    | Add -> a + b
    | Multiply -> a * b
  in
  match ilist with
  | [] -> Int 0
  | [Int a] -> Int a
  | [Multiop (op1, ilist1)] -> step (Multiop (op1, ilist1))
  | (Int a)::(Int b)::tail -> step (Multiop (op, (Int (binop a b)::tail)))
  | (Int a)::(Multiop (op1, ilist1))::tail -> (Multiop (op, (Int a)::(step (Multiop (op1, ilist1)))::tail))
  | (Multiop (op1, ilist1))::tail -> (Multiop (op, (step (Multiop (op1, ilist1)))::tail))

let rec eval e =
  if is_value e then e else (e |> step |> eval)

let interp s =
  s |> parse |> eval |> string_of_val

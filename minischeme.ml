open Ast

let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let string_of_val = function
  | Int i -> string_of_int i
  | Float f -> let s = Float.to_string f in
    if String.ends_with ~suffix:"." s then s ^ "0" else s
  | Multiop _ -> failwith "Parsing error!"
  | Binop _ -> failwith "Parsing error!"

let is_value = function
  | Int _ -> true
  | Float _ -> true
  | Multiop _ -> false
  | Binop _ -> false

let rec step = function
  | Int _ -> failwith "Can't step integers!"
  | Float _ -> failwith "Can't step floats!"
  | Multiop (op, ilist) ->
    step_multiop op ilist
  | Binop (op, e1, e2) ->
    step_binop op e1 e2

and step_multiop op ilist =
  let binop a b =
    match op with
    | Add -> a + b
    | Multiply -> a * b
  in
  let binop_float a b =
    match op with
    | Add -> a +. b
    | Multiply -> a *. b
  in
  match ilist with
  | [] -> Int 0
  | [Int a] -> Int a
  | [Float a] -> Float a
  | [Binop (op, a, b)] -> step_binop op a b
  | (Int a)::(Int b)::tail -> step (Multiop (op, (Int (binop a b)::tail)))
  | (Float a)::(Float b)::tail -> step (Multiop (op, (Float (binop_float a b)::tail)))
  | (Float a)::(Int b)::tail | (Int b)::(Float a)::tail -> step (Multiop (op, (Float (binop_float a (Float.of_int b))::tail)))
  | (Int a)::(Multiop (op1, ilist1))::tail -> (Multiop (op, (Int a)::(step (Multiop (op1, ilist1)))::tail))
  | (Float a)::(Multiop (op1, ilist1))::tail -> (Multiop (op, (Float a)::(step (Multiop (op1, ilist1)))::tail))
  | (Multiop (op1, ilist1))::tail -> (Multiop (op, (step (Multiop (op1, ilist1)))::tail))
  | e1::tail -> Multiop (op, (step e1)::tail)

and step_binop op e1 e2 =
  let binop a b =
    match op with
    | Subtract -> a - b
    | Divide -> a / b
  in
  let binop_float a b =
    match op with
    | Subtract -> a -. b
    | Divide -> a /. b
  in
  match (e1, e2) with
  | (Int a, Int b) -> Int (binop a b)
  | (Float a, Float b) -> Float (binop_float a b)
  | (Float a, Int b) -> Float (binop_float a (Float.of_int b))
  | (Int a, Float b) -> Float (binop_float (Float.of_int a) b)
  | (Float a, e1) -> step_binop op (Float a) (step e1)
  | (e1, Float a) -> step_binop op (step e1) (Float a)
  | (Int a, e1) -> step_binop op (Int a) (step e1)
  | (e1, Int a) -> step_binop op (step e1) (Int a)
  | (x, y) -> step_binop op (step x) (step y)

let rec eval e =
  if is_value e then e else (e |> step |> eval)

let interp s =
  s |> parse |> eval |> string_of_val

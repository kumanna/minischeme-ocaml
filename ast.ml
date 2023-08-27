type multiop =
  | Add
  | Multiply

type binop =
  | Subtract

type expr =
  | Int of int
  | Float of float
  | Multiop of multiop * (expr list)
  | Binop of binop * expr * expr

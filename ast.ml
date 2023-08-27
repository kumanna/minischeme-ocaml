type multiop =
  | Add
  | Multiply

type expr =
  | Int of int
  | Float of float
  | Multiop of multiop * (expr list)

type multiop =
  | Add
  | Multiply

type expr =
  | Int of int
  | Multiop of multiop * (expr list)

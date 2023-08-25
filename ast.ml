type multiop =
  | Add

type expr =
  | Int of int
  | Multiop of multiop * (expr list)

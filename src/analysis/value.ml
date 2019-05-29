type t =
  | IntConst of int
  | FloatConst of float
  | StringConst of string
  | BoolConst of bool
  | Tuple of t list
  | Array of t list

let rec value_is_const v =
  match v with
    | IntConst _ -> true
    | FloatConst _ -> true
    | StringConst _ -> true
    | BoolConst _ -> true
    | Tuple items -> List.for_all value_is_const items
    | Array items -> List.for_all value_is_const items

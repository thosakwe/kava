type t =
  (* TODO: Add location info *)
  | TypeSymbol of string * Type.t
  | ValueSymbol of string * Value.t

let name_of_symbol sym =
  match sym with
    | TypeSymbol(n, _) -> n
    | ValueSymbol(n, _) -> n

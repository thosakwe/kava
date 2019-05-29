type t =
  | RootScope of Symbol.t list
  | ChildScope of t ref * Symbol.t list

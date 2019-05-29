type t =
  {
    name: string;
    params: (string * Type.t) list;
    returns: Type.t;
    body: Block.t;
  }

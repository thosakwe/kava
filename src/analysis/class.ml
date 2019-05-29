type t =
  {
    name: string;
    abstract: bool;
    parent: t option;
    methods: Method.t list;
  }

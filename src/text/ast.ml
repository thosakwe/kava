type type_ctx =
  | TypeRefCtx of name_ctx
and name_ctx =
  | LeafName of string
  | NodeName of name_ctx * string

type expr_ctx =
  | IntConstCtx of int
  | FloatConstCtx of float
  | BoolConstCtx of bool
  | StringConstCtx of string
  | IdCtx of string
  | InstantiationCtx of type_ctx * (expr_ctx list)

type stmt_ctx =
  | CallCtx of expr_ctx * (expr_ctx list)
  | ReturnCtx of expr_ctx

type block_ctx =
  | LambdaBlockCtx of expr_ctx
  | StmtBlockCtx of stmt_ctx
  | BasicBlockCtx of stmt_ctx list

type method_modifier_ctx =
  | Static
  | Public
  | Protected
  | Private

type field_ctx =
  {
    name: string;
    modifiers: method_modifier_ctx list;
    typeof: type_ctx;
  }

type method_ctx =
  {
    name: string;
    modifiers: method_modifier_ctx list;
    params: (string * type_ctx) list;
    returns: type_ctx option;
    body: block_ctx option;
  }

type member_ctx =
  | Field of field_ctx
  | Method of method_ctx

type class_ctx =
  {
    name: string;
    abstract: bool;
    members: member_ctx list;
  }

type directive_ctx =
  | Open of string

type compilation_unit_ctx =
  {
    class_def: class_ctx;
  }

let stmts_of_block_ctx ctx =
  match ctx with
    | LambdaBlockCtx v -> [ReturnCtx v]
    | StmtBlockCtx s -> [s]
    | BasicBlockCtx stmts -> stmts

let rec string_of_name_ctx ctx =
  match ctx with
    | LeafName s -> s
    | NodeName(parent, s) -> (string_of_name_ctx parent) ^ "." ^ s

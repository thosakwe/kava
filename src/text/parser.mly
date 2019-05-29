%token <float> FLOAT
%token <int> INT
%token <bool> BOOL
%token <string> ID
%token <string> STRING
%token ARROW COLON COMMA DOT
%token LCURLY RCURLY LPAREN RPAREN
%token ABSTRACT CLASS OPEN
%token PUBLIC PROTECTED PRIVATE STATIC
%token RETURN
%token EOF

%start <Ast.compilation_unit_ctx option> compilation_unit
%%

type_ctx:
  | n = name { Ast.TypeRefCtx n }

name:
  | s = STRING { Ast.LeafName s }
  | p = name; s = STRING { Ast.NodeName(p, s) }

expr:
  | x = INT { Ast.IntConstCtx x }
  | x = FLOAT { Ast.FloatConstCtx x }
  | x = BOOL { Ast.BoolConstCtx x }
  | x = STRING { Ast.StringConstCtx x }
  | x = ID { Ast.IdCtx x } 
  | t = type_ctx;
    LPAREN;
    args = separated_list(COMMA, expr);
    RPAREN { Ast.InstantiationCtx (t, args) }
  | LPAREN; x = expr; RPAREN { x }

stmt:
  | t = expr;
    LPAREN;
    args = separated_list(COMMA, expr);
    RPAREN { Ast.CallCtx (t, args) }
  | RETURN; x = expr { Ast.ReturnCtx x }

block:
  | ARROW; x = expr { Ast.LambdaBlockCtx x }
  | x = stmt { Ast.StmtBlockCtx x }
  | LCURLY; stmts = list(stmt); RCURLY { Ast.BasicBlockCtx stmts }

method_modifier:
  | STATIC { Ast.Static }
  | PUBLIC { Ast.Public }
  | PROTECTED { Ast.Protected }
  | PRIVATE { Ast.Private }

field:
  | m = list(method_modifier); n = ID; COLON; t = type_ctx
    {
      { Ast.name = n; Ast.modifiers = m; Ast.typeof = t }
    }

param:
  | n = ID; COLON; t = type_ctx { (n,t) }

returns:
  | { None }
  | t = type_ctx { Some t }

method_ctx:
  | n = ID;
    m = list(method_modifier);
    LPAREN;
    p = separated_list(COMMA, param);
    RPAREN;
    r = returns;
    b = option(block);
    {
      {
        Ast.name = n;
        Ast.modifiers = m;
        Ast.params = p;
        Ast.returns = r;
        Ast.body = b;
      }
    }

member:
  | f = field { Ast.Field f }
  | m = method_ctx { Ast.Method m }

class_ctx:
  | a = boption(ABSTRACT);
    CLASS;
    n = ID;
    LCURLY;
    m = list(member);
    RCURLY
    {
      {
        abstract = a;
        name = n;
        members = m;
      }
    }

directive:
  | OPEN; s = STRING { Ast.Open s }

compilation_unit:
  | EOF { None }
  | c = class_ctx
    {
      Some {
        class_def = c;
      }
    }

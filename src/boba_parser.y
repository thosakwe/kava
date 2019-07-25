%language "c++"
%define api.namespace {boba}
%define api.prefix {boba}
%define api.token.constructor
%define api.value.type variant
%define parse.assert true

%token RETURN

%%

%type <std::string> return;

return:
  RETURN { $$ = "Hello!"; }
;

%language "c++"
%define api.token.constructor
%define api.value.type variant

%token RETURN

%%

%type <std::string> return;

return:
  RETURN { $$ = "Hello!"; }
;

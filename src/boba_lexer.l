%option noyywrap reentrant
%option prefix="boba"

%{
  #include <token.hpp>
  #define YY_DECL boba::Token::TokenType yylex(yyscan_t yyscanner)
  #define yyterminate() ;
%}

ID  [A-Za-z_][A-Za-z0-9_]*
WS  [ \r\t]+

%%

%{
using namespace boba;
%}

\n            ;
WS            ;
"["           return Token::LBRACKET;
"]"           return Token::RBRACKET;
"{"           return Token::LCURLY;
"}"           return Token::RCURLY;
"("           return Token::LPAREN;
")"           return Token::RPAREN;
,             return Token::COMMA;
"<"           return Token::LT;
">"           return Token::GT;
class         return Token::CLASS;
extends       return Token::EXTENDS;
final         return Token::FINAL;
if            return Token::IF;
implements    return Token::IMPLEMENTS;
move          return Token::MOVE;
return        return Token::RETURN;
var           return Token::VAR;
{ID}          return Token::ID;

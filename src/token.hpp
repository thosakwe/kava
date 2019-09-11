#ifndef BOBA_TOKEN_HPP
#define BOBA_TOKEN_HPP
#include <string>

namespace boba {
struct SourceLocation {
  std::string filename;
  unsigned long offset, line, column;
};

struct SourceSpan {
  SourceLocation start, end;
};

struct Token {
  enum TokenType {
    LBRACKET,
    RBRACKET,
    LCURLY,
    RCURLY,
    LPAREN,
    RPAREN,
    COMMA,
    LT,
    GT,
    CLASS,
    EXTENDS,
    FINAL,
    IF,
    IMPLEMENTS,
    MOVE,
    RETURN,
    VAR,
    ID
  };

  TokenType type;
  SourceSpan span;
  std::string text;
};
}  // namespace boba

#endif

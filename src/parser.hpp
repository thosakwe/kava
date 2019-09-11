#ifndef BOBA_PARSER_HPP
#define BOBA_PARSER_HPP
#include <boba_lexer.hpp>
#include "token.hpp"

namespace boba {
class Parser {
  Parser();
  ~Parser();
  Parser(const Parser&) = delete;
  Parser(Parser&&) = delete;
  Parser& operator=(const Parser&) = delete;
  Parser& operator=(Parser&&) = delete;
  bool next(Token::TokenType type);

 private:
  yyscan_t scanner;
};
}  // namespace boba

#endif

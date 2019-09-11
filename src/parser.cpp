#include "parser.hpp"

using namespace boba;

Parser::Parser() {
  bobalex_init(&scanner);
}

Parser::~Parser() {
  bobalex_destroy(scanner);
}

bool Parser::next(Token::TokenType type) {
  auto yy = bobalex(scanner);
}

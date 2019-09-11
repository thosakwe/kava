find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)
flex_target(BobaLexer boba_lexer.l
  ${CMAKE_CURRENT_BINARY_DIR}/boba_lexer.cpp
  DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/boba_lexer.hpp)
include_directories(
  ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_LIST_DIR})
add_library(boba
  ${FLEX_BobaLexer_OUTPUTS}
  parser.hpp
  token.hpp
)
target_link_libraries(boba ${FLEX_LIBRARIES})

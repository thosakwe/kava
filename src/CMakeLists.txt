find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

bison_target(BobaParser boba_parser.y ${CMAKE_CURRENT_BINARY_DIR}/boba_parser.cc)
flex_target(BobaLexer boba_lexer.l ${CMAKE_CURRENT_BINARY_DIR}/boba_lexer.cc)
include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_library(boba
  ${BISON_BobaParser_OUTPUTS}
  ${FLEX_BobaLexer_OUTPUTS}
)
target_link_libraries(boba ${FLEX_LIBRARIES})

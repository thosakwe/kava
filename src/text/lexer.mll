{
open Lexing
open Parser

exception SyntaxError of string

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = lexbuf.lex_curr_pos;
               pos_lnum = pos.pos_lnum + 1
    }
}

let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let int = digit* exp?
let float = digit* frac exp?

let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let id = ['A'-'Z' 'a'-'z' '_']['A'-'Z' 'a'-'z' '0'-'9' '_']*

rule read =
  parse
  | white    { read lexbuf }
  | newline  { read lexbuf }
  | "->"     { ARROW }
  | ':'      { COLON }
  | ','      { COMMA }
  | '.'      { DOT }
  | '{'      { LCURLY }
  | '}'      { RCURLY }
  | '('      { LPAREN }
  | ')'      { RPAREN }
  | "abstract" { ABSTRACT }
  | "class"  { CLASS }
  | "open"   { OPEN }
  | "public" { PUBLIC }
  | "protected" { PROTECTED }
  | "private" { PRIVATE }
  | "return" { RETURN }
  | "static" { STATIC }
  | int      { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | float    { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | "true"   { BOOL true }
  | "false"  { BOOL false }
  | '"'      { read_string (Buffer.create 17) lexbuf }
  | id       { ID (Lexing.lexeme lexbuf) }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof      { EOF }
and read_string buf =
  parse
  | '"'       { STRING (Buffer.contents buf) }
  | '\\' '/'  { Buffer.add_char buf '/'; read_string buf lexbuf }
  | '\\' '\\' { Buffer.add_char buf '\\'; read_string buf lexbuf }
  | '\\' 'b'  { Buffer.add_char buf '\b'; read_string buf lexbuf }
  | '\\' 'f'  { Buffer.add_char buf '\012'; read_string buf lexbuf }
  | '\\' 'n'  { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | '\\' 'r'  { Buffer.add_char buf '\r'; read_string buf lexbuf }
  | '\\' 't'  { Buffer.add_char buf '\t'; read_string buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }

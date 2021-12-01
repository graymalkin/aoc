{
  open ParserBoot
  exception Syntax_error of string
  exception Lexing_error of string
}

let bagWord = ['a'-'z']+
let num = ['+''-']?['0'-'9']+
let ws = [' ' '\t' '\r']+

rule token = parse
  | "//" [^ '\n']* { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; NL }
  | "acc" { ACC }
  | "jmp" { JMP }
  | "nop" { NOP }
  | num as n { INT (int_of_string n) }
  | ws { token lexbuf }
  | eof { EOF }

%token CONTAIN
%token BAGS
%token BAG
%token COMMA
%token PERIOD

%token NO OTHER

%token NL
%token EOF
%token <string> BAGWORD
%token <int> INT


%start <(string * (int * string) list) list> top

%%

top:
  separated_list(NL, line) EOF { $1 }

line: 
  b=bagName bags CONTAIN bs=separated_list(COMMA, bagqty) PERIOD { b, bs }
| b=bagName bags CONTAIN NO OTHER BAGS PERIOD { b, [] }

bags: 
  BAG {$1}
| BAGS {$1}

bagqty:
  i=INT bn=bagName BAGS { (i, bn) }
| i=INT bn=bagName BAG  { (i, bn) }

bagName:
  b1=BAGWORD b2=BAGWORD { b1 ^ " " ^ b2 }
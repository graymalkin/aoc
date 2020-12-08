%token ACC JMP NOP
%token <int> INT

%token NL
%token EOF


%start <BootCode.instruction list> top

%%

top:
  separated_list(NL, instruction) EOF { $1 }

instruction: 
  ACC INT { BootCode.Acc ($2) }
| JMP INT { BootCode.Jmp ($2) }
| NOP INT { BootCode.Nop ($2) }

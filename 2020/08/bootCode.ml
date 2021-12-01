open Shared

type instruction =
  Acc of int
| Jmp of int
| Nop of int

type program = instruction list

type register_file = { pc : int; acc : int; running : bool }

let initial_state = { pc = 0; acc = 0; running = true }

let execute_instruction rf = function
    Acc x -> { rf with pc = rf.pc + 1; acc = rf.acc + x}
  | Jmp x -> { rf with pc = rf.pc+x }
  | Nop _ -> { rf with pc = rf.pc+1 }

let execute_program rf program =
  let inst_o = List.nth_opt program rf.pc in
  maybe { rf with running = false } (execute_instruction rf) inst_o

(* Returns the register file when the program terminates, or when it loops *)
let run_no_loop prog =
  let pc_list = ref [] in
  let rf = ref initial_state in
  while not (List.mem !rf.pc !pc_list) && !rf.running;
  do
    pc_list := !rf.pc :: !pc_list;
    rf := execute_program !rf prog;
  done;
  !rf

(* Returns the register file when the program terminates *)
let run prog =
  let rf = ref initial_state in
  while !rf.running;
  do
    rf := execute_program !rf prog;
  done;
  !rf

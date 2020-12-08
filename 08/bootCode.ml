open Shared

type instruction =
  Acc of int
| Jmp of int
| Nop of int

type register_file = { pc : int; acc : int; running : bool }

let initial_state = {pc = 0; acc = 0; running = true}

let execute_instruction rf program =
  let inst_o = List.nth_opt program rf.pc in
  match inst_o with
  | None -> { rf with running = false }
  | Some inst ->
    match inst with
      Acc x -> { rf with pc = rf.pc + 1; acc = rf.acc + x}
    | Jmp x -> {rf with pc = rf.pc+x}
    | Nop _ -> {rf with pc = rf.pc+1}

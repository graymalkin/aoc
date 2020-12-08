open Shared
open BootCode

let parse_program p = ParserBoot.top LexBoot.token (Lexing.from_string p)

(* Returns the register file when the program terminates, or when it loops *)
let run_no_loop prog =
  let pc_list = ref [] in
  let rf = ref initial_state in
  while not (List.mem !rf.pc !pc_list) && !rf.running;
  do
    pc_list := !rf.pc :: !pc_list;
    rf := execute_instruction !rf prog;
  done;
  !rf

let replace_nth xs n v =
  List.init (List.length xs) (fun n' ->
    if n' = n then v
    else List.nth xs n'
  )

let perturb_nop prog = 
  List.iteri (fun i x ->
    match x with Jmp _ | Acc _ -> ()
    | Nop x -> 
      let new_program = replace_nth prog i (Jmp x) in 
      let rf = run_no_loop new_program in
      if not (rf.running)
      then Printf.printf "%d\n" rf.acc
  ) prog

let perturb_acc prog = 
  List.iteri (fun i x ->
    match x with Acc _ | Nop _ -> ()
    | Jmp x -> 
      let new_program = replace_nth prog i (Nop x) in 
      let rf = run_no_loop new_program in
      if not (rf.running)
      then Printf.printf "%d\n" rf.acc
  ) prog

let () =
  let prog = parse_program (input_string ()) in
  let pc_list = ref [] in
  let pc = ref 0 in
  let rf = ref initial_state in
  while not (List.mem !pc !pc_list);
  do
    pc_list := !pc :: !pc_list;
    rf := execute_instruction !rf prog;
    pc := !rf.pc
  done;
  Printf.printf "%d\n" !rf.acc;
  perturb_acc prog;
  perturb_nop prog


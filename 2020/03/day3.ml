open Shared

(* A cell either has a tree, or is empty *)
type terrain = T | E

(* The field is a 2D array *)
type field = terrain list list

let parse inp =
  List.fold_left (fun acc xs ->
    acc @ [List.map (function '.' -> E | '#' -> T | _ -> raise Not_found) (explode xs)]
  ) [] inp 

(* Start at top left of terrain. +x goes across, +y goes down. *)
let terrain_at_point f x y =
  let line = List.nth f y in
  List.nth line (x mod List.length line)

let try_slope f (x_step, y_step) =
  let x = ref 0 in
  let y = ref 0 in
  let trees = ref 0 in
  while !y < List.length f
  do
    begin
      match terrain_at_point f !x !y with
        E -> ()
      | T -> incr trees
    end;
    x := !x + x_step;
    y := !y + y_step;
  done;
  !trees

let () = 
  let input = input_string_list () in
  let f = parse input in
  let slopes = List.map (try_slope f) [(1,1); (3, 1); (5, 1); (7,1); (1,2)] in
  Printf.printf "%d\n" (product slopes)

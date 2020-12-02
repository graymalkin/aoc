open Shared

type constr = C of char * (int * int)
type passwd = constr * char list

let check_sled_constraint (C (ch, (min, max)), pass) =
  let x = count ch pass in
  (x >= min) && (x <= max)

let check_toboggan_constraint (C (ch, (a, b)), pass) =
  xor (List.nth pass (a - 1) = ch) (List.nth pass (b - 1) = ch)

let parse_input ss =
  List.map (fun s ->
    let parts = String.split_on_char ' ' s in
    let minMax = String.split_on_char '-' (List.nth parts 0) in
    let char = List.nth parts 1 in
    let min = int_of_string (List.nth minMax 0) in
    let max = int_of_string (List.nth minMax 1) in
    let ch = List.nth (explode char) 0 in
    let password = List.nth parts 2 in
    (C (ch, (min, max)), explode @@ password)
  ) ss

let () =
  let parsed = parse_input (input_string_list ()) in
  let corruptedSled = count true (List.map check_sled_constraint parsed) in
  let corruptedToboggan= count true (List.map check_toboggan_constraint parsed) in
  Printf.printf "%d\n" corruptedSled;
  Printf.printf "%d\n" corruptedToboggan

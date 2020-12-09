open Shared

type position = F | B | L | R

let parse_position xs = 
  List.fold_left (fun acc x ->
    (match x with 'F' -> F | 'B' -> B | 'L' -> L | 'R' -> R | _ -> raise Parse_error) :: acc
  ) [] xs

let int_of_position_list ps =
  List.fold_left (fun acc x -> Int.shift_left acc 1 + (match x with F | L -> 0 | B | R -> 1)) 0 ps

let find_missing seat_ids min max = List.filter (fun i -> not (List.mem i seat_ids)) (range min max)

let () =
  let input = input_string_list () in
  let position_lists = List.map (fun xs -> parse_position @@ List.rev @@ explode xs) input in
  let seat_ids = List.map int_of_position_list position_lists in
  Printf.printf "%d\n" (maxs seat_ids);
  let missing = find_missing seat_ids (mins seat_ids) (maxs seat_ids) in
  Printf.printf "%d\n" (List.nth missing 0)

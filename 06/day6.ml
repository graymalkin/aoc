open Shared

let big_union l = List.sort_uniq compare (List.flatten l)
let big_intersection l = big_union @@ List.map (List.filter (fun x -> List.for_all (fun xs' -> List.mem x xs') l)) l

let () = 
  let input = input_string () in
  let groups = Str.split (Str.regexp "\n\n") input in
  let groups_split_by_lines = List.map (Str.split (Str.regexp "\n")) groups in
  let declarations : char list list list = List.map (List.map explode) groups_split_by_lines in

  let unique_declarations = List.map big_union declarations in
  let ud_counts = List.map List.length unique_declarations in
  Printf.printf "%d\n" (sum ud_counts);

  let common_declarations = List.map big_intersection declarations in
  let cd_counts = List.map List.length common_declarations in
  Printf.printf "%d\n" (sum cd_counts)

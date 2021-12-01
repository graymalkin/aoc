open Shared
type bag_tree = (string * (int * string) list) list

let parse () : bag_tree =
  let s = input_string () in
  let lexbuf = Lexing.from_string s in
  Parser.top Lex.token lexbuf

let find_contains (bagTree : bag_tree) x =
  List.fold_right (fun (b, bs) acc ->
    if List.mem x (List.map snd bs) then b :: acc else acc
  ) bagTree []

let rec bag_holds bagTree bag =
  let sub_bags = List.assoc bag bagTree in
  1 + sum (List.map (fun (n, bn) -> n * bag_holds bagTree bn) sub_bags)

let () =
  let bagTree = parse () in
  let contains = ref (find_contains bagTree "shiny gold") in
  let containsPrev = ref [] in
  while !contains <> !containsPrev;
  do
    containsPrev := !contains;
    let newBags = List.flatten @@ List.map (find_contains bagTree) !contains in
    contains := List.sort_uniq compare (!contains @ newBags)
  done;
  Printf.printf "%d\n" (List.length !contains);
  Printf.printf "%d\n" ((bag_holds bagTree "shiny gold") - 1)

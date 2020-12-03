open Shared

let input = input_int_list ()

let solve xss =
  let sum2020 = List.filter (fun xs -> sum xs = 2020) xss in
  product (List.nth sum2020 0)

(* Part 1: find 2 inputs (a, b) which sum to 2020 and print a*b *)
let () =
  let list_product = BatList.n_cartesian_product [input; input] in
  Printf.printf "%d\n" (solve list_product)

(* Part 2: find 3 inputs (a, b, c) which sum to 2020 and print a*b*c *)
let () =
  let list_product = BatList.n_cartesian_product [input; input; input] in
  Printf.printf "%d\n" (solve list_product)

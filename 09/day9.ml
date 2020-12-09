open Shared

let is_invalid xs n =
  let combinations = BatList.cartesian_product xs xs in
  not (List.exists (fun (x, y) -> x <> y && x + y = n) combinations)

let preamble_length = 25

let () =
  let input = input_int_list () in
  let invalid = findi (fun i x ->
      is_invalid (sublist input i (i+preamble_length)) x
    ) (sublist input preamble_length (List.length input))
  in
  Printf.printf "%d\n" invalid;
  List.iter (fun length ->
    List.iter (fun start -> 
      let window = sublist input start (start + length) in
      if sum window = invalid
      then Printf.printf "%d %d\n" length ((min compare window) + (max compare window))
    ) (range 0 (List.length input - length))
  ) (range 0 100)
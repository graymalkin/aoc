open Shared
exception Short_circuit of int

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
  try
    List.iter (fun length ->
      List.iter (fun start -> 
        let window = sublist input start (start + length) in
        if sum window = invalid
        then raise (Short_circuit (mins window + maxs window))
      ) (range 0 (List.length input - length))
    ) (List.rev (range 0 20))
  with Short_circuit x ->
    Printf.printf "%d\n" x
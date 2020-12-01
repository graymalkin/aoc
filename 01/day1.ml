let input = 
  let buf = ref [] in
  try
    while true;
    do
      buf := !buf @ [int_of_string (read_line ())]
    done;
    []
  with _ -> !buf


let pp_int fmt i = Format.fprintf fmt "%d" i

let pp_list f fmt xs = 
  Format.fprintf fmt "[";
  List.iter (Format.fprintf fmt "%a, " f) xs;
  Format.fprintf fmt "]"

let sums2020 = List.map (fun x ->
    List.filter (fun y -> x + y = 2020) input
  ) input


let () = 
  let sums2020 = List.filter (fun xs -> List.length xs > 0) sums2020 in
  let product = List.fold_right (fun x acc -> (List.nth x 0) * acc) sums2020 1 in
  Printf.printf "%d\n" product
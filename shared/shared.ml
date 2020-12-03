let input_string_list () = 
  let buf = ref [] in
  try
    while true;
    do
      buf := !buf @ [read_line ()]
    done;
    []
  with _ -> !buf

let input_int_list () = 
  List.map int_of_string (input_string_list ())


(* Helpful function to turn strings into list of chars. Thanks stackoverflow.
   https://stackoverflow.com/questions/10068713/string-to-list-of-char
*)
let explode s = List.init (String.length s) (String.get s)

let xor a b = (a || b) && not (a && b)

let count x xs = List.fold_right (fun x' acc -> if x = x' then acc + 1 else acc) xs 0

let sum xs = List.fold_right (+) xs 0
let product xs = List.fold_right ( * ) xs 1

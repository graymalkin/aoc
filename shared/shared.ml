let input_int_list () = 
  let buf = ref [] in
  try
    while true;
    do
      buf := !buf @ [int_of_string (read_line ())]
    done;
    []
  with _ -> !buf

open Shared

exception Parse_error

type byr = Byr of int
type iyr = Iyr of int
type eyr = Eyr of int
type hgt = HgtCm of int | HgtIn of int
type hcl = Hcl of int
type ecl = Amb | Blu | Brn | Gry | Grn | Hzl | Oth
type pid = Pid of int
type cid = Cid of int | NorthPoleCredential

type passport = byr * iyr * eyr * hgt * hcl * ecl * pid * cid

let parse_birth_year p =
  let ys = List.assoc "byr" p in
  assert (String.length ys = 4);
  let y = int_of_string ys in
  assert (y >= 1920 && y <= 2002);
  Byr y

let parse_issue_year p =
  let ys = List.assoc "iyr" p in
  assert (String.length ys = 4);
  let y = int_of_string ys in
  assert (y >= 2010 && y <= 2020);
  Iyr y

let parse_end_year p =
  let ys = List.assoc "eyr" p in
  assert (String.length ys = 4);
  let y = int_of_string ys in
  assert (y >= 2020 && y <= 2030);
  Eyr y

let parse_height p =
  let h = List.assoc "hgt" p in
  if String.contains h 'c'
  then
    let unit_begin = String.index h 'c' in
    let h = (int_of_string (String.sub h 0 unit_begin)) in
    assert (h >= 150 && h <= 193);
    HgtCm h
  else
    let unit_begin = String.index h 'i' in
    let h = (int_of_string (String.sub h 0 unit_begin)) in
    assert (h >= 59 && h <= 76);
    HgtIn h

let parse_hair_color p =
  let c = List.assoc "hcl" p in
  let hex = String.sub c 1 (String.length c-1) in
  assert (String.length hex = 6);
  Hcl (int_of_string ("0x" ^ hex))

let parse_eye_color p = 
  let ec = List.assoc "ecl" p in
  match ec with
    "amb" -> Amb | "blu" -> Blu | "brn" -> Brn 
  | "gry" -> Gry | "grn" -> Grn | "hzl" -> Hzl 
  | "oth" -> Oth
  | _ -> raise Parse_error

let parse_pid p =
  let pid = List.assoc "pid" p in
  assert (String.length pid = 9);
  Pid (int_of_string pid)

let parse_cid p =
    NorthPoleCredential

let kv_to_passport p : passport =
  parse_birth_year p,
  parse_issue_year p,
  parse_end_year p,
  parse_height p,
  parse_hair_color p,
  parse_eye_color p,
  parse_pid p,
  parse_cid p

let convert_valid_passports ps =
  List.fold_right (fun p acc ->
    try kv_to_passport p :: acc
    with _ -> acc
  ) ps []

let () =
  let input = ref (input_string_list ()) in
  let passports = ref [] in
  let current_passport = ref [] in
  while !input <> [];
  do
    let cur, next = pop !input in
    input := next;
    if cur <> "" then (
      let data = String.split_on_char ' ' cur in
      let kv_data = List.map (fun x ->
        match x with [k;v] -> (k, v) | _ -> raise Not_found
      ) (List.map (String.split_on_char ':') data) 
      in
      current_passport := kv_data @ !current_passport
    ) else (
      passports := !current_passport :: !passports;
      current_passport := []
    )
  done;
  passports := !current_passport :: !passports;
  let valid = convert_valid_passports !passports in
  Printf.printf "%d\n" (List.length valid)

let rec print_list = function 
  | [] -> ()
  | e::l ->
      print_string e ;
      print_string "\n" ;
      print_list l
;;

let read_input =
  let () = print_string "reading from stdin...\n" in
  let n = read_line() |> int_of_string in
  let rec aux xs = function
    | 0 -> xs
    | n -> aux (read_line() :: xs) (n - 1)
  in
    (* List.rev unecessary here *)
    List.rev (aux [] n)
;;

let pad_left ?(c=" ") n s =
  let len = String.length s in
  let rec aux s = function
    | 0 -> s
    | n -> aux (c ^ s) (n - 1)
  in
    aux s (n - len)
;;

let pad_right ?(c=" ") n s =
  let len = String.length s in
  let rec aux s = function
    | 0 -> s
    | n -> aux (s ^ c) (n - 1)
  in
    aux s (n - len)
;;

let join ?(c=",") xs =
  let rec aux s = function
    | [] -> s
    | x :: xs -> aux (s ^ c ^ x) xs
  in
    match xs with
      | [] -> ""
      | h :: t -> aux h t
;;

let bin_of_dec s =
  let rec d2b y bin =
    match y with
      | 0 -> bin
      | _ -> d2b (y/2) ((string_of_int (y mod 2)) ^ bin )
  in
    d2b s ""
;;


let mask_cidr_address n s =
  pad_right ~c:"x" 32 (Str.string_before s n)
;;

let bin_of_string s =
  let [ range; mask  ] = Str.split (Str.regexp "/") s in
  let nums = Str.split (Str.regexp "\\.") range
  in
    nums |>
      List.map (fun s ->
                  (s |>
                     int_of_string |>
                     bin_of_dec |>
                     pad_left ~c:"0" 8)
      ) |>
      join ~c:"" |>
      mask_cidr_address (int_of_string mask)
;;

let string_of_cidr s = s
;;

let strings_to_bin xs =
  let () = print_string "translating to binary form...\n" in
  List.map (bin_of_string) xs
;;

let strings_to_cidr xs = xs
;;

let remove_dupes xs = xs
;;


let () =
  read_input |>
    strings_to_bin |>
    remove_dupes |>
    strings_to_cidr |>
    print_list
;;


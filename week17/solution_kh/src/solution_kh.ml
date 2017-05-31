let rec print_list = function 
  | [] -> ()
  | e::l ->
      print_string e ;
      print_string "\n" ;
      print_list l
;;

let read_input =
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

let join ?(c=",") xs =
  let rec aux s = function
    | [] -> s
    | x :: xs -> aux (s ^ c ^ x) xs
  in
    match xs with
      | [] -> ""
      | h :: t -> aux h t
;;

let cidr_of_string s =
  let [ range; mask  ] = Str.split (Str.regexp "/") s in
  let nums = Str.split (Str.regexp "\\.") range in
  let dec_to_bin_helper = function 1->"1" | 0->"0" in
  let dec_to_bin s =
    let rec d2b y bin =
      match y with
        | 0 -> bin
        | _ -> d2b (y/2) ((dec_to_bin_helper (y mod 2)) ^ bin )
    in
      d2b s ""
  in
    (List.map
      (fun s -> (s |>
                   int_of_string |>
                   dec_to_bin |>
                   pad_left ~c:"0" 8
      ))
      nums) |>
       join ~c:"-"
;;

let string_of_cidr s = s
;;

let strings_to_bin xs =
  List.map (cidr_of_string) xs
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


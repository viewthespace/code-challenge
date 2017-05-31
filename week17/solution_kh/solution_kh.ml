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


let cidr_of_string s = s
;;

let string_of_cidr s = s
;;

let strings_to_bin xs = xs
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


#use "topfind";;
#require "extlib";;
#load "str.cma";;

let map_letter x =
  match Char.lowercase x with
    | 'a' -> 'a'
    | 'b' -> 'x'
    | 'c' -> 'j'
    | 'd' -> 'e'
    | 'e' -> '0'
    | 'f' -> 'u'
    | 'g' -> 'i'
    | 'h' -> 'd'
    | 'i' -> 'c'
    | 'j' -> 'h'
    | 'k' -> 't'
    | 'l' -> 'n'
    | 'm' -> 'm'
    | 'n' -> 'b'
    | 'o' -> 'r'
    | 'p' -> 'l'
    | 'q' -> '0'
    | 'r' -> 'p'
    | 's' -> 'o'
    | 't' -> 'y'
    | 'u' -> 'g'
    | 'v' -> 'k'
    | 'w' -> '0'
    | 'x' -> 'q'
    | 'y' -> 'f'
    | 'z' -> '0'
    | _ -> '0'
;;

let qtod w =
  let d: string = (String.map map_letter w) in
  let p = (Str.regexp ".*0.*") in
    match (Str.string_match p d 0) with
      | true -> ""
      | false -> d
;;

let rec hash_from_list xs hash =
  match xs with
    | x :: xs -> 
        let () = Hashtbl.add hash x true in
          hash_from_list xs hash
    | x :: _ -> 
        let () = Hashtbl.add hash x true in
          hash
    | _ -> hash
;;

let file = "/usr/share/dict/words"
;;

let () =
  let chan = open_in "/usr/share/dict/words" in
  let words = Std.input_list chan in
  let memo = hash_from_list words (Hashtbl.create 235886) in
  let () = List.iter (fun s -> match (qtod s) with
                        | "" -> ()
                        | xs ->
                            match (Hashtbl.mem memo xs) with
                              | true -> print_endline xs
                              | false -> ()) words in
    ()
;;


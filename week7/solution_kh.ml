let n = ref 10;;
let test_xss = ref [
  [3];
  [1;0;1];
  [0;0;1];
  [1;1;1]
]

let min_flip xs =
  max xs
;;

let transform xss =
  List.fold_left (fun xs -> (min_flip xs)) [] xss
;;

let count xss =
  let str_count = transform xss in
    List.fold_left (fun dict x -> let _ = if Hashtbl.mem dict x then
                      let el = Hashtbl.find dict x in
                        el := (!el + 1)
                        else begin
                          Hashtbl.add dict x (ref 1)
                        end
                    in dict
    ) str_count (Hashtbl.create !n)
;;

let dict_max counts =
  Hashtbl.fold (fun _ d max -> if !d > !max then d else max) counts (ref neg_infinity)
;;

let khan_kount xss = dict_max ( count (xss) );;

khan_kount test_xss


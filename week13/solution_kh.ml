let d xs =
  let sum = (List.fold_left (+) 0 xs) / ((List.length xs) - 1) in
    List.map (fun x -> sum - x) xs
;;


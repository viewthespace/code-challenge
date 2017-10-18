let (--) i j => {
  let rec aux n acc => n < i ? acc : aux (n - 1) [n, ...acc];
  aux (j - 1) []
};

let (---) i j => {
  let rec aux n acc => n < i ? acc : aux (n - 1) [n, ...acc];
  aux j []
};

type moveDirection =
  | NNW
  | NNE
  | ENE
  | ESE
  | SSE
  | SSW
  | WSW
  | WNW;

let directions = [NNW, NNE, ENE, ESE, SSE, SSW, WSW, WNW];

type coordinate = (int, int);

let getValidMoves n x y => {
  let aux direction =>
    switch direction {
    | NNW => x - 1 >= 0 && y - 2 >= 0 ? (x - 1, y - 2) : ((-1), (-1))
    | NNE => x + 1 < n && y - 2 >= 0 ? (x + 1, y - 2) : ((-1), (-1))
    | ENE => x + 2 < n && y - 1 >= 0 ? (x + 2, y - 1) : ((-1), (-1))
    | ESE => x + 2 < n && y + 1 < n ? (x + 2, y + 1) : ((-1), (-1))
    | SSE => x + 1 < n && y + 2 < n ? (x + 1, y + 2) : ((-1), (-1))
    | SSW => x - 1 >= 0 && y + 2 < n ? (x - 1, y + 2) : ((-1), (-1))
    | WSW => x - 2 >= 0 && y + 1 < n ? (x - 2, y + 1) : ((-1), (-1))
    | WNW => x - 2 >= 0 && y - 1 >= 0 ? (x - 2, y - 1) : ((-1), (-1))
    };
  let validMapPositions: list coordinate = List.map aux directions;
  List.fold_left
    (fun (agg: list coordinate) (x: coordinate) => fst x == (-1) ? agg : [x, ...agg])
    ([]: list coordinate)
    validMapPositions
};

let willHeDie n k x y => {
  let aux direction =>
    switch k {
    | 0 => 0
    | _ => 0
    };
  let allMoves = List.map aux directions;
  List.fold_left (fun a _ => a) 0. allMoves
};

print_endline (string_of_float (willHeDie 1 2 3 4));

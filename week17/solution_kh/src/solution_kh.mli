(** Week 17

  Your program should emit the minimal covering set of
  the network addresses to remove ones already specified
  by the network addresses.
*)

(** {6 Utility functions} *)

val read_input : string list ;;
(** Reads in lines of text where the first line is n *)

val print_list : string list -> unit ;;
(** Prints out a list of strings *)

val bin_of_dec : int -> string ;;
(** Converts an integer to that number in binary as a string *)

(** {6 Week 17 solution} *)

val bin_of_string : string -> string ;;
(** Translates from binary notation
  to binary notation
*)

val string_of_cidr : string -> string ;;
(** Translates from CIDR notation to binary notation
*)

val strings_to_bin : string list -> string list ;;
(** Translates a list of strings from CIDR notation to
  binary notation
*)

val strings_to_cidr : string list -> string list ;;
(** Translates a list of strings from binary notation to
  CIDR notation
*)

val remove_dupes : string list -> string list ;;
(** Removes the unnecessary subnets from xs *)



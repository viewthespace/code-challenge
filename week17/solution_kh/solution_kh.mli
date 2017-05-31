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

(** {6 Week 17 solution} *)

val cidr_of_string : string list -> string list ;;
(** Translates from [xxxxxxxx.xxxxxxxx.xxxxxxxx.xxxxxxxx] notation
  to CIDR notation
*)

val remove_dupes : string list -> string list ;;
(** Removes the unnecessary subnets from xs *)

val string_of_cidr : string list -> string list ;;
(** Translates from CIDR notation to
 [xxxxxxxx.xxxxxxxx.xxxxxxxx.xxxxxxxx] notation
*)


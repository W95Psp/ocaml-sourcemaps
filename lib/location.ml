open Prelude

type t = { line : int; col : int } [@@deriving eq]

let show { line; col } =
  "(" ^ Int.to_string line ^ ":" ^ Int.to_string col ^ ")"

let pp (fmt : Stdlib.Format.formatter) (s : t) : unit =
  Stdlib.Format.pp_print_string fmt @@ show s

let default = { line = 0; col = 0 }
let plus_cols x cols = { x with col = x.col + cols }
let op ( + ) x y = { line = x.line + y.line; col = x.col + y.col }
let ( + ) = op ( + )
let ( - ) = op ( - )

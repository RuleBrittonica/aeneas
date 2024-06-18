(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [arrays]: templates for the decreases clauses *)
module Arrays.Clauses.Template
open Primitives
open Arrays.Types

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [arrays::sum]: decreases clause
    Source: 'tests/src/arrays.rs', lines 247:4-253:1 *)
unfold
let sum_loop_decreases (s : slice u32) (sum1 : u32) (i : usize) : nat =
  admit ()

(** [arrays::sum2]: decreases clause
    Source: 'tests/src/arrays.rs', lines 258:4-264:1 *)
unfold
let sum2_loop_decreases (s : slice u32) (s2 : slice u32) (sum1 : u32)
  (i : usize) : nat =
  admit ()

(** [arrays::zero_slice]: decreases clause
    Source: 'tests/src/arrays.rs', lines 308:4-313:1 *)
unfold
let zero_slice_loop_decreases (a : slice u8) (i : usize) (len : usize) : nat =
  admit ()

(** [arrays::iter_mut_slice]: decreases clause
    Source: 'tests/src/arrays.rs', lines 317:4-321:1 *)
unfold
let iter_mut_slice_loop_decreases (len : usize) (i : usize) : nat = admit ()

(** [arrays::sum_mut_slice]: decreases clause
    Source: 'tests/src/arrays.rs', lines 325:4-331:1 *)
unfold
let sum_mut_slice_loop_decreases (a : slice u32) (i : usize) (s : u32) : nat =
  admit ()


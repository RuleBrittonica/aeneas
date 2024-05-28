(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [issue_194_recursive_struct_projector] *)
module Issue194RecursiveStructProjector
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [issue_194_recursive_struct_projector::AVLNode]
    Source: 'tests/src/issue-194-recursive-struct-projector.rs', lines 2:0-2:17 *)
type aVLNode_t (t : Type0) =
{
  value : t; left : option (aVLNode_t t); right : option (aVLNode_t t);
}

(** [issue_194_recursive_struct_projector::get_val]:
    Source: 'tests/src/issue-194-recursive-struct-projector.rs', lines 10:0-10:33 *)
let get_val (t : Type0) (x : aVLNode_t t) : result t =
  Ok x.value

(** [issue_194_recursive_struct_projector::get_left]:
    Source: 'tests/src/issue-194-recursive-struct-projector.rs', lines 14:0-14:43 *)
let get_left (t : Type0) (x : aVLNode_t t) : result (option (aVLNode_t t)) =
  Ok x.left


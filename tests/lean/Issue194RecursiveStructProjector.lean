-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [issue_194_recursive_struct_projector]
import Base
open Primitives

namespace issue_194_recursive_struct_projector

/- [issue_194_recursive_struct_projector::AVLNode]
   Source: 'tests/src/issue-194-recursive-struct-projector.rs', lines 2:0-2:17 -/
inductive AVLNode (T : Type) :=
| mk : T → Option (AVLNode T) → Option (AVLNode T) → AVLNode T

@[simp, reducible]
def AVLNode.value {T : Type} (x : AVLNode T) :=
  match x with | AVLNode.mk x1 _ _ => x1

@[simp, reducible]
def AVLNode.left {T : Type} (x : AVLNode T) :=
  match x with | AVLNode.mk _ x1 _ => x1

@[simp, reducible]
def AVLNode.right {T : Type} (x : AVLNode T) :=
  match x with | AVLNode.mk _ _ x1 => x1

/- [issue_194_recursive_struct_projector::get_val]:
   Source: 'tests/src/issue-194-recursive-struct-projector.rs', lines 10:0-10:33 -/
def get_val (T : Type) (x : AVLNode T) : Result T :=
  Result.ok x.value

/- [issue_194_recursive_struct_projector::get_left]:
   Source: 'tests/src/issue-194-recursive-struct-projector.rs', lines 14:0-14:43 -/
def get_left (T : Type) (x : AVLNode T) : Result (Option (AVLNode T)) :=
  Result.ok x.left

end issue_194_recursive_struct_projector

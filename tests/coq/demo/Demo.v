(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [demo] *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module Demo.

(** [demo::choose]:
    Source: 'tests/src/demo.rs', lines 7:0-13:1 *)
Definition choose
  {T : Type} (b : bool) (x : T) (y : T) : result (T * (T -> (T * T))) :=
  if b
  then let back := fun (ret : T) => (ret, y) in Ok (x, back)
  else let back := fun (ret : T) => (x, ret) in Ok (y, back)
.

(** [demo::mul2_add1]:
    Source: 'tests/src/demo.rs', lines 15:0-17:1 *)
Definition mul2_add1 (x : u32) : result u32 :=
  i <- u32_add x x; u32_add i 1%u32
.

(** [demo::use_mul2_add1]:
    Source: 'tests/src/demo.rs', lines 19:0-21:1 *)
Definition use_mul2_add1 (x : u32) (y : u32) : result u32 :=
  i <- mul2_add1 x; u32_add i y
.

(** [demo::incr]:
    Source: 'tests/src/demo.rs', lines 23:0-25:1 *)
Definition incr (x : u32) : result u32 :=
  u32_add x 1%u32.

(** [demo::use_incr]:
    Source: 'tests/src/demo.rs', lines 27:0-32:1 *)
Definition use_incr : result unit :=
  x <- incr 0%u32; x1 <- incr x; _ <- incr x1; Ok tt
.

(** [demo::CList]
    Source: 'tests/src/demo.rs', lines 36:0-39:1 *)
Inductive CList_t (T : Type) :=
| CList_CCons : T -> CList_t T -> CList_t T
| CList_CNil : CList_t T
.

Arguments CList_CCons { _ }.
Arguments CList_CNil { _ }.

(** [demo::list_nth]:
    Source: 'tests/src/demo.rs', lines 41:0-54:1 *)
Fixpoint list_nth {T : Type} (n : nat) (l : CList_t T) (i : u32) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n1 =>
    match l with
    | CList_CCons x tl =>
      if i s= 0%u32 then Ok x else (i1 <- u32_sub i 1%u32; list_nth n1 tl i1)
    | CList_CNil => Fail_ Failure
    end
  end
.

(** [demo::list_nth1]: loop 0:
    Source: 'tests/src/demo.rs', lines 57:4-65:1 *)
Fixpoint list_nth1_loop
  {T : Type} (n : nat) (l : CList_t T) (i : u32) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n1 =>
    match l with
    | CList_CCons x tl =>
      if i s= 0%u32
      then Ok x
      else (i1 <- u32_sub i 1%u32; list_nth1_loop n1 tl i1)
    | CList_CNil => Fail_ Failure
    end
  end
.

(** [demo::list_nth1]:
    Source: 'tests/src/demo.rs', lines 56:0-65:1 *)
Definition list_nth1
  {T : Type} (n : nat) (l : CList_t T) (i : u32) : result T :=
  list_nth1_loop n l i
.

(** [demo::list_nth_mut]:
    Source: 'tests/src/demo.rs', lines 67:0-80:1 *)
Fixpoint list_nth_mut
  {T : Type} (n : nat) (l : CList_t T) (i : u32) :
  result (T * (T -> CList_t T))
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n1 =>
    match l with
    | CList_CCons x tl =>
      if i s= 0%u32
      then let back := fun (ret : T) => CList_CCons ret tl in Ok (x, back)
      else (
        i1 <- u32_sub i 1%u32;
        p <- list_nth_mut n1 tl i1;
        let (t, list_nth_mut_back) := p in
        let back :=
          fun (ret : T) =>
            let tl1 := list_nth_mut_back ret in CList_CCons x tl1 in
        Ok (t, back))
    | CList_CNil => Fail_ Failure
    end
  end
.

(** [demo::i32_id]:
    Source: 'tests/src/demo.rs', lines 82:0-88:1 *)
Fixpoint i32_id (n : nat) (i : i32) : result i32 :=
  match n with
  | O => Fail_ OutOfFuel
  | S n1 =>
    if i s= 0%i32
    then Ok 0%i32
    else (i1 <- i32_sub i 1%i32; i2 <- i32_id n1 i1; i32_add i2 1%i32)
  end
.

(** [demo::list_tail]:
    Source: 'tests/src/demo.rs', lines 90:0-95:1 *)
Fixpoint list_tail
  {T : Type} (n : nat) (l : CList_t T) :
  result ((CList_t T) * (CList_t T -> CList_t T))
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n1 =>
    match l with
    | CList_CCons t tl =>
      p <- list_tail n1 tl;
      let (c, list_tail_back) := p in
      let back :=
        fun (ret : CList_t T) =>
          let tl1 := list_tail_back ret in CList_CCons t tl1 in
      Ok (c, back)
    | CList_CNil => Ok (CList_CNil, fun (ret : CList_t T) => ret)
    end
  end
.

(** Trait declaration: [demo::Counter]
    Source: 'tests/src/demo.rs', lines 99:0-101:1 *)
Record Counter_t (Self : Type) := mkCounter_t {
  Counter_t_incr : Self -> result (usize * Self);
}.

Arguments mkCounter_t { _ }.
Arguments Counter_t_incr { _ } _.

(** [demo::{demo::Counter for usize}::incr]:
    Source: 'tests/src/demo.rs', lines 104:4-108:5 *)
Definition counterUsize_incr (self : usize) : result (usize * usize) :=
  self1 <- usize_add self 1%usize; Ok (self, self1)
.

(** Trait implementation: [demo::{demo::Counter for usize}]
    Source: 'tests/src/demo.rs', lines 103:0-109:1 *)
Definition CounterUsize : Counter_t usize := {|
  Counter_t_incr := counterUsize_incr;
|}.

(** [demo::use_counter]:
    Source: 'tests/src/demo.rs', lines 111:0-113:1 *)
Definition use_counter
  {T : Type} (counterInst : Counter_t T) (cnt : T) : result (usize * T) :=
  counterInst.(Counter_t_incr) cnt
.

End Demo.

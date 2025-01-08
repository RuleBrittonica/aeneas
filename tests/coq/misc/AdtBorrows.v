(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [adt_borrows] *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module AdtBorrows.

(** [adt_borrows::SharedWrapper]
    Source: 'tests/src/adt-borrows.rs', lines 7:0-7:35 *)
Definition SharedWrapper_t (T : Type) : Type := T.

(** [adt_borrows::{adt_borrows::SharedWrapper<'a, T>}::create]:
    Source: 'tests/src/adt-borrows.rs', lines 10:4-12:5 *)
Definition sharedWrapper_create
  {T : Type} (x : T) : result (SharedWrapper_t T) :=
  Ok x
.

(** [adt_borrows::{adt_borrows::SharedWrapper<'a, T>}::unwrap]:
    Source: 'tests/src/adt-borrows.rs', lines 14:4-16:5 *)
Definition sharedWrapper_unwrap
  {T : Type} (self : SharedWrapper_t T) : result T :=
  Ok self
.

(** [adt_borrows::use_shared_wrapper]:
    Source: 'tests/src/adt-borrows.rs', lines 19:0-24:1 *)
Definition use_shared_wrapper : result unit :=
  w <- sharedWrapper_create 0%i32;
  p <- sharedWrapper_unwrap w;
  massert (0%i32 s= p)
.

(** [adt_borrows::SharedWrapper1]
    Source: 'tests/src/adt-borrows.rs', lines 26:0-28:1 *)
Record SharedWrapper1_t (T : Type) :=
mkSharedWrapper1_t {
  sharedWrapper1_x : T;
}
.

Arguments mkSharedWrapper1_t { _ }.
Arguments sharedWrapper1_x { _ }.

(** [adt_borrows::{adt_borrows::SharedWrapper1<'a, T>}#1::create]:
    Source: 'tests/src/adt-borrows.rs', lines 31:4-33:5 *)
Definition sharedWrapper1_create
  {T : Type} (x : T) : result (SharedWrapper1_t T) :=
  Ok {| sharedWrapper1_x := x |}
.

(** [adt_borrows::{adt_borrows::SharedWrapper1<'a, T>}#1::unwrap]:
    Source: 'tests/src/adt-borrows.rs', lines 35:4-37:5 *)
Definition sharedWrapper1_unwrap
  {T : Type} (self : SharedWrapper1_t T) : result T :=
  Ok self.(sharedWrapper1_x)
.

(** [adt_borrows::use_shared_wrapper1]:
    Source: 'tests/src/adt-borrows.rs', lines 40:0-45:1 *)
Definition use_shared_wrapper1 : result unit :=
  w <- sharedWrapper1_create 0%i32;
  p <- sharedWrapper1_unwrap w;
  massert (0%i32 s= p)
.

(** [adt_borrows::SharedWrapper2]
    Source: 'tests/src/adt-borrows.rs', lines 47:0-50:1 *)
Record SharedWrapper2_t (T : Type) :=
mkSharedWrapper2_t {
  sharedWrapper2_x : T; sharedWrapper2_y : T;
}
.

Arguments mkSharedWrapper2_t { _ }.
Arguments sharedWrapper2_x { _ }.
Arguments sharedWrapper2_y { _ }.

(** [adt_borrows::{adt_borrows::SharedWrapper2<'a, 'b, T>}#2::create]:
    Source: 'tests/src/adt-borrows.rs', lines 53:4-55:5 *)
Definition sharedWrapper2_create
  {T : Type} (x : T) (y : T) : result (SharedWrapper2_t T) :=
  Ok {| sharedWrapper2_x := x; sharedWrapper2_y := y |}
.

(** [adt_borrows::{adt_borrows::SharedWrapper2<'a, 'b, T>}#2::unwrap]:
    Source: 'tests/src/adt-borrows.rs', lines 57:4-59:5 *)
Definition sharedWrapper2_unwrap
  {T : Type} (self : SharedWrapper2_t T) : result (T * T) :=
  Ok (self.(sharedWrapper2_x), self.(sharedWrapper2_y))
.

(** [adt_borrows::use_shared_wrapper2]:
    Source: 'tests/src/adt-borrows.rs', lines 62:0-69:1 *)
Definition use_shared_wrapper2 : result unit :=
  w <- sharedWrapper2_create 0%i32 1%i32;
  p <- sharedWrapper2_unwrap w;
  let (px, py) := p in
  _ <- massert (0%i32 s= px);
  massert (1%i32 s= py)
.

(** [adt_borrows::MutWrapper]
    Source: 'tests/src/adt-borrows.rs', lines 71:0-71:36 *)
Definition MutWrapper_t (T : Type) : Type := T.

(** [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#3::create]:
    Source: 'tests/src/adt-borrows.rs', lines 74:4-76:5 *)
Definition mutWrapper_create
  {T : Type} (x : T) : result ((MutWrapper_t T) * (MutWrapper_t T -> T)) :=
  Ok (x, fun (ret : MutWrapper_t T) => ret)
.

(** [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#3::unwrap]:
    Source: 'tests/src/adt-borrows.rs', lines 78:4-80:5 *)
Definition mutWrapper_unwrap
  {T : Type} (self : MutWrapper_t T) : result (T * (T -> MutWrapper_t T)) :=
  let back := fun (ret : T) => ret in Ok (self, back)
.

(** [adt_borrows::{adt_borrows::MutWrapper<'a, T>}#3::id]:
    Source: 'tests/src/adt-borrows.rs', lines 82:4-84:5 *)
Definition mutWrapper_id
  {T : Type} (self : MutWrapper_t T) :
  result ((MutWrapper_t T) * (MutWrapper_t T -> MutWrapper_t T))
  :=
  let back := fun (ret : MutWrapper_t T) => ret in Ok (self, back)
.

(** [adt_borrows::use_mut_wrapper]:
    Source: 'tests/src/adt-borrows.rs', lines 87:0-93:1 *)
Definition use_mut_wrapper : result unit :=
  p <- mutWrapper_create 0%i32;
  let (w, create_back) := p in
  p1 <- mutWrapper_unwrap w;
  let (p2, unwrap_back) := p1 in
  p3 <- i32_add p2 1%i32;
  let x := create_back (unwrap_back p3) in
  massert (x s= 1%i32)
.

(** [adt_borrows::use_mut_wrapper_id]:
    Source: 'tests/src/adt-borrows.rs', lines 95:0-97:1 *)
Definition use_mut_wrapper_id
  {T : Type} (x : MutWrapper_t T) :
  result ((MutWrapper_t T) * (MutWrapper_t T -> MutWrapper_t T))
  :=
  p <- mutWrapper_id x;
  let (mw, id_back) := p in
  let back := fun (ret : MutWrapper_t T) => id_back ret in
  Ok (mw, back)
.

(** [adt_borrows::MutWrapper1]
    Source: 'tests/src/adt-borrows.rs', lines 99:0-101:1 *)
Record MutWrapper1_t (T : Type) := mkMutWrapper1_t { mutWrapper1_x : T; }.

Arguments mkMutWrapper1_t { _ }.
Arguments mutWrapper1_x { _ }.

(** [adt_borrows::{adt_borrows::MutWrapper1<'a, T>}#4::create]:
    Source: 'tests/src/adt-borrows.rs', lines 104:4-106:5 *)
Definition mutWrapper1_create
  {T : Type} (x : T) : result ((MutWrapper1_t T) * (MutWrapper1_t T -> T)) :=
  let back := fun (ret : MutWrapper1_t T) => ret.(mutWrapper1_x) in
  Ok ({| mutWrapper1_x := x |}, back)
.

(** [adt_borrows::{adt_borrows::MutWrapper1<'a, T>}#4::unwrap]:
    Source: 'tests/src/adt-borrows.rs', lines 108:4-110:5 *)
Definition mutWrapper1_unwrap
  {T : Type} (self : MutWrapper1_t T) : result (T * (T -> MutWrapper1_t T)) :=
  let back := fun (ret : T) => {| mutWrapper1_x := ret |} in
  Ok (self.(mutWrapper1_x), back)
.

(** [adt_borrows::{adt_borrows::MutWrapper1<'a, T>}#4::id]:
    Source: 'tests/src/adt-borrows.rs', lines 112:4-114:5 *)
Definition mutWrapper1_id
  {T : Type} (self : MutWrapper1_t T) :
  result ((MutWrapper1_t T) * (MutWrapper1_t T -> MutWrapper1_t T))
  :=
  Ok (self, fun (ret : MutWrapper1_t T) => ret)
.

(** [adt_borrows::use_mut_wrapper1]:
    Source: 'tests/src/adt-borrows.rs', lines 117:0-123:1 *)
Definition use_mut_wrapper1 : result unit :=
  p <- mutWrapper1_create 0%i32;
  let (w, create_back) := p in
  p1 <- mutWrapper1_unwrap w;
  let (p2, unwrap_back) := p1 in
  p3 <- i32_add p2 1%i32;
  let x := create_back (unwrap_back p3) in
  massert (x s= 1%i32)
.

(** [adt_borrows::use_mut_wrapper1_id]:
    Source: 'tests/src/adt-borrows.rs', lines 125:0-127:1 *)
Definition use_mut_wrapper1_id
  {T : Type} (x : MutWrapper1_t T) :
  result ((MutWrapper1_t T) * (MutWrapper1_t T -> MutWrapper1_t T))
  :=
  p <- mutWrapper1_id x;
  let (mw, id_back) := p in
  let back :=
    fun (ret : MutWrapper1_t T) =>
      id_back {| mutWrapper1_x := ret.(mutWrapper1_x) |} in
  Ok (mw, back)
.

(** [adt_borrows::MutWrapper2]
    Source: 'tests/src/adt-borrows.rs', lines 129:0-132:1 *)
Record MutWrapper2_t (T : Type) :=
mkMutWrapper2_t {
  mutWrapper2_x : T; mutWrapper2_y : T;
}
.

Arguments mkMutWrapper2_t { _ }.
Arguments mutWrapper2_x { _ }.
Arguments mutWrapper2_y { _ }.

(** [adt_borrows::{adt_borrows::MutWrapper2<'a, 'b, T>}#5::create]:
    Source: 'tests/src/adt-borrows.rs', lines 135:4-137:5 *)
Definition mutWrapper2_create
  {T : Type} (x : T) (y : T) :
  result ((MutWrapper2_t T) * (MutWrapper2_t T -> T) * (MutWrapper2_t T -> T))
  :=
  let back'a := fun (ret : MutWrapper2_t T) => ret.(mutWrapper2_x) in
  let back'b := fun (ret : MutWrapper2_t T) => ret.(mutWrapper2_y) in
  Ok ({| mutWrapper2_x := x; mutWrapper2_y := y |}, back'a, back'b)
.

(** [adt_borrows::{adt_borrows::MutWrapper2<'a, 'b, T>}#5::unwrap]:
    Source: 'tests/src/adt-borrows.rs', lines 139:4-141:5 *)
Definition mutWrapper2_unwrap
  {T : Type} (self : MutWrapper2_t T) :
  result ((T * T) * (T -> MutWrapper2_t T) * (T -> MutWrapper2_t T))
  :=
  let back'a :=
    fun (ret : T) =>
      {| mutWrapper2_x := ret; mutWrapper2_y := self.(mutWrapper2_y) |} in
  let back'b :=
    fun (ret : T) =>
      {| mutWrapper2_x := self.(mutWrapper2_x); mutWrapper2_y := ret |} in
  Ok ((self.(mutWrapper2_x), self.(mutWrapper2_y)), back'a, back'b)
.

(** [adt_borrows::{adt_borrows::MutWrapper2<'a, 'b, T>}#5::id]:
    Source: 'tests/src/adt-borrows.rs', lines 143:4-145:5 *)
Definition mutWrapper2_id
  {T : Type} (self : MutWrapper2_t T) :
  result ((MutWrapper2_t T) * (MutWrapper2_t T -> MutWrapper2_t T) *
    (MutWrapper2_t T -> MutWrapper2_t T))
  :=
  let back'a :=
    fun (ret : MutWrapper2_t T) =>
      {|
        mutWrapper2_x := ret.(mutWrapper2_x);
        mutWrapper2_y := self.(mutWrapper2_y)
      |} in
  let back'b :=
    fun (ret : MutWrapper2_t T) =>
      {|
        mutWrapper2_x := self.(mutWrapper2_x);
        mutWrapper2_y := ret.(mutWrapper2_y)
      |} in
  Ok (self, back'a, back'b)
.

(** [adt_borrows::use_mut_wrapper2]:
    Source: 'tests/src/adt-borrows.rs', lines 148:0-157:1 *)
Definition use_mut_wrapper2 : result unit :=
  t <- mutWrapper2_create 0%i32 10%i32;
  let '(w, create_back, create_back1) := t in
  t1 <- mutWrapper2_unwrap w;
  let '(p, unwrap_back, unwrap_back1) := t1 in
  let (px, py) := p in
  px1 <- i32_add px 1%i32;
  py1 <- i32_add py 1%i32;
  let x :=
    create_back
      {|
        mutWrapper2_x := (unwrap_back px1).(mutWrapper2_x);
        mutWrapper2_y := w.(mutWrapper2_y)
      |} in
  _ <- massert (x s= 1%i32);
  let y :=
    create_back1
      {|
        mutWrapper2_x := w.(mutWrapper2_x);
        mutWrapper2_y := (unwrap_back1 py1).(mutWrapper2_y)
      |} in
  massert (y s= 11%i32)
.

(** [adt_borrows::use_mut_wrapper2_id]:
    Source: 'tests/src/adt-borrows.rs', lines 159:0-161:1 *)
Definition use_mut_wrapper2_id
  {T : Type} (x : MutWrapper2_t T) :
  result ((MutWrapper2_t T) * (MutWrapper2_t T -> MutWrapper2_t T) *
    (MutWrapper2_t T -> MutWrapper2_t T))
  :=
  t <- mutWrapper2_id x;
  let '(mw, id_back, id_back1) := t in
  let back'a :=
    fun (ret : MutWrapper2_t T) =>
      {|
        mutWrapper2_x :=
          (id_back
             {|
               mutWrapper2_x := ret.(mutWrapper2_x);
               mutWrapper2_y := mw.(mutWrapper2_y)
             |}).(mutWrapper2_x);
        mutWrapper2_y := x.(mutWrapper2_y)
      |} in
  let back'b :=
    fun (ret : MutWrapper2_t T) =>
      {|
        mutWrapper2_x := x.(mutWrapper2_x);
        mutWrapper2_y :=
          (id_back1
             {|
               mutWrapper2_x := mw.(mutWrapper2_x);
               mutWrapper2_y := ret.(mutWrapper2_y)
             |}).(mutWrapper2_y)
      |} in
  Ok (mw, back'a, back'b)
.

(** [adt_borrows::array_shared_borrow]:
    Source: 'tests/src/adt-borrows.rs', lines 170:0-172:1 *)
Definition array_shared_borrow
  {N : usize} (x : array u32 N) : result (array u32 N) :=
  Ok x
.

(** [adt_borrows::array_mut_borrow]:
    Source: 'tests/src/adt-borrows.rs', lines 174:0-176:1 *)
Definition array_mut_borrow
  {N : usize} (x : array u32 N) :
  result ((array u32 N) * (array u32 N -> array u32 N))
  :=
  Ok (x, fun (ret : array u32 N) => ret)
.

(** [adt_borrows::use_array_mut_borrow1]:
    Source: 'tests/src/adt-borrows.rs', lines 178:0-180:1 *)
Definition use_array_mut_borrow1
  {N : usize} (x : array u32 N) :
  result ((array u32 N) * (array u32 N -> array u32 N))
  :=
  array_mut_borrow x
.

(** [adt_borrows::use_array_mut_borrow2]:
    Source: 'tests/src/adt-borrows.rs', lines 182:0-185:1 *)
Definition use_array_mut_borrow2
  {N : usize} (x : array u32 N) :
  result ((array u32 N) * (array u32 N -> array u32 N))
  :=
  p <- array_mut_borrow x;
  let (x1, array_mut_borrow_back) := p in
  p1 <- array_mut_borrow x1;
  let (a, array_mut_borrow_back1) := p1 in
  let back :=
    fun (ret : array u32 N) =>
      let x2 := array_mut_borrow_back1 ret in array_mut_borrow_back x2 in
  Ok (a, back)
.

(** [adt_borrows::boxed_slice_shared_borrow]:
    Source: 'tests/src/adt-borrows.rs', lines 187:0-189:1 *)
Definition boxed_slice_shared_borrow (x : slice u32) : result (slice u32) :=
  Ok x
.

(** [adt_borrows::boxed_slice_mut_borrow]:
    Source: 'tests/src/adt-borrows.rs', lines 191:0-193:1 *)
Definition boxed_slice_mut_borrow
  (x : slice u32) : result ((slice u32) * (slice u32 -> slice u32)) :=
  Ok (x, fun (ret : slice u32) => ret)
.

(** [adt_borrows::use_boxed_slice_mut_borrow1]:
    Source: 'tests/src/adt-borrows.rs', lines 195:0-197:1 *)
Definition use_boxed_slice_mut_borrow1
  (x : slice u32) : result ((slice u32) * (slice u32 -> slice u32)) :=
  boxed_slice_mut_borrow x
.

(** [adt_borrows::use_boxed_slice_mut_borrow2]:
    Source: 'tests/src/adt-borrows.rs', lines 199:0-202:1 *)
Definition use_boxed_slice_mut_borrow2
  (x : slice u32) : result ((slice u32) * (slice u32 -> slice u32)) :=
  p <- boxed_slice_mut_borrow x;
  let (x1, boxed_slice_mut_borrow_back) := p in
  p1 <- boxed_slice_mut_borrow x1;
  let (s, boxed_slice_mut_borrow_back1) := p1 in
  let back :=
    fun (ret : slice u32) =>
      let s1 := boxed_slice_mut_borrow_back1 ret in
      boxed_slice_mut_borrow_back s1 in
  Ok (s, back)
.

(** [adt_borrows::SharedList]
    Source: 'tests/src/adt-borrows.rs', lines 207:0-210:1 *)
Inductive SharedList_t (T : Type) :=
| SharedList_Nil : SharedList_t T
| SharedList_Cons : T -> SharedList_t T -> SharedList_t T
.

Arguments SharedList_Nil { _ }.
Arguments SharedList_Cons { _ }.

(** [adt_borrows::{adt_borrows::SharedList<'a, T>}#6::push]:
    Source: 'tests/src/adt-borrows.rs', lines 214:4-216:5 *)
Definition sharedList_push
  {T : Type} (self : SharedList_t T) (x : T) : result (SharedList_t T) :=
  Ok (SharedList_Cons x self)
.

(** [adt_borrows::{adt_borrows::SharedList<'a, T>}#6::pop]:
    Source: 'tests/src/adt-borrows.rs', lines 218:4-224:5 *)
Definition sharedList_pop
  {T : Type} (self : SharedList_t T) : result (T * (SharedList_t T)) :=
  match self with
  | SharedList_Nil => Fail_ Failure
  | SharedList_Cons hd tl => Ok (hd, tl)
  end
.

(** [adt_borrows::MutList]
    Source: 'tests/src/adt-borrows.rs', lines 227:0-230:1 *)
Inductive MutList_t (T : Type) :=
| MutList_Nil : MutList_t T
| MutList_Cons : T -> MutList_t T -> MutList_t T
.

Arguments MutList_Nil { _ }.
Arguments MutList_Cons { _ }.

(** [adt_borrows::{adt_borrows::MutList<'a, T>}#7::push]:
    Source: 'tests/src/adt-borrows.rs', lines 234:4-236:5 *)
Definition mutList_push
  {T : Type} (self : MutList_t T) (x : T) :
  result ((MutList_t T) * (MutList_t T -> ((MutList_t T) * T)))
  :=
  let back :=
    fun (ret : MutList_t T) =>
      let (x1, ml) :=
        match ret with | MutList_Cons t ml1 => (t, ml1) | _ => (x, self) end in
      (ml, x1) in
  Ok (MutList_Cons x self, back)
.

(** [adt_borrows::{adt_borrows::MutList<'a, T>}#7::pop]:
    Source: 'tests/src/adt-borrows.rs', lines 238:4-244:5 *)
Definition mutList_pop
  {T : Type} (self : MutList_t T) :
  result ((T * (MutList_t T)) * ((T * (MutList_t T)) -> MutList_t T))
  :=
  match self with
  | MutList_Nil => Fail_ Failure
  | MutList_Cons hd tl =>
    let back :=
      fun (ret : (T * (MutList_t T))) =>
        let (t, ml) := ret in MutList_Cons t ml in
    Ok ((hd, tl), back)
  end
.

(** [adt_borrows::wrap_shared_in_option]:
    Source: 'tests/src/adt-borrows.rs', lines 247:0-249:1 *)
Definition wrap_shared_in_option {T : Type} (x : T) : result (option T) :=
  Ok (Some x)
.

(** [adt_borrows::wrap_mut_in_option]:
    Source: 'tests/src/adt-borrows.rs', lines 251:0-253:1 *)
Definition wrap_mut_in_option
  {T : Type} (x : T) : result ((option T) * (option T -> T)) :=
  let back := fun (ret : option T) => match ret with | Some t => t | _ => x end
    in
  Ok (Some x, back)
.

(** [adt_borrows::List]
    Source: 'tests/src/adt-borrows.rs', lines 255:0-258:1 *)
Inductive List_t (T : Type) :=
| List_Cons : T -> List_t T -> List_t T
| List_Nil : List_t T
.

Arguments List_Cons { _ }.
Arguments List_Nil { _ }.

(** [adt_borrows::nth_shared]: loop 0:
    Source: 'tests/src/adt-borrows.rs', lines 261:4-270:1 *)
Fixpoint nth_shared_loop
  {T : Type} (ls : List_t T) (i : u32) : result (option T) :=
  match ls with
  | List_Cons x tl =>
    if i s= 0%u32
    then Ok (Some x)
    else (i1 <- u32_sub i 1%u32; nth_shared_loop tl i1)
  | List_Nil => Ok None
  end
.

(** [adt_borrows::nth_shared]:
    Source: 'tests/src/adt-borrows.rs', lines 260:0-270:1 *)
Definition nth_shared
  {T : Type} (ls : List_t T) (i : u32) : result (option T) :=
  nth_shared_loop ls i
.

(** [adt_borrows::nth_mut]: loop 0:
    Source: 'tests/src/adt-borrows.rs', lines 273:4-282:1 *)
Fixpoint nth_mut_loop
  {T : Type} (ls : List_t T) (i : u32) :
  result ((option T) * (option T -> List_t T))
  :=
  match ls with
  | List_Cons x tl =>
    if i s= 0%u32
    then
      let back :=
        fun (ret : option T) =>
          let t := match ret with | Some t1 => t1 | _ => x end in
          List_Cons t tl in
      Ok (Some x, back)
    else (
      i1 <- u32_sub i 1%u32;
      p <- nth_mut_loop tl i1;
      let (o, back) := p in
      let back1 :=
        fun (ret : option T) => let tl1 := back ret in List_Cons x tl1 in
      Ok (o, back1))
  | List_Nil => let back := fun (ret : option T) => List_Nil in Ok (None, back)
  end
.

(** [adt_borrows::nth_mut]:
    Source: 'tests/src/adt-borrows.rs', lines 272:0-282:1 *)
Definition nth_mut
  {T : Type} (ls : List_t T) (i : u32) :
  result ((option T) * (option T -> List_t T))
  :=
  nth_mut_loop ls i
.

(** [adt_borrows::update_array_mut_borrow]:
    Source: 'tests/src/adt-borrows.rs', lines 284:0-286:1 *)
Definition update_array_mut_borrow
  (a : array u32 32%usize) :
  result ((array u32 32%usize) * (array u32 32%usize -> array u32 32%usize))
  :=
  Ok (a, fun (ret : array u32 32%usize) => ret)
.

(** [adt_borrows::array_mut_borrow_loop1]: loop 0:
    Source: 'tests/src/adt-borrows.rs', lines 289:4-291:5 *)
Fixpoint array_mut_borrow_loop1_loop
  (b : bool) (a : array u32 32%usize) : result (array u32 32%usize) :=
  if b
  then (
    p <- update_array_mut_borrow a;
    let (a1, update_array_mut_borrow_back) := p in
    a2 <- array_mut_borrow_loop1_loop true a1;
    Ok (update_array_mut_borrow_back a2))
  else Ok a
.

(** [adt_borrows::array_mut_borrow_loop1]:
    Source: 'tests/src/adt-borrows.rs', lines 288:0-292:1 *)
Definition array_mut_borrow_loop1
  (b : bool) (a : array u32 32%usize) : result (array u32 32%usize) :=
  array_mut_borrow_loop1_loop b a
.

(** [adt_borrows::array_mut_borrow_loop2]: loop 0:
    Source: 'tests/src/adt-borrows.rs', lines 295:4-297:5 *)
Fixpoint array_mut_borrow_loop2_loop
  (b : bool) (a : array u32 32%usize) :
  result ((array u32 32%usize) * (array u32 32%usize -> array u32 32%usize))
  :=
  if b
  then (
    p <- update_array_mut_borrow a;
    let (a1, update_array_mut_borrow_back) := p in
    p1 <- array_mut_borrow_loop2_loop true a1;
    let (a2, back) := p1 in
    let back1 :=
      fun (ret : array u32 32%usize) =>
        let a3 := back ret in update_array_mut_borrow_back a3 in
    Ok (a2, back1))
  else Ok (a, fun (ret : array u32 32%usize) => ret)
.

(** [adt_borrows::array_mut_borrow_loop2]:
    Source: 'tests/src/adt-borrows.rs', lines 294:0-299:1 *)
Definition array_mut_borrow_loop2
  (b : bool) (a : array u32 32%usize) :
  result ((array u32 32%usize) * (array u32 32%usize -> array u32 32%usize))
  :=
  array_mut_borrow_loop2_loop b a
.

(** [adt_borrows::copy_shared_array]:
    Source: 'tests/src/adt-borrows.rs', lines 301:0-303:1 *)
Definition copy_shared_array
  (a : array u32 32%usize) : result (array u32 32%usize) :=
  Ok a
.

(** [adt_borrows::array_shared_borrow_loop1]: loop 0:
    Source: 'tests/src/adt-borrows.rs', lines 306:4-308:5 *)
Fixpoint array_shared_borrow_loop1_loop
  (b : bool) (a : array u32 32%usize) : result unit :=
  if b
  then (a1 <- copy_shared_array a; array_shared_borrow_loop1_loop true a1)
  else Ok tt
.

(** [adt_borrows::array_shared_borrow_loop1]:
    Source: 'tests/src/adt-borrows.rs', lines 305:0-309:1 *)
Definition array_shared_borrow_loop1
  (b : bool) (a : array u32 32%usize) : result unit :=
  array_shared_borrow_loop1_loop b a
.

(** [adt_borrows::array_shared_borrow_loop2]: loop 0:
    Source: 'tests/src/adt-borrows.rs', lines 312:4-314:5 *)
Fixpoint array_shared_borrow_loop2_loop
  (b : bool) (a : array u32 32%usize) : result (array u32 32%usize) :=
  if b
  then (a1 <- copy_shared_array a; array_shared_borrow_loop2_loop true a1)
  else Ok a
.

(** [adt_borrows::array_shared_borrow_loop2]:
    Source: 'tests/src/adt-borrows.rs', lines 311:0-316:1 *)
Definition array_shared_borrow_loop2
  (b : bool) (a : array u32 32%usize) : result (array u32 32%usize) :=
  array_shared_borrow_loop2_loop b a
.

End AdtBorrows.

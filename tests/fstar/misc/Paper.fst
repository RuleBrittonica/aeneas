(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [paper] *)
module Paper
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [paper::ref_incr]:
    Source: 'tests/src/paper.rs', lines 7:0-9:1 *)
let ref_incr (x : i32) : result i32 =
  i32_add x 1

(** [paper::test_incr]:
    Source: 'tests/src/paper.rs', lines 11:0-15:1 *)
let test_incr : result unit =
  let* x = ref_incr 0 in massert (x = 1)

(** Unit test for [paper::test_incr] *)
let _ = assert_norm (test_incr = Ok ())

(** [paper::choose]:
    Source: 'tests/src/paper.rs', lines 18:0-24:1 *)
let choose
  (#t : Type0) (b : bool) (x : t) (y : t) : result (t & (t -> (t & t))) =
  if b
  then let back = fun ret -> (ret, y) in Ok (x, back)
  else let back = fun ret -> (x, ret) in Ok (y, back)

(** [paper::test_choose]:
    Source: 'tests/src/paper.rs', lines 26:0-34:1 *)
let test_choose : result unit =
  let* (z, choose_back) = choose true 0 0 in
  let* z1 = i32_add z 1 in
  let* _ = massert (z1 = 1) in
  let (x, y) = choose_back z1 in
  let* _ = massert (x = 1) in
  massert (y = 0)

(** Unit test for [paper::test_choose] *)
let _ = assert_norm (test_choose = Ok ())

(** [paper::List]
    Source: 'tests/src/paper.rs', lines 38:0-41:1 *)
type list_t (t : Type0) =
| List_Cons : t -> list_t t -> list_t t
| List_Nil : list_t t

(** [paper::list_nth_mut]:
    Source: 'tests/src/paper.rs', lines 45:0-58:1 *)
let rec list_nth_mut
  (#t : Type0) (l : list_t t) (i : u32) : result (t & (t -> list_t t)) =
  begin match l with
  | List_Cons x tl ->
    if i = 0
    then let back = fun ret -> List_Cons ret tl in Ok (x, back)
    else
      let* i1 = u32_sub i 1 in
      let* (x1, list_nth_mut_back) = list_nth_mut tl i1 in
      let back = fun ret -> let tl1 = list_nth_mut_back ret in List_Cons x tl1
        in
      Ok (x1, back)
  | List_Nil -> Fail Failure
  end

(** [paper::sum]:
    Source: 'tests/src/paper.rs', lines 60:0-69:1 *)
let rec sum (l : list_t i32) : result i32 =
  begin match l with
  | List_Cons x tl -> let* i = sum tl in i32_add x i
  | List_Nil -> Ok 0
  end

(** [paper::test_nth]:
    Source: 'tests/src/paper.rs', lines 71:0-76:1 *)
let test_nth : result unit =
  let l = List_Cons 3 List_Nil in
  let l1 = List_Cons 2 l in
  let* (x, list_nth_mut_back) = list_nth_mut (List_Cons 1 l1) 2 in
  let* x1 = i32_add x 1 in
  let l2 = list_nth_mut_back x1 in
  let* i = sum l2 in
  massert (i = 7)

(** Unit test for [paper::test_nth] *)
let _ = assert_norm (test_nth = Ok ())

(** [paper::call_choose]:
    Source: 'tests/src/paper.rs', lines 79:0-85:1 *)
let call_choose (p : (u32 & u32)) : result u32 =
  let (px, py) = p in
  let* (pz, choose_back) = choose true px py in
  let* pz1 = u32_add pz 1 in
  let (px1, _) = choose_back pz1 in
  Ok px1


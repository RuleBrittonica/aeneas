-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [constants]
import Base
open Primitives

namespace constants

/- [constants::X0]
   Source: 'tests/src/constants.rs', lines 8:0-8:17 -/
def X0_body : Result U32 := Result.ok 0u32
def X0 : U32 := eval_global X0_body

/- [constants::X1]
   Source: 'tests/src/constants.rs', lines 10:0-10:17 -/
def X1_body : Result U32 := Result.ok core_u32_max
def X1 : U32 := eval_global X1_body

/- [constants::X2]
   Source: 'tests/src/constants.rs', lines 13:0-13:17 -/
def X2_body : Result U32 := Result.ok 3u32
def X2 : U32 := eval_global X2_body

/- [constants::incr]:
   Source: 'tests/src/constants.rs', lines 20:0-20:32 -/
def incr (n : U32) : Result U32 :=
  n + 1u32

/- [constants::X3]
   Source: 'tests/src/constants.rs', lines 18:0-18:17 -/
def X3_body : Result U32 := incr 32u32
def X3 : U32 := eval_global X3_body

/- [constants::mk_pair0]:
   Source: 'tests/src/constants.rs', lines 26:0-26:51 -/
def mk_pair0 (x : U32) (y : U32) : Result (U32 × U32) :=
  Result.ok (x, y)

/- [constants::Pair]
   Source: 'tests/src/constants.rs', lines 39:0-39:23 -/
structure Pair (T1 T2 : Type) where
  x : T1
  y : T2

/- [constants::mk_pair1]:
   Source: 'tests/src/constants.rs', lines 30:0-30:55 -/
def mk_pair1 (x : U32) (y : U32) : Result (Pair U32 U32) :=
  Result.ok { x := x, y := y }

/- [constants::P0]
   Source: 'tests/src/constants.rs', lines 34:0-34:24 -/
def P0_body : Result (U32 × U32) := mk_pair0 0u32 1u32
def P0 : (U32 × U32) := eval_global P0_body

/- [constants::P1]
   Source: 'tests/src/constants.rs', lines 35:0-35:28 -/
def P1_body : Result (Pair U32 U32) := mk_pair1 0u32 1u32
def P1 : Pair U32 U32 := eval_global P1_body

/- [constants::P2]
   Source: 'tests/src/constants.rs', lines 36:0-36:24 -/
def P2_body : Result (U32 × U32) := Result.ok (0u32, 1u32)
def P2 : (U32 × U32) := eval_global P2_body

/- [constants::P3]
   Source: 'tests/src/constants.rs', lines 37:0-37:28 -/
def P3_body : Result (Pair U32 U32) := Result.ok { x := 0u32, y := 1u32 }
def P3 : Pair U32 U32 := eval_global P3_body

/- [constants::Wrap]
   Source: 'tests/src/constants.rs', lines 52:0-52:18 -/
structure Wrap (T : Type) where
  value : T

/- [constants::{constants::Wrap<T>}::new]:
   Source: 'tests/src/constants.rs', lines 57:4-57:41 -/
def Wrap.new (T : Type) (value : T) : Result (Wrap T) :=
  Result.ok { value := value }

/- [constants::Y]
   Source: 'tests/src/constants.rs', lines 44:0-44:22 -/
def Y_body : Result (Wrap I32) := Wrap.new I32 2i32
def Y : Wrap I32 := eval_global Y_body

/- [constants::unwrap_y]:
   Source: 'tests/src/constants.rs', lines 46:0-46:30 -/
def unwrap_y : Result I32 :=
  Result.ok Y.value

/- [constants::YVAL]
   Source: 'tests/src/constants.rs', lines 50:0-50:19 -/
def YVAL_body : Result I32 := unwrap_y
def YVAL : I32 := eval_global YVAL_body

/- [constants::get_z1::Z1]
   Source: 'tests/src/constants.rs', lines 65:4-65:17 -/
def get_z1.Z1_body : Result I32 := Result.ok 3i32
def get_z1.Z1 : I32 := eval_global get_z1.Z1_body

/- [constants::get_z1]:
   Source: 'tests/src/constants.rs', lines 64:0-64:28 -/
def get_z1 : Result I32 :=
  Result.ok get_z1.Z1

/- [constants::add]:
   Source: 'tests/src/constants.rs', lines 69:0-69:39 -/
def add (a : I32) (b : I32) : Result I32 :=
  a + b

/- [constants::Q1]
   Source: 'tests/src/constants.rs', lines 77:0-77:17 -/
def Q1_body : Result I32 := Result.ok 5i32
def Q1 : I32 := eval_global Q1_body

/- [constants::Q2]
   Source: 'tests/src/constants.rs', lines 78:0-78:17 -/
def Q2_body : Result I32 := Result.ok Q1
def Q2 : I32 := eval_global Q2_body

/- [constants::Q3]
   Source: 'tests/src/constants.rs', lines 79:0-79:17 -/
def Q3_body : Result I32 := add Q2 3i32
def Q3 : I32 := eval_global Q3_body

/- [constants::get_z2]:
   Source: 'tests/src/constants.rs', lines 73:0-73:28 -/
def get_z2 : Result I32 :=
  do
  let i ← get_z1
  let i1 ← add i Q3
  add Q1 i1

/- [constants::S1]
   Source: 'tests/src/constants.rs', lines 83:0-83:18 -/
def S1_body : Result U32 := Result.ok 6u32
def S1 : U32 := eval_global S1_body

/- [constants::S2]
   Source: 'tests/src/constants.rs', lines 84:0-84:18 -/
def S2_body : Result U32 := incr S1
def S2 : U32 := eval_global S2_body

/- [constants::S3]
   Source: 'tests/src/constants.rs', lines 85:0-85:29 -/
def S3_body : Result (Pair U32 U32) := Result.ok P3
def S3 : Pair U32 U32 := eval_global S3_body

/- [constants::S4]
   Source: 'tests/src/constants.rs', lines 86:0-86:29 -/
def S4_body : Result (Pair U32 U32) := mk_pair1 7u32 8u32
def S4 : Pair U32 U32 := eval_global S4_body

/- [constants::V]
   Source: 'tests/src/constants.rs', lines 89:0-89:31 -/
structure V (T : Type) (N : Usize) where
  x : Array T N

/- [constants::{constants::V<T, N>#1}::LEN]
   Source: 'tests/src/constants.rs', lines 94:4-94:24 -/
def V.LEN_body (T : Type) (N : Usize) : Result Usize := Result.ok N
def V.LEN (T : Type) (N : Usize) : Usize := eval_global (V.LEN_body T N)

/- [constants::use_v]:
   Source: 'tests/src/constants.rs', lines 97:0-97:42 -/
def use_v (T : Type) (N : Usize) : Result Usize :=
  Result.ok (V.LEN T N)

end constants

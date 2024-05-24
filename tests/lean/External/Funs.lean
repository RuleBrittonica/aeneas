-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [external]: function definitions
import Base
import External.Types
import External.FunsExternal
open Primitives

namespace external

/- Trait implementation: [core::marker::{(core::marker::Copy for u32)#61}]
   Source: '/rustc/ad963232d9b987d66a6f8e6ec4141f672b8b9900/library/core/src/marker.rs', lines 47:29-47:65
   Name pattern: core::marker::Copy<u32> -/
def core.marker.CopyU32 : core.marker.Copy U32 := {
  cloneCloneInst := core.clone.CloneU32
}

/- [external::use_get]:
   Source: 'tests/src/external.rs', lines 5:0-5:37 -/
def use_get (rc : core.cell.Cell U32) (st : State) : Result (State × U32) :=
  core.cell.Cell.get U32 core.marker.CopyU32 rc st

/- [external::incr]:
   Source: 'tests/src/external.rs', lines 9:0-9:31 -/
def incr
  (rc : core.cell.Cell U32) (st : State) :
  Result (State × (core.cell.Cell U32))
  :=
  do
  let (st1, (i, get_mut_back)) ← core.cell.Cell.get_mut U32 rc st
  let i1 ← i + 1#u32
  let (_, rc1) ← get_mut_back i1 st1
  Result.ok (st1, rc1)

end external

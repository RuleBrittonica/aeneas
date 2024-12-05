-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [external]: function definitions
import Base
import External.Types
import External.FunsExternal
open Primitives
set_option linter.dupNamespace false
set_option linter.hashCommand false
set_option linter.unusedVariables false

namespace external

/- [external::use_get]:
   Source: 'tests/src/external.rs', lines 9:0-11:1 -/
def use_get (rc : core.cell.Cell U32) (st : State) : Result (State × U32) :=
  core.cell.Cell.get core.marker.CopyU32 rc st

/- [external::incr]:
   Source: 'tests/src/external.rs', lines 13:0-15:1 -/
def incr
  (rc : core.cell.Cell U32) (st : State) :
  Result (State × (core.cell.Cell U32))
  :=
  do
  let (st1, (i, get_mut_back)) ← core.cell.Cell.get_mut rc st
  let i1 ← i + 1#u32
  let (_, rc1) := get_mut_back i1 st1
  Result.ok (st1, rc1)

end external

import Mathlib.Tactic.Basic
import Mathlib.Tactic.Attr.Register
import Mathlib.Data.Int.Cast.Basic
import Mathlib.Order.Basic
import Aeneas.Natify.Init
import Aeneas.Arith.Lemmas
import Aeneas.Std.Scalar

/-!
# `natify` tactic

The `natify` tactic is used to shift propositions about, e.g., `ZMod` or `BitVec`, to `Nat`.
This tactic is adapted from `zify`.
-/

namespace Aeneas.Natify

open Lean
open Lean.Meta
open Lean.Parser.Tactic
open Lean.Elab.Tactic
open Arith Std

syntax (name := natify) "natify" (simpArgs)? (location)? : tactic

macro_rules
| `(tactic| natify $[[$simpArgs,*]]? $[at $location]?) =>
  let args := simpArgs.map (·.getElems) |>.getD #[]
  `(tactic|
    simp -decide (maxDischargeDepth := 1) only [natify_simps, push_cast, $args,*] $[at $location]?)

/-- The `Simp.Context` generated by `natify`. -/
def mkNatifyContext (simpArgs : Option (Syntax.TSepArray `Lean.Parser.Tactic.simpStar ",")) :
    TacticM MkSimpContextResult := do
  let args := simpArgs.map (·.getElems) |>.getD #[]
  mkSimpContext
    (← `(tactic| simp -decide (maxDischargeDepth := 1) only [natify_simps, push_cast, $args,*])) false

/-- A variant of `applySimpResultToProp` that cannot close the goal, but does not need a meta
variable and returns a tuple of a proof and the corresponding simplified proposition. -/
def applySimpResultToProp' (proof : Expr) (prop : Expr) (r : Simp.Result) : MetaM (Expr × Expr) :=
  do
  match r.proof? with
  | some eqProof => return (← mkExpectedTypeHint (← mkEqMP eqProof proof) r.expr, r.expr)
  | none =>
    if r.expr != prop then
      return (← mkExpectedTypeHint proof r.expr, r.expr)
    else
      return (proof, r.expr)

/-- Translate a proof and the proposition into a natified form. -/
def natifyProof (simpArgs : Option (Syntax.TSepArray `Lean.Parser.Tactic.simpStar ","))
    (proof : Expr) (prop : Expr) : TacticM (Expr × Expr) := do
  let ctx_result ← mkNatifyContext simpArgs
  let (r, _) ← simp prop ctx_result.ctx
  applySimpResultToProp' proof prop r

attribute [natify_simps] BitVec.toNat_eq BitVec.lt_def BitVec.le_def
                         BitVec.toNat_umod BitVec.toNat_add BitVec.toNat_sub BitVec.toNat_ofNat
                         BitVec.toNat_and BitVec.toNat_or BitVec.toNat_xor
attribute [natify_simps] ZMod.eq_iff_mod ZMod.val_add ZMod.val_sub ZMod.val_mul
attribute [natify_simps] U8.bv_toNat_eq U16.bv_toNat_eq U32.bv_toNat_eq U64.bv_toNat_eq U128.bv_toNat_eq Usize.bv_toNat_eq

example (x y : BitVec 32) (h : x.toNat = y.toNat) : x = y := by natify [h]

end Aeneas.Natify

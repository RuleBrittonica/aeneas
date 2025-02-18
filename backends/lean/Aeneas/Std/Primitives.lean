import Lean

namespace Aeneas

namespace Std

/-!
# Assert Command
-/

open Lean Elab Command Term Meta

syntax (name := assert) "#assert" term: command

@[command_elab assert]
unsafe
def assertImpl : CommandElab := fun (stx: Syntax) => do
  runTermElabM (fun _ => do
    let r ← evalTerm Bool (mkConst ``Bool) stx[1]
    if not r then
      logInfo ("Assertion failed for:\n" ++ stx[1])
      throwError ("Expression reduced to false:\n"  ++ stx[1])
    pure ())

#eval 2 == 2
#assert (2 == 2)

/-!
# Results and Monadic Combinators
-/

inductive Error where
   | assertionFailure: Error
   | integerOverflow: Error
   | divisionByZero: Error
   | arrayOutOfBounds: Error
   | maximumSizeExceeded: Error
   | panic: Error
deriving Repr, BEq

open Error

inductive Result (α : Type u) where
  | ok (v: α): Result α
  | fail (e: Error): Result α
  | div
deriving Repr, BEq

open Result

instance Result_Inhabited (α : Type u) : Inhabited (Result α) :=
  Inhabited.mk (fail panic)

instance Result_Nonempty (α : Type u) : Nonempty (Result α) :=
  Nonempty.intro div

/-!
# Helpers
-/

def ok? {α: Type u} (r: Result α): Bool :=
  match r with
  | ok _ => true
  | fail _ | div => false

def div? {α: Type u} (r: Result α): Bool :=
  match r with
  | div => true
  | ok _ | fail _ => false

def massert (b:Bool) : Result Unit :=
  if b then ok () else fail assertionFailure

macro "prove_eval_global" : tactic => `(tactic| first | apply Eq.refl | decide)

def eval_global {α: Type u} (x: Result α) (_: ok? x := by prove_eval_global) : α :=
  match x with
  | fail _ | div => by contradiction
  | ok x => x

@[simp]
def Result.ofOption {a : Type u} (x : Option a) (e : Error) : Result a :=
  match x with
  | some x => ok x
  | none => fail e

/-!
# Do-DSL Support
-/

def bind {α : Type u} {β : Type v} (x: Result α) (f: α → Result β) : Result β :=
  match x with
  | ok v  => f v
  | fail v => fail v
  | div => div

-- Allows using Result in do-blocks
instance : Bind Result where
  bind := bind

-- Allows using pure x in do-blocks
instance : Pure Result where
  pure := fun x => ok x

@[simp] theorem bind_ok (x : α) (f : α → Result β) : bind (.ok x) f = f x := by simp [bind]
@[simp] theorem bind_fail (x : Error) (f : α → Result β) : bind (.fail x) f = .fail x := by simp [bind]
@[simp] theorem bind_div (f : α → Result β) : bind .div f = .div := by simp [bind]

@[simp] theorem bind_tc_ok (x : α) (f : α → Result β) :
  (do let y ← .ok x; f y) = f x := by simp [Bind.bind, bind]

@[simp] theorem bind_tc_fail (x : Error) (f : α → Result β) :
  (do let y ← fail x; f y) = fail x := by simp [Bind.bind, bind]

@[simp] theorem bind_tc_div (f : α → Result β) :
  (do let y ← div; f y) = div := by simp [Bind.bind, bind]

@[simp] theorem bind_assoc_eq {a b c : Type u}
  (e : Result a) (g :  a → Result b) (h : b → Result c) :
  (Bind.bind (Bind.bind e g) h) =
  (Bind.bind e (λ x => Bind.bind (g x) h)) := by
  simp [Bind.bind]
  cases e <;> simp

/-!
# Lift
-/

/-- We use this to lift pure function calls to monadic calls.
    We don't mark this as reducible so that let-bindings don't get simplified away.

    In the generated code if regularly happens that we want to lift pure function calls so
    that `progress` can reason about them. For instance, `U32.wrapping_add` has type `U32 → U32 → U32`,
    but we provide a `progress` theorem with an informative post-condition, and which matches the pattern
    `toResult (wrapping_add x y)`. This theorem can only be looked up and appliced if the code is of the
    following shape:
    ```
    let z ← U32.wrapping_add x y
    ...
    ```
  -/
def toResult {α : Type u} (x : α) : Result α := Result.ok x

instance {α : Type u} : Coe α (Result α) where
  coe := toResult

attribute [coe] toResult

/- Testing that our coercion from `α` to `Result α` works. -/
example : Result Int := do
  let x0 ← ↑(0 : Int)
  let x1 ← ↑(x0 + 1 : Int)
  x1

/- Testing that our coercion from `α` to `Result α` doesn't break other coercions. -/
example (n : Nat) (i : Int) (_ : n < i) : True := by simp

/-!
# Misc
-/

instance SubtypeBEq [BEq α] (p : α → Prop) : BEq (Subtype p) where
  beq v0 v1 := v0.val == v1.val

instance SubtypeLawfulBEq [BEq α] (p : α → Prop) [LawfulBEq α] : LawfulBEq (Subtype p) where
  eq_of_beq {a b} h := by cases a; cases b; simp_all [BEq.beq]
  rfl := by intro a; cases a; simp [BEq.beq]

/- A helper function that converts failure to none and success to some
   TODO: move up to Core module? -/
def Option.ofResult {a : Type u} (x : Result a) :
  Option a :=
  match x with
  | ok x => some x
  | _ => none

/-!
# Misc Primitive Types
-/

-- We don't really use raw pointers for now
structure MutRawPtr (T : Type) where
  v : T

structure ConstRawPtr (T : Type) where
  v : T

end Std

end Aeneas

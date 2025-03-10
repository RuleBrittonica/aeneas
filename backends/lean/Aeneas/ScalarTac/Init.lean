import Aeneas.Extensions
import Aesop
open Lean Meta

namespace Aeneas.ScalarTac

/-!
# Tracing
-/

-- We can't define and use trace classes in the same file
initialize registerTraceClass `ScalarTac

/-!
# Simp Sets
-/

/-- The `scalar_tac_simp` simp attribute. -/
initialize scalarTacSimpExt : SimpExtension ←
  registerSimpAttr `scalar_tac_simp "\
    The `scalar_tac_simp` attribute registers simp lemmas to be used by `scalar_tac`
    during its preprocessing phase."

/-!
# Saturation Rules Sets
-/

declare_aesop_rule_sets [Aeneas.ScalarTac, Aeneas.ScalarTacNonLin]

-- The sets of rules that `scalar_tac` should use
open Extensions in
initialize scalarTacRuleSets : ListDeclarationExtension Name ← do
  mkListDeclarationExtension `scalarTacRuleSetsList

def scalarTacRuleSets.get : MetaM (List Name) := do
  pure (scalarTacRuleSets.getState (← getEnv))

-- Note that the changes are not persistent
def scalarTacRuleSets.set (names : List Name) : MetaM Unit := do
  let _ := scalarTacRuleSets.setState (← getEnv) names

-- Note that the changes are not persistent
def scalarTacRuleSets.add (name : Name) : MetaM Unit := do
  let _ := scalarTacRuleSets.modifyState (← getEnv) (fun ls => name :: ls)

end Aeneas.ScalarTac

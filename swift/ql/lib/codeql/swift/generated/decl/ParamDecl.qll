// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.PatternBindingDecl
import codeql.swift.elements.decl.VarDecl

module Generated {
  class ParamDecl extends Synth::TParamDecl, VarDecl {
    override string getAPrimaryQlClass() { result = "ParamDecl" }

    /**
     * Holds if this is an `inout` parameter.
     */
    predicate isInout() { Synth::convertParamDeclToRaw(this).(Raw::ParamDecl).isInout() }

    /**
     * Gets the property wrapper local wrapped var binding of this parameter declaration, if it exists.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    PatternBindingDecl getImmediatePropertyWrapperLocalWrappedVarBinding() {
      result =
        Synth::convertPatternBindingDeclFromRaw(Synth::convertParamDeclToRaw(this)
              .(Raw::ParamDecl)
              .getPropertyWrapperLocalWrappedVarBinding())
    }

    /**
     * Gets the property wrapper local wrapped var binding of this parameter declaration, if it exists.
     *
     * This is the synthesized binding introducing the property wrapper local wrapped projection
     * variable for this variable, if any.
     */
    final PatternBindingDecl getPropertyWrapperLocalWrappedVarBinding() {
      result = getImmediatePropertyWrapperLocalWrappedVarBinding().resolve()
    }

    /**
     * Holds if `getPropertyWrapperLocalWrappedVarBinding()` exists.
     */
    final predicate hasPropertyWrapperLocalWrappedVarBinding() {
      exists(getPropertyWrapperLocalWrappedVarBinding())
    }

    /**
     * Gets the property wrapper local wrapped var of this parameter declaration, if it exists.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    VarDecl getImmediatePropertyWrapperLocalWrappedVar() {
      result =
        Synth::convertVarDeclFromRaw(Synth::convertParamDeclToRaw(this)
              .(Raw::ParamDecl)
              .getPropertyWrapperLocalWrappedVar())
    }

    /**
     * Gets the property wrapper local wrapped var of this parameter declaration, if it exists.
     *
     * This is the synthesized local wrapped value, shadowing this parameter declaration in case it
     * has a property wrapper.
     */
    final VarDecl getPropertyWrapperLocalWrappedVar() {
      result = getImmediatePropertyWrapperLocalWrappedVar().resolve()
    }

    /**
     * Holds if `getPropertyWrapperLocalWrappedVar()` exists.
     */
    final predicate hasPropertyWrapperLocalWrappedVar() {
      exists(getPropertyWrapperLocalWrappedVar())
    }
  }
}

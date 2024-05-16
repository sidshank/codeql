// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `PackElementExpr`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr

/**
 * INTERNAL: This module contains the fully generated definition of `PackElementExpr` and should not
 * be referenced directly.
 */
module Generated {
  /**
   * A pack element expression is a child of PackExpansionExpr.
   *
   * In the following example, `each t` on the second line is the pack element expression:
   * ```
   * func makeTuple<each T>(_ t: repeat each T) -> (repeat each T) {
   *   return (repeat each t)
   * }
   * ```
   *
   * More details:
   * https://github.com/apple/swift-evolution/blob/main/proposals/0393-parameter-packs.md
   * INTERNAL: Do not reference the `Generated::PackElementExpr` class directly.
   * Use the subclass `PackElementExpr`, where the following predicates are available.
   */
  class PackElementExpr extends Synth::TPackElementExpr, Expr {
    override string getAPrimaryQlClass() { result = "PackElementExpr" }

    /**
     * Gets the sub expression of this pack element expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertPackElementExprToRaw(this)
              .(Raw::PackElementExpr)
              .getSubExpr())
    }

    /**
     * Gets the sub expression of this pack element expression.
     */
    final Expr getSubExpr() {
      exists(Expr immediate |
        immediate = this.getImmediateSubExpr() and
        if exists(this.getResolveStep()) then result = immediate else result = immediate.resolve()
      )
    }
  }
}

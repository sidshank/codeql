// generated by codegen/codegen.py
import codeql.swift.elements.stmt.LabeledConditionalStmt

class WhileStmtBase extends @while_stmt, LabeledConditionalStmt {
  override string getAPrimaryQlClass() { result = "WhileStmt" }
}

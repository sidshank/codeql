/**
 * Provides a simple base test for flow-related tests using inline expectations.
 *
 * Example for a test.ql:
 * ```ql
 * import java
 * import TestUtilities.InlineFlowTest
 * import DefaultFlowTest
 * ```
 *
 * To declare expectations, you can use the $hasTaintFlow or $hasValueFlow comments within the test source files.
 * Example of the corresponding test file, e.g. Test.java
 * ```java
 * public class Test {
 *
 * 	Object source() { return null; }
 * 	String taint() { return null; }
 * 	void sink(Object o) { }
 *
 * 	public void test() {
 * 		Object s = source();
 * 		sink(s); // $ hasValueFlow
 * 		String t = "foo" + taint();
 * 		sink(t); // $ hasTaintFlow
 * 	}
 *
 * }
 * ```
 *
 * If you are only interested in value flow, then instead of importing `DefaultFlowTest`, you can import
 * `ValueFlowTest<DefaultFlowConfig>`. Similarly, if you are only interested in taint flow, then instead of
 * importing `DefaultFlowTest`, you can import `TaintFlowTest<DefaultFlowConfig>`. In both cases
 * `DefaultFlowConfig` can be replaced by another implementation of `DataFlow::ConfigSig`.
 *
 * If you need more fine-grained tuning, consider implementing a test using `InlineExpectationsTest`.
 */

import semmle.code.java.dataflow.DataFlow
import semmle.code.java.dataflow.ExternalFlow
import semmle.code.java.dataflow.TaintTracking
import TestUtilities.InlineExpectationsTest

private predicate defaultSource(DataFlow::Node source) {
  source.asExpr().(MethodAccess).getMethod().getName() = ["source", "taint"]
}

private predicate defaultSink(DataFlow::Node sink) {
  exists(MethodAccess ma | ma.getMethod().hasName("sink") | sink.asExpr() = ma.getAnArgument())
}

module DefaultFlowConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { defaultSource(source) }

  predicate isSink(DataFlow::Node sink) { defaultSink(sink) }

  int fieldFlowBranchLimit() { result = 1000 }
}

private module NoFlowConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { none() }

  predicate isSink(DataFlow::Node sink) { none() }
}

private string getSourceArgString(DataFlow::Node src) {
  defaultSource(src) and
  src.asExpr().(MethodAccess).getAnArgument().(StringLiteral).getValue() = result
}

module FlowTest<DataFlow::ConfigSig ValueFlowConfig, DataFlow::ConfigSig TaintFlowConfig> {
  module ValueFlow = DataFlow::Global<ValueFlowConfig>;

  module TaintFlow = TaintTracking::Global<TaintFlowConfig>;

  private module InlineTest implements TestSig {
    string getARelevantTag() { result = ["hasValueFlow", "hasTaintFlow"] }

    predicate hasActualResult(Location location, string element, string tag, string value) {
      tag = "hasValueFlow" and
      exists(DataFlow::Node src, DataFlow::Node sink | ValueFlow::flow(src, sink) |
        sink.getLocation() = location and
        element = sink.toString() and
        if exists(getSourceArgString(src)) then value = getSourceArgString(src) else value = ""
      )
      or
      tag = "hasTaintFlow" and
      exists(DataFlow::Node src, DataFlow::Node sink |
        TaintFlow::flow(src, sink) and not ValueFlow::flow(src, sink)
      |
        sink.getLocation() = location and
        element = sink.toString() and
        if exists(getSourceArgString(src)) then value = getSourceArgString(src) else value = ""
      )
    }
  }

  import MakeTest<InlineTest>
}

module DefaultFlowTest = FlowTest<DefaultFlowConfig, DefaultFlowConfig>;

module ValueFlowTest<DataFlow::ConfigSig ValueFlowConfig> {
  import FlowTest<ValueFlowConfig, NoFlowConfig>
}

module TaintFlowTest<DataFlow::ConfigSig TaintFlowConfig> {
  import FlowTest<NoFlowConfig, TaintFlowConfig>
}

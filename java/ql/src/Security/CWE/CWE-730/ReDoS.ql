/**
 * @name Inefficient regular expression
 * @description A regular expression that requires exponential time to match certain inputs
 *              can be a performance bottleneck, and may be vulnerable to denial-of-service
 *              attacks.
 * @kind problem
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @id java/redos
 * @tags security
 *       external/cwe/cwe-730
 *       external/cwe/cwe-400
 */

import java
import semmle.code.java.security.performance.ExponentialBackTracking

from RegExpTerm t, string pump, State s, string prefixMsg
where
  hasReDoSResult(t, pump, s, prefixMsg) and
  // exclude verbose mode regexes for now
  not t.getRegex().getAMode() = "VERBOSE"
select t,
  "This part of the regular expression may cause exponential backtracking on strings " + prefixMsg +
    "containing many repetitions of '" + pump + "'."

/**
 * @name Unsafe eval() usage in calculator
 * @description Detects eval() calls that could lead to code injection
 * @kind problem
 * @problem.severity error
 * @security-severity 9.0
 * @precision high
 * @id js/workshop-unsafe-eval
 * @tags security
 *       external/cwe/cwe-94
 */

import javascript

from CallExpr call
where call.getCallee().(GlobalVarAccess).getName() = "eval"
  and call.getParent*() instanceof Function
select call, "Unsafe eval() usage detected. Consider using safer alternatives like Function constructor with validation."

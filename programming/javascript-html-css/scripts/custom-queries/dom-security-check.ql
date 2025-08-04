/**
 * @name Unsafe DOM manipulation
 * @description Detects potentially unsafe DOM content assignments
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision medium
 * @id js/workshop-dom-security
 * @tags security
 *       external/cwe/cwe-79
 */

import javascript

from PropAccess prop
where prop.getPropertyName() = "innerHTML"
  and exists(AssignExpr assign | 
    assign.getLhs() = prop and
    not assign.getRhs() instanceof StringLiteral
  )
select prop, "Dynamic innerHTML assignment detected. Verify input sanitization."

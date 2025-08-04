/**
 * @name Custom XSS vulnerability detection
 * @description Finds direct DOM manipulation that could lead to XSS vulnerabilities
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision medium
 * @id js/custom-xss-check
 * @tags security
 *       external/cwe/cwe-79
 */

import javascript

from CallExpr call, PropAccess prop
where prop.getPropertyName() = "innerHTML"
  and call.getCallee() = prop
  and exists(call.getArgument(0))
  and not call.getArgument(0) instanceof StringLiteral
select call, "Potential XSS: Dynamic innerHTML assignment detected. Verify input sanitization."

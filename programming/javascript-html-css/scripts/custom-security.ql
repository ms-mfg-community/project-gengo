/**
 * @name Potential XSS vulnerability
 * @description Finds direct DOM manipulation that could lead to XSS
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision medium
 * @id js/custom-xss-check
 * @tags security
 *       external/cwe/cwe-79
 */

import javascript

from Assignment assign, PropAccess prop
where prop.getPropertyName() = "innerHTML"
  and assign.getLhs() = prop
  and exists(assign.getRhs())
select assign, "Potential XSS: innerHTML assignment detected."
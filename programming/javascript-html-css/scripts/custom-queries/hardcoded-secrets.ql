/**
 * @name Hardcoded API keys and secrets
 * @description Finds potential hardcoded credentials in JavaScript code
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision medium
 * @id js/hardcoded-secrets
 * @tags security
 *       external/cwe/cwe-798
 */

import javascript

from StringLiteral s
where s.getValue().regexpMatch("(?i).*(api[_-]?key|token|secret|password|auth[_-]?key).*")
  and s.getValue().length() > 8
  and not s.getValue().matches("%example%")
  and not s.getValue().matches("%test%")
select s, "Potential hardcoded credential detected: " + s.getValue()

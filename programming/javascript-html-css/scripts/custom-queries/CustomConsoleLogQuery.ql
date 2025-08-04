/**
 * @name Find console.log statements
 * @description Finds all console.log statements which may be security concerns in production
 * @kind problem
 * @problem.severity warning
 * @id js/find-console-log
 * @tags security
 *       external/cwe/cwe-532
 */

import javascript

from CallExpr call, PropAccess prop
where
  call.getCallee() = prop and
  prop.getBase().(GlobalVarAccess).getName() = "console" and
  prop.getPropertyName() = "log"
select call, "Console.log statement found - consider removing in production"

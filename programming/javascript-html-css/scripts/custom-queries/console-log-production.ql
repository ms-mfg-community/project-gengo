/**
 * @name Console statements in production code
 * @description Finds console.log statements that should be removed for production
 * @kind problem
 * @problem.severity note
 * @precision high
 * @id js/console-log-production
 * @tags maintainability
 *       best-practice
 */

import javascript

from CallExpr call
where call.getCallee().(PropAccess).getPropertyName() = "log"
  and call.getCallee().(PropAccess).getBase().(GlobalVarAccess).getName() = "console"
select call, "Console.log statement found - consider removing for production deployment."

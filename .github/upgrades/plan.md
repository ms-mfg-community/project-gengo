# .NET 10.0 Upgrade Plan

## Execution Steps

Execute steps below sequentially one by one in the order they are listed.

1. Validate that a .NET 10.0 SDK required for this upgrade is installed on the machine and if not, help to get it installed.
2. Ensure that the SDK version specified in global.json files is compatible with the .NET 10.0 upgrade.
3. Upgrade calculator\calculator.csproj
4. Upgrade Calculator.Core\Calculator.Core.csproj
5. Upgrade calculator.tests\calculator.tests.csproj
6. Upgrade CalculatorBlazor\CalculatorBlazor.csproj
7. Run unit tests to validate upgrade in the projects listed below:
   - calculator.tests\calculator.tests.csproj

## Settings

This section contains settings and data used by execution steps.

### Excluded projects

No projects are excluded from this upgrade.

### Project upgrade details

#### calculator\calculator.csproj modifications

Project properties changes:
  - Target framework should be changed from `net8.0` to `net10.0`

#### Calculator.Core\Calculator.Core.csproj modifications

Project properties changes:
  - Target framework should be changed from `net8.0` to `net10.0`

#### calculator.tests\calculator.tests.csproj modifications

Project properties changes:
  - Target framework should be changed from `net8.0` to `net10.0`

#### CalculatorBlazor\CalculatorBlazor.csproj modifications

Project properties changes:
  - Target framework should be changed from `net8.0` to `net10.0`

API Migration Notes:
  - Behavioral change detected in `Microsoft.AspNetCore.Builder.ExceptionHandlerExtensions.UseExceptionHandler(Microsoft.AspNetCore.Builder.IApplicationBuilder,System.String)`. Verify that exception handling behavior is as expected after upgrade.

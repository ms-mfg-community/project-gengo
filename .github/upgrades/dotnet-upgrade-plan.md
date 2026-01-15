# .NET 10.0 Upgrade Plan

## Execution Steps

Execute steps below sequentially one by one in the order they are listed.

1. Validate that a .NET 10.0 SDK required for this upgrade is installed on the machine and if not, help to get it installed.
2. Ensure that the SDK version specified in global.json files is compatible with the .NET 10.0 upgrade.
3. Run unit tests to validate upgrade in the projects listed below:
   - calculator.tests\calculator.tests.csproj
4. Upgrade Calculator.Core\Calculator.Core.csproj
5. Upgrade CalculatorBlazor\CalculatorBlazor.csproj
6. Run unit tests for the CalculatorBlazor project to validate upgrade.

## Settings

### Project upgrade details

#### calculator\calculator.csproj modifications

Project properties changes:
  - Target framework should be changed from `net8.0` to `net10.0`

#### calculator.tests\calculator.tests.csproj modifications

Project properties changes:
  - Target framework should be changed from `net8.0` to `net10.0`
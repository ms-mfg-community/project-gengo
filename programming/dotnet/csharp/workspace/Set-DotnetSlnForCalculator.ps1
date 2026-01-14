<#
.SYNOPSIS
    Sets up the calculator solution with .NET 8 console app and xUnit test project.

.DESCRIPTION
    This script creates a complete solution structure for the calculator project including:
    - A .NET 8 console application (calculator)
    - An xUnit test project (calculator.tests)
    - Proper project references and solution configuration

.PARAMETER Path
    Optional. The path where to create the solution. Defaults to the current git repository root
    followed by the programming/dotnet/csharp/workspace path.

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    
    Creates the solution in the default workspace path.

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1 -Path "C:\custom\path"
    
    Creates the solution in a custom path.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : PowerShell 5.0+, .NET 8.0 SDK installed
    Version        : 1.0

#>

param(
    [Parameter(Mandatory=$false, HelpMessage="Path to the workspace directory")]
    [string]$Path
)

# If path not provided, calculate it from git root
if ([string]::IsNullOrWhiteSpace($Path)) {
    try {
        $gitRoot = git rev-parse --show-toplevel
        $Path = Join-Path $gitRoot "programming\dotnet\csharp\workspace"
    }
    catch {
        Write-Error "Could not determine git repository root. Please provide -Path parameter."
        exit 1
    }
}

$solutionDir = Join-Path $Path "calculator-xunit-testing"

Write-Host "Setting up calculator solution..."

# Create directory
if (-not (Test-Path $solutionDir)) {
    New-Item -ItemType Directory -Path $solutionDir | Out-Null
    Write-Host "✓ Created directory: $solutionDir"
} else {
    Write-Host "✓ Directory already exists: $solutionDir"
}

Push-Location $solutionDir

try {
    # Create solution
    Write-Host "Creating solution..."
    & dotnet new sln -n calculator | Out-Null
    Write-Host "✓ Solution created"

    # Create console app
    Write-Host "Creating console application..."
    & dotnet new console -n calculator --framework net8.0 | Out-Null
    Write-Host "✓ Console app created"

    # Create xUnit test project
    Write-Host "Creating xUnit test project..."
    & dotnet new xunit -n calculator.tests --framework net8.0 | Out-Null
    Write-Host "✓ Test project created"

    # Add projects to solution
    Write-Host "Adding projects to solution..."
    & dotnet sln calculator.slnx add calculator/calculator.csproj calculator.tests/calculator.tests.csproj | Out-Null
    Write-Host "✓ Projects added to solution"

    # Configure references
    Write-Host "Configuring project references..."
    & dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj | Out-Null
    Write-Host "✓ Project references configured"

    Write-Host "`n✓ Setup complete!" -ForegroundColor Green
    Write-Host "`nNext steps:"
    Write-Host "1. Review the PRD: programming\dotnet\csharp\workspace\prd-csharp-basic-calculator-solution.md"
    Write-Host "2. Implement Calculator.cs and Program.cs"
    Write-Host "3. Create comprehensive tests in calculator.tests"
    Write-Host "4. Build: dotnet build"
    Write-Host "5. Test: dotnet test"
}
finally {
    Pop-Location
}

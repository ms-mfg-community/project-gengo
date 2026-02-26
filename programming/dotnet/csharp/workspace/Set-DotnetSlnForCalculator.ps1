<#
.SYNOPSIS
    Sets up a .NET 8.0 calculator solution with xUnit testing framework.

.DESCRIPTION
    This script creates a complete solution structure for a calculator application
    with comprehensive xUnit unit tests. It:
    - Creates a solution folder and solution file
    - Sets up a console application project
    - Sets up an xUnit test project
    - Configures project references
    - Updates all projects to target .NET 8.0
    - Updates package versions for .NET 8.0 compatibility
    - Builds the complete solution

.NOTES
    - Requires .NET 8.0 SDK or later
    - Creates structure at: {WorkspaceRoot}/calculator-xunit-testing
    - All projects target .NET 8.0 specifically (net8.0)
    - Uses compatible package versions for .NET 8.0 support

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    Creates the calculator-xunit-testing solution in the current directory
#>

#Requires -Version 5.1
Set-StrictMode -Version Latest

# Configuration
$SolutionName = "calculator-xunit-testing"
$AppProjectName = "calculator"
$TestProjectName = "calculator.tests"
$TargetFramework = "net8.0"

# Get the workspace directory (where this script is located)
$WorkspaceRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SolutionPath = Join-Path -Path $WorkspaceRoot -ChildPath $SolutionName

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Calculator Solution Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

try
{
    # Step 1: Check if solution already exists
    if (Test-Path $SolutionPath)
    {
        Write-Host "⚠️  Solution folder already exists at: $SolutionPath" -ForegroundColor Yellow
        $response = Read-Host "Do you want to remove it and create a fresh setup? (yes/no)"
        if ($response -eq "yes")
        {
            Write-Host "Removing existing solution folder..." -ForegroundColor Yellow
            Remove-Item -Path $SolutionPath -Recurse -Force
        }
        else
        {
            Write-Host "Setup cancelled." -ForegroundColor Yellow
            exit 0
        }
    }

    # Step 2: Create solution folder
    Write-Host "Creating solution folder..." -ForegroundColor Green
    $null = New-Item -Path $SolutionPath -ItemType Directory -Force
    Write-Host "✓ Created: $SolutionPath" -ForegroundColor Green

    # Step 3: Create solution file
    Write-Host "Creating solution file..." -ForegroundColor Green
    Push-Location $SolutionPath
    try
    {
        dotnet new sln --name $SolutionName
        Write-Host "✓ Created solution: $($SolutionName).sln" -ForegroundColor Green
    }
    catch
    {
        write-error "Failed to create solution: $_"
        exit 1
    }

    # Step 4: Create console application project
    Write-Host "Creating console application project..." -ForegroundColor Green
    try
    {
        dotnet new console -n $AppProjectName --force
        Write-Host "✓ Created project: $AppProjectName" -ForegroundColor Green
    }
    catch
    {
        Write-Error "Failed to create console project: $_"
        exit 1
    }

    # Step 5: Create xUnit test project
    Write-Host "Creating xUnit test project..." -ForegroundColor Green
    try
    {
        dotnet new xunit -n $TestProjectName --force
        Write-Host "✓ Created project: $TestProjectName" -ForegroundColor Green
    }
    catch
    {
        Write-Error "Failed to create xUnit project: $_"
        exit 1
    }

    # Step 6: Add projects to solution
    Write-Host "Adding projects to solution..." -ForegroundColor Green
    try
    {
        $AppProjectPath = Join-Path -Path $SolutionPath -ChildPath $AppProjectName -AdditionalChildPath "$AppProjectName.csproj"
        $TestProjectPath = Join-Path -Path $SolutionPath -ChildPath $TestProjectName -AdditionalChildPath "$TestProjectName.csproj"
        
        dotnet sln add "$AppProjectName\$AppProjectName.csproj"
        Write-Host "✓ Added $AppProjectName to solution" -ForegroundColor Green
        
        dotnet sln add "$TestProjectName\$TestProjectName.csproj"
        Write-Host "✓ Added $TestProjectName to solution" -ForegroundColor Green
    }
    catch
    {
        Write-Error "Failed to add projects to solution: $_"
        exit 1
    }

    # Step 7: Add test project reference to app project
    Write-Host "Adding project references..." -ForegroundColor Green
    try
    {
        Push-Location $TestProjectName
        dotnet add reference "..\$AppProjectName\$AppProjectName.csproj"
        Pop-Location
        Write-Host "✓ Added reference from test project to app project" -ForegroundColor Green
    }
    catch
    {
        Write-Error "Failed to add project reference: $_"
        exit 1
    }

    # Step 8: Rename Program.cs to Calculator.cs in app project
    Write-Host "Renaming files..." -ForegroundColor Green
    try
    {
        $AppProgramPath = Join-Path -Path $SolutionPath -ChildPath $AppProjectName -AdditionalChildPath "Program.cs"
        $AppCalculatorPath = Join-Path -Path $SolutionPath -ChildPath $AppProjectName -AdditionalChildPath "Calculator.cs"
        
        if (Test-Path $AppProgramPath)
        {
            Rename-Item -Path $AppProgramPath -NewName "Calculator.cs"
            Write-Host "✓ Renamed Program.cs to Calculator.cs in $AppProjectName" -ForegroundColor Green
        }
    }
    catch
    {
        Write-Error "Failed to rename Program.cs: $_"
        exit 1
    }

    # Step 9: Rename UnitTest1.cs to CalculatorTest.cs in test project
    try
    {
        $TestUnitPath = Join-Path -Path $SolutionPath -ChildPath $TestProjectName -AdditionalChildPath "UnitTest1.cs"
        
        if (Test-Path $TestUnitPath)
        {
            Rename-Item -Path $TestUnitPath -NewName "CalculatorTest.cs"
            Write-Host "✓ Renamed UnitTest1.cs to CalculatorTest.cs in $TestProjectName" -ForegroundColor Green
        }
    }
    catch
    {
        Write-Error "Failed to rename UnitTest1.cs: $_"
        exit 1
    }

    # Step 10: Update target framework in app project
    Write-Host "Updating project configurations..." -ForegroundColor Green
    try
    {
        $AppCsprojPath = Join-Path -Path $SolutionPath -ChildPath $AppProjectName -AdditionalChildPath "$AppProjectName.csproj"
        
        $csprojContent = Get-Content -Path $AppCsprojPath -Raw
        $csprojContent = $csprojContent -replace '<TargetFramework>.*?</TargetFramework>', "<TargetFramework>$TargetFramework</TargetFramework>"
        Set-Content -Path $AppCsprojPath -Value $csprojContent -NoNewline
        
        Write-Host "✓ Updated TargetFramework to $TargetFramework in $AppProjectName" -ForegroundColor Green
    }
    catch
    {
        Write-Error "Failed to update app project: $_"
        exit 1
    }

    # Step 11: Update target framework and package versions in test project
    try
    {
        $TestCsprojPath = Join-Path -Path $SolutionPath -ChildPath $TestProjectName -AdditionalChildPath "$TestProjectName.csproj"
        
        $testCsprojContent = Get-Content -Path $TestCsprojPath -Raw
        
        # Update target framework
        $testCsprojContent = $testCsprojContent -replace '<TargetFramework>.*?</TargetFramework>', "<TargetFramework>$TargetFramework</TargetFramework>"
        
        # Add SuppressTfmSupportBuildErrors to PropertyGroup
        if ($testCsprojContent -notmatch 'SuppressTfmSupportBuildErrors')
        {
            $testCsprojContent = $testCsprojContent -replace '(<PropertyGroup>)', "`$1`n    <SuppressTfmSupportBuildErrors>true</SuppressTfmSupportBuildErrors>"
        }
        
        # Update package versions for .NET 8.0 compatibility
        $testCsprojContent = $testCsprojContent -replace 'xunit" Version="[^"]*"', 'xunit" Version="2.6.2"'
        $testCsprojContent = $testCsprojContent -replace 'xunit.runner.visualstudio" Version="[^"]*"', 'xunit.runner.visualstudio" Version="2.5.1"'
        $testCsprojContent = $testCsprojContent -replace 'Microsoft.NET.Test.Sdk" Version="[^"]*"', 'Microsoft.NET.Test.Sdk" Version="17.5.0"'
        $testCsprojContent = $testCsprojContent -replace 'coverlet.collector" Version="[^"]*"', 'coverlet.collector" Version="6.0.0"'
        
        Set-Content -Path $TestCsprojPath -Value $testCsprojContent -NoNewline
        
        Write-Host "✓ Updated TargetFramework to $TargetFramework in $TestProjectName" -ForegroundColor Green
        Write-Host "✓ Updated package versions for .NET 8.0 compatibility" -ForegroundColor Green
        Write-Host "  - xunit: 2.6.2" -ForegroundColor Cyan
        Write-Host "  - xunit.runner.visualstudio: 2.5.1" -ForegroundColor Cyan
        Write-Host "  - Microsoft.NET.Test.Sdk: 17.5.0" -ForegroundColor Cyan
        Write-Host "  - coverlet.collector: 6.0.0" -ForegroundColor Cyan
    }
    catch
    {
        Write-Error "Failed to update test project: $_"
        exit 1
    }

    # Step 12: Build the solution
    Write-Host ""
    Write-Host "Building solution..." -ForegroundColor Green
    try
    {
        dotnet build
        Write-Host "✓ Solution built successfully" -ForegroundColor Green
    }
    catch
    {
        Write-Error "Failed to build solution: $_"
        exit 1
    }

    # Success message
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Setup Complete!" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Solution Location: $SolutionPath" -ForegroundColor Green
    Write-Host "Solution Name: $SolutionName" -ForegroundColor Green
    Write-Host "App Project: $AppProjectName" -ForegroundColor Green
    Write-Host "Test Project: $TestProjectName" -ForegroundColor Green
    Write-Host "Target Framework: $TargetFramework" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Implement calculator logic in $SolutionPath\$AppProjectName\Calculator.cs" -ForegroundColor Yellow
    Write-Host "2. Implement tests in $SolutionPath\$TestProjectName\CalculatorTest.cs" -ForegroundColor Yellow
    Write-Host "3. Run 'dotnet test' to execute tests" -ForegroundColor Yellow
    Write-Host ""
}
catch
{
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Setup Failed!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
finally
{
    Pop-Location -ErrorAction SilentlyContinue
}

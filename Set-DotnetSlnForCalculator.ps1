#Requires -Version 5.1
<#
.SYNOPSIS
    Sets up a complete .NET 8.0 console calculator solution with xUnit testing framework.

.DESCRIPTION
    This script automates the creation of a well-structured .NET 8.0 solution including:
    - Console application project (calculator)
    - xUnit test project (calculator.tests)
    - Proper project references and dependencies
    - Compatible package versions for .NET 8.0
    - Build verification

.EXAMPLE
    PS> .\Set-DotnetSlnForCalculator.ps1

.NOTES
    Prerequisites:
    - .NET 8.0 SDK installed and in PATH
    - PowerShell 5.0 or later
    - Write permissions to workspace directory
    - Git repository initialized
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Configuration
$SolutionName = 'calculator-xunit-testing'
$ConsoleProjectName = 'calculator'
$TestProjectName = 'calculator.tests'
$TargetFramework = 'net8.0'

# Specify exact package versions (critical for .NET 8.0 compatibility)
$XunitVersion = '2.6.2'
$XunitRunnerVersion = '2.5.1'
$NetTestSdkVersion = '17.5.0'
$CoverletVersion = '6.0.0'

# Import color support for better output
function Write-Status {
    param(
        [string]$Message,
        [ValidateSet('Info', 'Success', 'Warning', 'Error')]
        [string]$Level = 'Info'
    )
    
    $color = @{
        'Info'    = 'Cyan'
        'Success' = 'Green'
        'Warning' = 'Yellow'
        'Error'   = 'Red'
    }
    
    Write-Host "[$Level] $Message" -ForegroundColor $color[$Level]
}

# Detect repository root
Write-Status 'Detecting git repository root...' 'Info'
try {
    $RepositoryRoot = git rev-parse --show-toplevel
    Write-Status "Repository root: $RepositoryRoot" 'Success'
}
catch {
    Write-Status "Failed to detect repository root: $_" 'Error'
    exit 1
}
# end try-catch

# Define solution directory path
$SolutionDir = Join-Path -Path $RepositoryRoot -ChildPath 'programming' `
    | Join-Path -ChildPath 'dotnet' `
    | Join-Path -ChildPath 'csharp' `
    | Join-Path -ChildPath 'workspace' `
    | Join-Path -ChildPath $SolutionName
Write-Status "Solution directory: $SolutionDir" 'Info'

# Create solution directory
Write-Status 'Creating solution directory...' 'Info'
try {
    if (-not (Test-Path -Path $SolutionDir)) {
        New-Item -ItemType Directory -Path $SolutionDir -Force | Out-Null
        Write-Status "Directory created: $SolutionDir" 'Success'
    }
    else {
        Write-Status "Directory already exists: $SolutionDir" 'Warning'
    }
}
catch {
    Write-Status "Failed to create directory: $_" 'Error'
    exit 1
}
# end try-catch

# Change to solution directory
Push-Location $SolutionDir
Write-Status "Working directory: $(Get-Location)" 'Info'

try {
    # Initialize solution
    Write-Status "Creating solution file ($SolutionName.slnx)..." 'Info'
    & dotnet new sln --name $SolutionName --force 2>&1 | Out-Null
    
    if (Test-Path -Path "$SolutionName.slnx") {
        Write-Status "Solution file created successfully" 'Success'
    }
    else {
        Write-Status "Solution file creation failed" 'Error'
        exit 1
    }
    # end if-else
    
    # Create console application project
    Write-Status "Creating console application project ($ConsoleProjectName)..." 'Info'
    & dotnet new console --name $ConsoleProjectName --force 2>&1 | Out-Null
    
    $ConsoleProjectFile = Join-Path -Path $ConsoleProjectName -ChildPath "$ConsoleProjectName.csproj"
    if (Test-Path -Path $ConsoleProjectFile) {
        Write-Status "Console project created successfully" 'Success'
    }
    else {
        Write-Status "Console project creation failed" 'Error'
        exit 1
    }
    # end if-else
    
    # Update console project target framework
    Write-Status "Updating console project target framework to $TargetFramework..." 'Info'
    $ConsoleProjectFullPath = Join-Path -Path $SolutionDir -ChildPath $ConsoleProjectName | Join-Path -ChildPath "$ConsoleProjectName.csproj"
    [xml]$ConsoleProjectXml = Get-Content -Path $ConsoleProjectFullPath
    $ConsoleProjectXml.Project.PropertyGroup.TargetFramework = $TargetFramework
    $ConsoleProjectXml.Save($ConsoleProjectFullPath)
    Write-Status "Target framework updated" 'Success'
    
    # Rename Program.cs to Calculator.cs in console project
    Write-Status "Renaming Program.cs to Calculator.cs..." 'Info'
    $ProgramFile = Join-Path -Path $SolutionDir -ChildPath $ConsoleProjectName | Join-Path -ChildPath 'Program.cs'
    $CalculatorFile = Join-Path -Path $SolutionDir -ChildPath $ConsoleProjectName | Join-Path -ChildPath 'Calculator.cs'
    
    if (Test-Path -Path $ProgramFile) {
        Move-Item -Path $ProgramFile -Destination $CalculatorFile -Force
        Write-Status "File renamed successfully" 'Success'
    }
    else {
        Write-Status "Program.cs not found for renaming" 'Warning'
    }
    # end if-else
    
    # Create xUnit test project
    Write-Status "Creating xUnit test project ($TestProjectName)..." 'Info'
    & dotnet new xunit --name $TestProjectName --force 2>&1 | Out-Null
    
    $TestProjectFile = Join-Path -Path $TestProjectName -ChildPath "$TestProjectName.csproj"
    if (Test-Path -Path $TestProjectFile) {
        Write-Status "Test project created successfully" 'Success'
    }
    else {
        Write-Status "Test project creation failed" 'Error'
        exit 1
    }
    # end if-else
    
    # Update test project configuration
    Write-Status "Configuring test project (.csproj)..." 'Info'
    $TestProjectFullPath = Join-Path -Path $SolutionDir -ChildPath $TestProjectName | Join-Path -ChildPath "$TestProjectName.csproj"
    [xml]$TestProjectXml = Get-Content -Path $TestProjectFullPath
    
    # Set target framework
    $TestProjectXml.Project.PropertyGroup.TargetFramework = $TargetFramework
    
    # Add SuppressTfmSupportBuildErrors (required for xUnit with .NET 8.0)
    $PropertyGroup = $TestProjectXml.Project.PropertyGroup
    
    # Check if the element already exists using SelectSingleNode
    $SuppressNode = $PropertyGroup.SelectSingleNode('SuppressTfmSupportBuildErrors')
    if ($null -eq $SuppressNode) {
        $Element = $TestProjectXml.CreateElement('SuppressTfmSupportBuildErrors')
        $Element.InnerText = 'true'
        $PropertyGroup.AppendChild($Element) | Out-Null
        Write-Status "Added SuppressTfmSupportBuildErrors flag" 'Success'
    }
    else {
        Write-Status "SuppressTfmSupportBuildErrors already exists" 'Info'
    }
    
    # Update package versions to exact compatible versions
    Write-Status "Updating NuGet package versions..." 'Info'
    $ItemGroupNode = $TestProjectXml.Project.ItemGroup[0]
    
    # Update xunit version
    $XunitNode = $ItemGroupNode.SelectSingleNode("PackageReference[@Include='xunit']")
    if ($XunitNode) {
        $XunitNode.SetAttribute('Version', $XunitVersion)
        Write-Status "xunit updated to $XunitVersion" 'Success'
    }
    
    # Update xunit.runner.visualstudio version
    $RunnerNode = $ItemGroupNode.SelectSingleNode("PackageReference[@Include='xunit.runner.visualstudio']")
    if ($RunnerNode) {
        $RunnerNode.SetAttribute('Version', $XunitRunnerVersion)
        Write-Status "xunit.runner.visualstudio updated to $XunitRunnerVersion" 'Success'
    }
    
    # Update Microsoft.NET.Test.Sdk version
    $SdkNode = $ItemGroupNode.SelectSingleNode("PackageReference[@Include='Microsoft.NET.Test.Sdk']")
    if ($SdkNode) {
        $SdkNode.SetAttribute('Version', $NetTestSdkVersion)
        Write-Status "Microsoft.NET.Test.Sdk updated to $NetTestSdkVersion" 'Success'
    }
    
    # Update coverlet.collector version
    $CoverletNode = $ItemGroupNode.SelectSingleNode("PackageReference[@Include='coverlet.collector']")
    if ($CoverletNode) {
        $CoverletNode.SetAttribute('Version', $CoverletVersion)
        Write-Status "coverlet.collector updated to $CoverletVersion" 'Success'
    }
    
    # Add project reference from test to console project
    if (-not $ItemGroupNode.SelectSingleNode("ProjectReference[@Include='../$ConsoleProjectName/$ConsoleProjectName.csproj']")) {
        $ProjRefElement = $TestProjectXml.CreateElement('ProjectReference')
        $ProjRefElement.SetAttribute('Include', "../$ConsoleProjectName/$ConsoleProjectName.csproj")
        $ItemGroupNode.AppendChild($ProjRefElement) | Out-Null
        Write-Status "Project reference added from test to console project" 'Success'
    }
    
    $TestProjectXml.Save($TestProjectFullPath)
    Write-Status "Test project configuration completed" 'Success'
    
    # Rename UnitTest1.cs to CalculatorTest.cs in test project
    Write-Status "Renaming UnitTest1.cs to CalculatorTest.cs..." 'Info'
    $UnitTestFile = Join-Path -Path $SolutionDir -ChildPath $TestProjectName | Join-Path -ChildPath 'UnitTest1.cs'
    $CalcTestFile = Join-Path -Path $SolutionDir -ChildPath $TestProjectName | Join-Path -ChildPath 'CalculatorTest.cs'
    
    if (Test-Path -Path $UnitTestFile) {
        Move-Item -Path $UnitTestFile -Destination $CalcTestFile -Force
        Write-Status "File renamed successfully" 'Success'
    }
    else {
        Write-Status "UnitTest1.cs not found for renaming" 'Warning'
    }
    # end if-else
    
    # Add projects to solution
    Write-Status "Adding projects to solution..." 'Info'
    $SolutionFile = "$SolutionName.slnx"
    & dotnet sln $SolutionFile add $ConsoleProjectName/$ConsoleProjectName.csproj 2>&1 | Out-Null
    & dotnet sln $SolutionFile add $TestProjectName/$TestProjectName.csproj 2>&1 | Out-Null
    Write-Status "Projects added to solution" 'Success'
    
    # Restore packages
    Write-Status "Restoring NuGet packages..." 'Info'
    & dotnet restore 2>&1 | Out-Null
    Write-Status "Packages restored successfully" 'Success'
    
    # Build verification
    Write-Status "Verifying build..." 'Info'
    $BuildResult = & dotnet build 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Status "Build verification successful" 'Success'
    }
    else {
        Write-Status "Build verification failed" 'Warning'
        Write-Host $BuildResult -ForegroundColor Yellow
    }
    # end if-else
    
    # Display setup summary
    Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
    Write-Status "Solution Setup Complete" 'Success'
    Write-Host ("=" * 60) -ForegroundColor Cyan
    
    Write-Host "`nSolution Details:" -ForegroundColor Cyan
    Write-Host "  Root Directory:   $SolutionDir"
    Write-Host "  Solution File:    $SolutionName.slnx"
    Write-Host "  Console Project:  $ConsoleProjectName/$ConsoleProjectName.csproj"
    Write-Host "  Test Project:     $TestProjectName/$TestProjectName.csproj"
    Write-Host "  Target Framework: $TargetFramework"
    
    Write-Host "`nPackage Versions:" -ForegroundColor Cyan
    Write-Host "  xunit:                    $XunitVersion"
    Write-Host "  xunit.runner.visualstudio: $XunitRunnerVersion"
    Write-Host "  Microsoft.NET.Test.Sdk:   $NetTestSdkVersion"
    Write-Host "  coverlet.collector:        $CoverletVersion"
    
    Write-Host "`nNext Steps:" -ForegroundColor Cyan
    Write-Host "  1. Implement calculator logic in $ConsoleProjectName/Calculator.cs"
    Write-Host "  2. Implement test cases in $TestProjectName/CalculatorTest.cs"
    Write-Host "  3. Run tests: dotnet test"
    Write-Host "  4. Build project: dotnet build"
    
    Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
    Write-Host ""
    
}
catch {
    Write-Status "Setup failed with error: $_" 'Error'
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
}
# end try-catch
finally {
    Pop-Location
}
# end finally

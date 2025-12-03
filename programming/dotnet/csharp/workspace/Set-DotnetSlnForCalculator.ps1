<#
.SYNOPSIS
    Sets up a .NET solution for a calculator application with xUnit testing.

.DESCRIPTION
    This script creates a complete .NET 8 solution structure including:
    - A solution folder named 'calculator-xunit-testing'
    - A console application project named 'calculator'
    - An xUnit test project named 'calculator.tests'
    - Appropriate project references
    - Renamed default files (Program.cs to Calculator.cs, UnitTest1.cs to CalculatorTest.cs)

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    
    Creates the calculator solution structure in the current directory.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : .NET 8 SDK must be installed
    Version        : 2.0
    
    Requirements:
    - .NET 8 SDK
    - PowerShell 5.1 or higher
    
    Change Log:
    - Version 2.0: Refactored to follow SOLID principles, added pure functions and logging
    - Version 1.0: Initial creation

#>

#region Logging Functions

function hwLog
{
    <#
    .SYNOPSIS
        Internal telemetry wrapper for logging.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('Info', 'Success', 'Warning', 'Error')]
        [string]$Level = 'Info'
    )
    
    $colorMap = @{
        'Info' = 'Cyan'
        'Success' = 'Green'
        'Warning' = 'Yellow'
        'Error' = 'Red'
    }
    
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Write-Host "[$timestamp] [$Level] $Message" -ForegroundColor $colorMap[$Level]
} #end hwLog

#endregion

#region Pure Functions

function Get-WorkspacePath
{
    <#
    .SYNOPSIS
        Pure function to resolve workspace path from repository root.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$RepoRoot
    )
    
    return Join-Path -Path $RepoRoot -ChildPath "programming\dotnet\csharp\workspace"
} #end Get-WorkspacePath

function Get-SolutionConfiguration
{
    <#
    .SYNOPSIS
        Pure function to return solution configuration object.
    #>
    return [PSCustomObject]@{
        SolutionFolder = "calculator-xunit-testing"
        SolutionName = "calculator"
        ConsoleProjectName = "calculator"
        TestProjectName = "calculator.tests"
        TargetFramework = "net8.0"
    }
} #end Get-SolutionConfiguration

function Get-FileRenameMappings
{
    <#
    .SYNOPSIS
        Pure function to return file rename mappings.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Config
    )
    
    return @(
        @{
            ProjectPath = $Config.ConsoleProjectName
            OldFileName = "Program.cs"
            NewFileName = "Calculator.cs"
            ContentReplace = $null
        },
        @{
            ProjectPath = $Config.TestProjectName
            OldFileName = "UnitTest1.cs"
            NewFileName = "CalculatorTest.cs"
            ContentReplace = @{
                Pattern = 'public class UnitTest1'
                Replacement = 'public class CalculatorTest'
            }
        }
    )
} #end Get-FileRenameMappings

#endregion

#region Directory Operations

function New-SolutionDirectory
{
    <#
    .SYNOPSIS
        Creates solution directory and navigates to it.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [string]$FolderName
    )
    
    try
    {
        hwLog "Creating solution folder: $FolderName" -Level Info
        $fullPath = Join-Path -Path $Path -ChildPath $FolderName
        New-Item -ItemType Directory -Path $fullPath -Force -ErrorAction Stop | Out-Null
        Set-Location -Path $fullPath -ErrorAction Stop
        hwLog "Successfully created and navigated to: $fullPath" -Level Success
        return $true
    }
    catch
    {
        hwLog "Failed to create solution directory: $_" -Level Error
        return $false
    }
} #end New-SolutionDirectory

#endregion

#region Solution Operations

function New-DotnetSolution
{
    <#
    .SYNOPSIS
        Creates a new .NET solution.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$SolutionName
    )
    
    try
    {
        hwLog "Creating solution: $SolutionName.sln" -Level Info
        dotnet new sln -n $SolutionName
        hwLog "Solution created successfully" -Level Success
        return $true
    }
    catch
    {
        hwLog "Failed to create solution: $_" -Level Error
        return $false
    }
} #end New-DotnetSolution

function New-DotnetProject
{
    <#
    .SYNOPSIS
        Creates a new .NET project using specified template.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectName,
        
        [Parameter(Mandatory=$true)]
        [ValidateSet('console', 'xunit', 'classlib')]
        [string]$Template,
        
        [Parameter(Mandatory=$true)]
        [string]$Framework
    )
    
    try
    {
        hwLog "Creating $Template project: $ProjectName" -Level Info
        dotnet new $Template -n $ProjectName -f $Framework
        hwLog "Project created successfully" -Level Success
        return $true
    }
    catch
    {
        hwLog "Failed to create project: $_" -Level Error
        return $false
    }
} #end New-DotnetProject

function Add-ProjectToSolution
{
    <#
    .SYNOPSIS
        Adds a project to the solution.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectPath
    )
    
    try
    {
        hwLog "Adding project to solution: $ProjectPath" -Level Info
        dotnet sln add $ProjectPath
        hwLog "Project added successfully" -Level Success
        return $true
    }
    catch
    {
        hwLog "Failed to add project to solution: $_" -Level Error
        return $false
    }
} #end Add-ProjectToSolution

function Add-ProjectReference
{
    <#
    .SYNOPSIS
        Adds a project reference to another project.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$SourceProject,
        
        [Parameter(Mandatory=$true)]
        [string]$ReferenceProject
    )
    
    try
    {
        hwLog "Adding reference from $SourceProject to $ReferenceProject" -Level Info
        dotnet add $SourceProject reference $ReferenceProject
        hwLog "Reference added successfully" -Level Success
        return $true
    }
    catch
    {
        hwLog "Failed to add project reference: $_" -Level Error
        return $false
    }
} #end Add-ProjectReference

#endregion

#region File Operations

function Rename-ProjectFile
{
    <#
    .SYNOPSIS
        Renames a file in a project and optionally updates its content.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$RenameMapping
    )
    
    try
    {
        $oldPath = Join-Path -Path $RenameMapping.ProjectPath -ChildPath $RenameMapping.OldFileName
        $newPath = Join-Path -Path $RenameMapping.ProjectPath -ChildPath $RenameMapping.NewFileName
        
        if (Test-Path -Path $oldPath)
        {
            hwLog "Renaming $($RenameMapping.OldFileName) to $($RenameMapping.NewFileName)" -Level Info
            Rename-Item -Path $oldPath -NewName $RenameMapping.NewFileName -ErrorAction Stop
            
            if ($RenameMapping.ContentReplace)
            {
                $content = Get-Content -Path $newPath -Raw -ErrorAction Stop
                $content = $content -replace $RenameMapping.ContentReplace.Pattern, $RenameMapping.ContentReplace.Replacement
                Set-Content -Path $newPath -Value $content -ErrorAction Stop
                hwLog "Content updated successfully" -Level Success
            }
            
            hwLog "File renamed successfully" -Level Success
            return $true
        }
        else
        {
            hwLog "Source file not found: $oldPath" -Level Warning
            return $false
        }
    }
    catch
    {
        hwLog "Failed to rename file: $_" -Level Error
        return $false
    }
} #end Rename-ProjectFile

#endregion

#region Build Operations

function Invoke-SolutionBuild
{
    <#
    .SYNOPSIS
        Builds the solution to verify setup.
    #>
    try
    {
        hwLog "Building solution to verify setup" -Level Info
        dotnet build
        hwLog "Build completed successfully" -Level Success
        return $true
    }
    catch
    {
        hwLog "Build failed: $_" -Level Error
        return $false
    }
} #end Invoke-SolutionBuild

#endregion

#region Display Operations

function Show-CompletionMessage
{
    <#
    .SYNOPSIS
        Displays completion message with next steps.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$SolutionLocation,
        
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Config
    )
    
    hwLog "Solution setup completed successfully!" -Level Success
    hwLog "Solution location: $SolutionLocation" -Level Success
    
    Write-Host ""
    hwLog "Next steps:" -Level Warning
    Write-Host "1. Navigate to: cd $($Config.SolutionFolder)" -ForegroundColor White
    Write-Host "2. Implement calculator logic in: $($Config.ConsoleProjectName)\Calculator.cs" -ForegroundColor White
    Write-Host "3. Write tests in: $($Config.TestProjectName)\CalculatorTest.cs" -ForegroundColor White
    Write-Host "4. Run tests with: dotnet test" -ForegroundColor White
    Write-Host "5. Run the calculator with: dotnet run --project $($Config.ConsoleProjectName)" -ForegroundColor White
} #end Show-CompletionMessage

#endregion

#region Main Execution

function Initialize-CalculatorSolution
{
    <#
    .SYNOPSIS
        Main orchestration function following Single Responsibility Principle.
    #>
    try
    {
        # Get configuration
        $repoRoot = git rev-parse --show-toplevel
        $workspacePath = Get-WorkspacePath -RepoRoot $repoRoot
        $config = Get-SolutionConfiguration
        
        hwLog "Starting calculator solution setup" -Level Info
        
        # Navigate to workspace
        Set-Location -Path $workspacePath
        
        # Create solution directory
        if (-not (New-SolutionDirectory -Path $workspacePath -FolderName $config.SolutionFolder))
        {
            throw "Failed to create solution directory"
        }
        
        # Create solution
        if (-not (New-DotnetSolution -SolutionName $config.SolutionName))
        {
            throw "Failed to create solution"
        }
        
        # Create console project
        if (-not (New-DotnetProject -ProjectName $config.ConsoleProjectName -Template 'console' -Framework $config.TargetFramework))
        {
            throw "Failed to create console project"
        }
        
        # Create test project
        if (-not (New-DotnetProject -ProjectName $config.TestProjectName -Template 'xunit' -Framework $config.TargetFramework))
        {
            throw "Failed to create test project"
        }
        
        # Add projects to solution
        Add-ProjectToSolution -ProjectPath "$($config.ConsoleProjectName)\$($config.ConsoleProjectName).csproj" | Out-Null
        Add-ProjectToSolution -ProjectPath "$($config.TestProjectName)\$($config.TestProjectName).csproj" | Out-Null
        
        # Add project reference
        Add-ProjectReference -SourceProject "$($config.TestProjectName)\$($config.TestProjectName).csproj" `
                            -ReferenceProject "$($config.ConsoleProjectName)\$($config.ConsoleProjectName).csproj" | Out-Null
        
        # Rename files
        $renameMappings = Get-FileRenameMappings -Config $config
        foreach ($mapping in $renameMappings)
        {
            Rename-ProjectFile -RenameMapping $mapping | Out-Null
        }
        
        # Build solution
        Invoke-SolutionBuild | Out-Null
        
        # Display completion message
        Show-CompletionMessage -SolutionLocation "$workspacePath\$($config.SolutionFolder)" -Config $config
        
        return $true
    }
    catch
    {
        hwLog "Solution setup failed: $_" -Level Error
        return $false
    }
} #end Initialize-CalculatorSolution

# Execute main function
Initialize-CalculatorSolution

#endregion

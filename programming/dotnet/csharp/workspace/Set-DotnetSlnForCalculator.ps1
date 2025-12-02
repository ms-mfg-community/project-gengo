<#
.SYNOPSIS
    Sets up the .NET solution structure for the calculator application with xUnit testing.

.DESCRIPTION
    This script creates a complete .NET 8 solution structure including:
    - A solution folder named 'calculator-xunit-testing'
    - A console application project named 'calculator'
    - An xUnit test project named 'calculator.tests'
    - Proper project references between the test and application projects
    - Renaming of default files to Calculator.cs and CalculatorTest.cs

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    
    Creates the calculator solution structure in the workspace directory.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : .NET 8 SDK must be installed
    Version        : 2.0
    
    Requirements:
    - .NET 8 SDK or later
    - PowerShell 5.1 or later
    - Write permissions in the workspace directory
    
    Change Log:
    - Version 2.0: Refactored to use pure functions and SOLID principles
#>

#region Logging Functions

function hwLog {
    <#
    .SYNOPSIS
        Internal telemetry wrapper for logging.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('Info', 'Warning', 'Error', 'Success')]
        [string]$Level = 'Info'
    )
    
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $colorMap = @{
        'Info' = 'Cyan'
        'Warning' = 'Yellow'
        'Error' = 'Red'
        'Success' = 'Green'
    } # end colorMap
    
    $color = $colorMap[$Level]
    Write-Host "[$timestamp] [$Level] $Message" -ForegroundColor $color
} # end hwLog

#endregion

#region Pure Functions

function Get-RepositoryRoot {
    <#
    .SYNOPSIS
        Pure function to retrieve repository root path.
    #>
    [OutputType([string])]
    param()
    
    $root = git rev-parse --show-toplevel 2>$null
    return $root
} # end Get-RepositoryRoot

function Get-WorkspacePath {
    <#
    .SYNOPSIS
        Pure function to construct workspace path from repository root.
    #>
    [OutputType([string])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$RepoRoot
    )
    
    return Join-Path $RepoRoot "programming\dotnet\csharp\workspace"
} # end Get-WorkspacePath

function Get-SolutionDirectoryPath {
    <#
    .SYNOPSIS
        Pure function to construct solution directory path.
    #>
    [OutputType([string])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$WorkspacePath,
        
        [Parameter(Mandatory=$false)]
        [string]$SolutionName = "calculator-xunit-testing"
    )
    
    return Join-Path $WorkspacePath $SolutionName
} # end Get-SolutionDirectoryPath

function Test-DirectoryExists {
    <#
    .SYNOPSIS
        Pure function to check directory existence.
    #>
    [OutputType([bool])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    return Test-Path $Path
} # end Test-DirectoryExists

#endregion

#region Strategy Pattern for Operations

class SolutionOperation {
    [string]$Name
    [scriptblock]$Execute
    [string]$SuccessMessage
    
    SolutionOperation([string]$name, [scriptblock]$execute, [string]$successMessage) {
        $this.Name = $name
        $this.Execute = $execute
        $this.SuccessMessage = $successMessage
    } # end constructor
} # end SolutionOperation

function Get-SolutionOperations {
    <#
    .SYNOPSIS
        Factory function that returns strategy operations for solution setup.
    #>
    [OutputType([SolutionOperation[]])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SolutionDir,
        
        [Parameter(Mandatory=$true)]
        [string]$SolutionName
    )
    
    $operations = @(
        [SolutionOperation]::new(
            "CreateSolution",
            { dotnet new sln -n $SolutionName },
            "Solution created successfully"
        ),
        
        [SolutionOperation]::new(
            "CreateConsoleProject",
            { dotnet new console -n calculator -f net8.0 },
            "Console application project created"
        ),
        
        [SolutionOperation]::new(
            "CreateTestProject",
            { dotnet new xunit -n calculator.tests -f net8.0 },
            "xUnit test project created"
        ),
        
        [SolutionOperation]::new(
            "AddConsoleToSolution",
            { dotnet sln add calculator/calculator.csproj },
            "Console project added to solution"
        ),
        
        [SolutionOperation]::new(
            "AddTestToSolution",
            { dotnet sln add calculator.tests/calculator.tests.csproj },
            "Test project added to solution"
        ),
        
        [SolutionOperation]::new(
            "AddProjectReference",
            { dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj },
            "Project reference added"
        )
    )
    
    return $operations
} # end Get-SolutionOperations

function Invoke-SolutionOperation {
    <#
    .SYNOPSIS
        Executes a single solution operation with logging.
    #>
    [OutputType([bool])]
    param(
        [Parameter(Mandatory=$true)]
        [SolutionOperation]$Operation
    )
    
    hwLog -Message "Executing: $($Operation.Name)" -Level Info
    
    try {
        & $Operation.Execute
        hwLog -Message $Operation.SuccessMessage -Level Success
        return $true
    }
    catch {
        hwLog -Message "Failed to execute $($Operation.Name): $_" -Level Error
        return $false
    } # end try-catch
} # end Invoke-SolutionOperation

#endregion

#region File Operations

function Invoke-FileRename {
    <#
    .SYNOPSIS
        Pure function to rename a file with validation.
    #>
    [OutputType([bool])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SourcePath,
        
        [Parameter(Mandatory=$true)]
        [string]$DestinationPath,
        
        [Parameter(Mandatory=$true)]
        [string]$Description
    )
    
    hwLog -Message "Renaming: $Description" -Level Info
    
    if (-not (Test-Path $SourcePath)) {
        hwLog -Message "Source file not found: $SourcePath" -Level Warning
        return $false
    } # end if
    
    try {
        Move-Item -Path $SourcePath -Destination $DestinationPath -Force
        hwLog -Message "Successfully renamed $Description" -Level Success
        return $true
    }
    catch {
        hwLog -Message "Failed to rename $Description`: $_" -Level Error
        return $false
    } # end try-catch
} # end Invoke-FileRename

function Invoke-SolutionFileRenames {
    <#
    .SYNOPSIS
        Executes all file rename operations for the solution.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$SolutionDir
    )
    
    $renames = @(
        @{
            Source = Join-Path $SolutionDir "calculator/Program.cs"
            Destination = Join-Path $SolutionDir "calculator/Calculator.cs"
            Description = "Program.cs to Calculator.cs"
        },
        @{
            Source = Join-Path $SolutionDir "calculator.tests/UnitTest1.cs"
            Destination = Join-Path $SolutionDir "calculator.tests/CalculatorTest.cs"
            Description = "UnitTest1.cs to CalculatorTest.cs"
        }
    )
    
    foreach ($rename in $renames) {
        Invoke-FileRename -SourcePath $rename.Source -DestinationPath $rename.Destination -Description $rename.Description | Out-Null
    } # end foreach
} # end Invoke-SolutionFileRenames

#endregion

#region Directory Management

function Initialize-SolutionDirectory {
    <#
    .SYNOPSIS
        Ensures solution directory exists and is clean.
    #>
    [OutputType([bool])]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    if (Test-DirectoryExists -Path $Path) {
        hwLog -Message "Solution directory exists. Removing for clean setup..." -Level Warning
        try {
            Remove-Item -Path $Path -Recurse -Force
            hwLog -Message "Existing directory removed" -Level Success
        }
        catch {
            hwLog -Message "Failed to remove existing directory: $_" -Level Error
            return $false
        } # end try-catch
    } # end if
    
    try {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
        hwLog -Message "Solution directory created: $Path" -Level Success
        return $true
    }
    catch {
        hwLog -Message "Failed to create directory: $_" -Level Error
        return $false
    } # end try-catch
} # end Initialize-SolutionDirectory

#endregion

#region Main Execution

function Invoke-CalculatorSolutionSetup {
    <#
    .SYNOPSIS
        Main orchestration function following Single Responsibility Principle.
    #>
    param()
    
    hwLog -Message "Starting calculator solution setup" -Level Info
    
    # Validate repository context
    $repoRoot = Get-RepositoryRoot
    if (-not $repoRoot) {
        hwLog -Message "Not in a git repository. Please run from within the repository." -Level Error
        return 1
    } # end if
    
    # Calculate paths
    $workspacePath = Get-WorkspacePath -RepoRoot $repoRoot
    $solutionName = "calculator-xunit-testing"
    $solutionDir = Get-SolutionDirectoryPath -WorkspacePath $workspacePath -SolutionName $solutionName
    
    hwLog -Message "Solution will be created at: $solutionDir" -Level Info
    
    # Initialize directory
    if (-not (Initialize-SolutionDirectory -Path $solutionDir)) {
        return 1
    } # end if
    
    # Store original location
    $originalLocation = Get-Location
    
    try {
        Set-Location $solutionDir
        
        # Execute all solution operations using strategy pattern
        $operations = Get-SolutionOperations -SolutionDir $solutionDir -SolutionName $solutionName
        
        foreach ($operation in $operations) {
            if (-not (Invoke-SolutionOperation -Operation $operation)) {
                hwLog -Message "Setup aborted due to operation failure" -Level Error
                return 1
            } # end if
        } # end foreach
        
        # Perform file renames
        Invoke-SolutionFileRenames -SolutionDir $solutionDir
        
        # Success summary
        hwLog -Message "Solution structure created successfully!" -Level Success
        hwLog -Message "Solution location: $solutionDir" -Level Info
        hwLog -Message "Next steps:" -Level Info
        Write-Host "  1. Navigate to: cd $solutionDir" -ForegroundColor White
        Write-Host "  2. Build: dotnet build" -ForegroundColor White
        Write-Host "  3. Test: dotnet test" -ForegroundColor White
        Write-Host "  4. Run: dotnet run --project calculator" -ForegroundColor White
        
        return 0
    }
    catch {
        hwLog -Message "An error occurred during setup: $_" -Level Error
        return 1
    }
    finally {
        Set-Location $originalLocation
    } # end try-catch-finally
} # end Invoke-CalculatorSolutionSetup

#endregion

# Execute main function
$exitCode = Invoke-CalculatorSolutionSetup
hwLog -Message "Setup complete with exit code: $exitCode" -Level $(if ($exitCode -eq 0) { 'Success' } else { 'Error' })
exit $exitCode

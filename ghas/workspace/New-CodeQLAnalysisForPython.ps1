#Requires -Version 5.1

<#
.SYNOPSIS
    Automates CodeQL analysis for Python codebases to identify security vulnerabilities.

.DESCRIPTION
    This script uses the CodeQL CLI to analyze Python code for security vulnerabilities,
    specifically focused on detecting weakened or disabled Cross-Site Request Forgery (CSRF) protection.
    It creates a CodeQL database, runs security queries, generates SARIF results, and uploads them to GitHub.

.PARAMETER SourceDirectory
    The directory containing the Python source code to analyze. Defaults to the git repository root.

.PARAMETER DatabaseName
    The name of the CodeQL database to create. Defaults to 'codeql-dbs'.

.PARAMETER OutputFile
    The name of the SARIF output file. Defaults to 'python-results.sarif'.

.PARAMETER Threads
    The number of threads to use for analysis. Defaults to 4.

.PARAMETER Repository
    The GitHub repository in the format 'owner/repo'. Defaults to 'ms-mfg-community/project-gengo'.

.PARAMETER Branch
    The branch to upload results to. Defaults to 'main'.

.PARAMETER SkipUpload
    If specified, skips the upload to GitHub and only performs local analysis.

.PARAMETER ShowLanguagesOnly
    If specified, only shows available languages and exits.

.EXAMPLE
    .\New-CodeQLAnalysisForPython.ps1
    Runs a complete CodeQL analysis with default settings.

.EXAMPLE
    .\New-CodeQLAnalysisForPython.ps1 -SourceDirectory "C:\MyProject" -OutputFile "my-results.sarif"
    Runs analysis on a specific directory with custom output file.

.EXAMPLE
    .\New-CodeQLAnalysisForPython.ps1 -ShowLanguagesOnly
    Shows available CodeQL languages and exits.

.EXAMPLE
    .\New-CodeQLAnalysisForPython.ps1 -SkipUpload
    Runs analysis but skips uploading results to GitHub.

.NOTES
    Author: GitHub Copilot
    Date: July 29, 2025
    Version: 1.0
    
    Prerequisites:
    - CodeQL CLI must be installed and accessible from PATH
    - Git must be installed and accessible from PATH
    - GITHUB_TOKEN environment variable must be set for uploads
    
    References:
    - CodeQL CLI Documentation: https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/about-the-codeql-cli
    - SARIF Specification: https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html
    - GitHub Security Documentation: https://docs.github.com/en/code-security
#>

[CmdletBinding()]
param(
    [Parameter()]
    [string]$SourceDirectory,
    
    [Parameter()]
    [string]$DatabaseName = "codeql-dbs",
    
    [Parameter()]
    [string]$OutputFile = "python-results.sarif",
    
    [Parameter()]
    [ValidateRange(1, 16)]
    [int]$Threads = 4,
    
    [Parameter()]
    [string]$Repository = "ms-mfg-community/project-gengo",
    
    [Parameter()]
    [string]$Branch = "main",
    
    [Parameter()]
    [switch]$SkipUpload,
    
    [Parameter()]
    [switch]$ShowLanguagesOnly
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Color output functions for better user experience
function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ️  $Message" -ForegroundColor Blue
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Header {
    param([string]$Message)
    Write-Host "`n🔍 $Message" -ForegroundColor Cyan
    Write-Host ("=" * ($Message.Length + 4)) -ForegroundColor Cyan
}

function Test-Prerequisites {
    <#
    .SYNOPSIS
    Validates that all required tools are installed and accessible.
    #>
    
    Write-Header "Checking Prerequisites"
    
    # Check CodeQL CLI
    try {
        $codeqlVersion = & codeql version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "CodeQL CLI is installed: $($codeqlVersion[0])"
        } else {
            throw "CodeQL CLI not found or not working properly"
        }
    } catch {
        Write-Error "CodeQL CLI is not installed or not in PATH. Please install from: https://github.com/github/codeql-cli-binaries"
        throw
    }
    
    # Check Git
    try {
        $gitVersion = & git --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Git is installed: $gitVersion"
        } else {
            throw "Git not found or not working properly"
        }
    } catch {
        Write-Error "Git is not installed or not in PATH. Please install Git."
        throw
    }
    
    # Check GitHub token if upload is not skipped
    if (-not $SkipUpload) {
        if ([string]::IsNullOrEmpty($env:GITHUB_TOKEN)) {
            Write-Error "GITHUB_TOKEN environment variable is not set. This is required for uploading results to GitHub."
            Write-Info "Set the token with: `$env:GITHUB_TOKEN = 'your_token_here'"
            throw "Missing GitHub token"
        } else {
            Write-Success "GitHub token is configured"
        }
    }
}

function Show-AvailableLanguages {
    <#
    .SYNOPSIS
    Displays all available languages for CodeQL analysis with improved formatting.
    #>
    
    Write-Header "Available CodeQL Languages"
    
    try {
        Write-Info "Retrieving available languages from CodeQL CLI..."
        
        # Get languages and format as JSON for better readability
        $languagesOutput = & codeql resolve languages --format=json 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            # Parse and pretty-print the JSON
            $languages = $languagesOutput | ConvertFrom-Json
            
            Write-Host "`nSupported Languages:" -ForegroundColor Yellow
            Write-Host "===================" -ForegroundColor Yellow
            
            foreach ($language in $languages) {
                Write-Host "• $($language.name)" -ForegroundColor Green
                if ($language.display_name -ne $language.name) {
                    Write-Host "  Display Name: $($language.display_name)" -ForegroundColor Gray
                }
                if ($language.description) {
                    Write-Host "  Description: $($language.description)" -ForegroundColor Gray
                }
                Write-Host ""
            }
            
            Write-Success "Found $($languages.Count) supported languages"
        } else {
            Write-Error "Failed to retrieve languages: $languagesOutput"
            throw "Language resolution failed"
        }
    } catch {
        Write-Error "Error retrieving available languages: $_"
        throw
    }
}

function New-CodeQLDatabase {
    <#
    .SYNOPSIS
    Creates a CodeQL database for Python code analysis.
    #>
    param(
        [string]$SourcePath,
        [string]$DatabasePath
    )
    
    Write-Header "Creating CodeQL Database"
    
    try {
        # Remove existing database if it exists
        if (Test-Path $DatabasePath) {
            Write-Info "Removing existing database at: $DatabasePath"
            Remove-Item -Path $DatabasePath -Recurse -Force
        }
        
        Write-Info "Creating CodeQL database for Python code..."
        Write-Info "Source directory: $SourcePath"
        Write-Info "Database path: $DatabasePath"
        
        # Create the database
        $createArgs = @(
            "database", "create"
            "--language=python"
            "--source-root=$SourcePath"
            $DatabasePath
        )
        
        Write-Info "Running: codeql $($createArgs -join ' ')"
        & codeql @createArgs
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "CodeQL database created successfully at: $DatabasePath"
        } else {
            throw "Database creation failed with exit code: $LASTEXITCODE"
        }
    } catch {
        Write-Error "Failed to create CodeQL database: $_"
        throw
    }
}

function Invoke-CodeQLAnalysis {
    <#
    .SYNOPSIS
    Analyzes the CodeQL database using standard Python security queries.
    #>
    param(
        [string]$DatabasePath,
        [string]$OutputPath,
        [int]$ThreadCount
    )
    
    Write-Header "Running CodeQL Analysis"
    
    try {
        Write-Info "Analyzing database with Python security queries..."
        Write-Info "Database: $DatabasePath"
        Write-Info "Output file: $OutputPath"
        Write-Info "Threads: $ThreadCount"
        
        # Remove existing output file if it exists
        if (Test-Path $OutputPath) {
            Remove-Item -Path $OutputPath -Force
        }
        
        # Run the analysis
        $analyzeArgs = @(
            "database", "analyze"
            "--format=sarif-latest"
            "--output=$OutputPath"
            "--threads=$ThreadCount"
            "--download"
            $DatabasePath
            "codeql/python-queries:codeql-suites/python-security-extended.qls"
        )
        
        Write-Info "Running: codeql $($analyzeArgs -join ' ')"
        & codeql @analyzeArgs
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Analysis completed successfully"
            
            # Verify output file was created
            if (Test-Path $OutputPath) {
                $fileSize = (Get-Item $OutputPath).Length
                Write-Success "SARIF results saved to: $OutputPath ($fileSize bytes)"
                
                # Parse and show basic statistics
                try {
                    $sarifContent = Get-Content $OutputPath -Raw | ConvertFrom-Json
                    $totalResults = 0
                    foreach ($run in $sarifContent.runs) {
                        if ($run.results) {
                            $totalResults += $run.results.Count
                        }
                    }
                    Write-Info "Total findings: $totalResults"
                } catch {
                    Write-Warning "Could not parse SARIF file for statistics: $_"
                }
            } else {
                throw "Output file was not created"
            }
        } else {
            throw "Analysis failed with exit code: $LASTEXITCODE"
        }
    } catch {
        Write-Error "Failed to run CodeQL analysis: $_"
        throw
    }
}

function Submit-ResultsToGitHub {
    <#
    .SYNOPSIS
    Uploads the SARIF results to GitHub for review in the Security tab.
    #>
    param(
        [string]$SarifFile,
        [string]$RepositoryName,
        [string]$BranchName
    )
    
    Write-Header "Uploading Results to GitHub"
    
    try {
        # Get current commit SHA
        $commitSha = & git rev-parse HEAD 2>&1
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to get current commit SHA: $commitSha"
        }
        
        Write-Info "Repository: $RepositoryName"
        Write-Info "Branch: $BranchName"
        Write-Info "Commit SHA: $commitSha"
        Write-Info "SARIF file: $SarifFile"
        
        # Verify SARIF file exists
        if (-not (Test-Path $SarifFile)) {
            throw "SARIF file not found: $SarifFile"
        }
        
        # Upload using GitHub CLI with token from stdin for security
        $uploadArgs = @(
            "github", "upload-results"
            "--repository=$RepositoryName"
            "--ref=refs/heads/$BranchName"
            "--commit=$commitSha"
            "--sarif=$SarifFile"
            "--github-auth-stdin"
        )
        
        Write-Info "Uploading results to GitHub..."
        Write-Info "Running: codeql $($uploadArgs -join ' ')"
        
        # Pass the GitHub token through stdin for security
        $env:GITHUB_TOKEN | & codeql @uploadArgs
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Results uploaded successfully to GitHub!"
            Write-Info "View results at: https://github.com/$RepositoryName/security/code-scanning"
        } else {
            throw "Upload failed with exit code: $LASTEXITCODE"
        }
    } catch {
        Write-Error "Failed to upload results to GitHub: $_"
        throw
    }
}

function Clear-TempFiles {
    <#
    .SYNOPSIS
    Cleans up temporary files and databases.
    #>
    param(
        [string]$DatabasePath
    )
    
    Write-Header "Cleaning Up"
    
    try {
        if (Test-Path $DatabasePath) {
            Write-Info "Removing temporary database: $DatabasePath"
            Remove-Item -Path $DatabasePath -Recurse -Force
            Write-Success "Cleanup completed"
        }
    } catch {
        Write-Warning "Failed to clean up temporary files: $_"
    }
}

# Main execution
try {
    Write-Header "CodeQL Analysis for Python - Security Vulnerability Scanner"
    Write-Info "Starting CodeQL analysis process..."
    
    # Step 1: Check prerequisites
    Test-Prerequisites
    
    # Step 2: Show languages if requested and exit
    if ($ShowLanguagesOnly) {
        Show-AvailableLanguages
        return
    }
    
    # Step 3: Determine source directory
    if ([string]::IsNullOrEmpty($SourceDirectory)) {
        $SourceDirectory = & git rev-parse --show-toplevel 2>&1
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to determine git repository root: $SourceDirectory"
        }
    }
    
    # Resolve to absolute path
    $SourceDirectory = Resolve-Path $SourceDirectory -ErrorAction Stop
    Write-Info "Source directory: $SourceDirectory"
    
    # Step 4: Prepare paths
    $DatabasePath = Join-Path (Get-Location) $DatabaseName
    $OutputPath = Join-Path (Get-Location) $OutputFile
    
    Write-Info "Database path: $DatabasePath"
    Write-Info "Output path: $OutputPath"
    
    # Step 5: Show available languages for reference
    Show-AvailableLanguages
    
    # Step 6: Create CodeQL database
    New-CodeQLDatabase -SourcePath $SourceDirectory -DatabasePath $DatabasePath
    
    # Step 7: Run analysis
    Invoke-CodeQLAnalysis -DatabasePath $DatabasePath -OutputPath $OutputPath -ThreadCount $Threads
    
    # Step 8: Upload results (if not skipped)
    if (-not $SkipUpload) {
        Submit-ResultsToGitHub -SarifFile $OutputPath -RepositoryName $Repository -BranchName $Branch
    } else {
        Write-Info "Skipping upload to GitHub (SkipUpload flag set)"
        Write-Info "Results available locally at: $OutputPath"
    }
    
    # Step 9: Clean up temporary files
    Clear-TempFiles -DatabasePath $DatabasePath
    
    Write-Header "Analysis Complete"
    Write-Success "CodeQL analysis completed successfully!"
    
    if (-not $SkipUpload) {
        Write-Info "Security findings are now available in GitHub at:"
        Write-Info "https://github.com/$Repository/security/code-scanning"
    }
    
    Write-Info "Local SARIF results: $OutputPath"
    
} catch {
    Write-Header "Analysis Failed"
    Write-Error "CodeQL analysis failed: $_"
    
    # Attempt cleanup on failure
    if ($DatabasePath -and (Test-Path $DatabasePath)) {
        try {
            Clear-TempFiles -DatabasePath $DatabasePath
        } catch {
            Write-Warning "Failed to clean up after error: $_"
        }
    }
    
    exit 1
}

# end script

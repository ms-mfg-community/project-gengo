<#
.SYNOPSIS
    Automated CodeQL security analysis for JavaScript/TypeScript calculator application.

.DESCRIPTION
    This script performs comprehensive security analysis on the calculator workspace using CodeQL.
    It creates a temporary database, runs security queries, generates SARIF results, and optionally
    uploads findings to GitHub Security tab. Perfect for GHAS workshops and security demonstrations.

.PARAMETER sourcePath
    Path to the calculator workspace directory containing JavaScript/TypeScript source files.
    Default: "..\workspace\calculator"

.PARAMETER databasePath
    Path where the temporary CodeQL database will be created and stored during analysis.
    Default: ".\calculator-db"

.PARAMETER outputPath
    Output file path for analysis results. Extension will be adjusted based on format parameter.
    Default: ".\calculator-results.sarif"

.PARAMETER language
    Programming language to analyze. Should be "javascript" for TypeScript/JavaScript projects.
    Default: "javascript"

.PARAMETER desiredQuerySuite
    CodeQL query suite to use for analysis. The security-and-quality suite provides comprehensive coverage.
    Default: "javascript-security-and-quality.qls"

.PARAMETER customQueryPath
    Path to custom CodeQL query file for additional security checks or workshop demonstrations.
    Default: ".\custom-security.ql"

.PARAMETER qlsPath
    Base path to search for CodeQL query suites and packages.
    Default: "$env:USERPROFILE\.codeql"

.PARAMETER sarifCategory
    Category tag for SARIF output, useful for organizing results in GitHub Security tab.
    Default: "calculator-analysis"

.PARAMETER format
    Output format for analysis results. Supports SARIF, CSV, JSON, and table formats.
    Default: "sarif-latest"
    Valid values: "sarif-latest", "csv", "json", "table"

.PARAMETER useCustomQueryOnly
    Switch to run only custom queries instead of the standard security suite.
    Useful for testing specific security patterns or workshop scenarios.

.PARAMETER gitHubOrg
    GitHub organization name for uploading SARIF results. Can be auto-detected with -autoDetectRepo.
    Example: "ms-mfg-community"

.PARAMETER gitHubRepo
    GitHub repository name for uploading SARIF results. Can be auto-detected with -autoDetectRepo.
    Example: "project-gengo"

.PARAMETER uploadToGitHub
    Switch to upload SARIF results to GitHub Security tab after analysis completes.
    Requires GitHub CLI authentication and security_events:write permission.

.PARAMETER autoDetectRepo
    Switch to automatically detect GitHub organization and repository from git remote origin.
    Eliminates need to manually specify -gitHubOrg and -gitHubRepo parameters.

.PARAMETER injectReDoSVulnerability
    Switch to inject a ReDoS (Regular Expression Denial of Service) vulnerability for workshop demonstrations.
    Creates vulnerable-demo.ts with intentional security issues that CodeQL will detect.

.PARAMETER remediateReDoSVulnerability
    Switch to remove the injected ReDoS vulnerability by deleting the vulnerable-demo.ts file.
    Use this to show clean security results after demonstrating vulnerabilities.

.PARAMETER forceNewAlerts
    Switch to randomize vulnerability patterns to force new GitHub alerts even if previous ones were dismissed.
    Creates unique vulnerability fingerprints that GitHub treats as new alerts for workshop demonstrations.

.EXAMPLE
    .\codeql-javascript.ps1
    
    Basic usage - Analyzes calculator app with default settings and displays results locally.

.EXAMPLE
    .\codeql-javascript.ps1 -useCustomQueryOnly
    
    Runs only custom security queries from custom-security.ql file.

.EXAMPLE
    .\codeql-javascript.ps1 -format csv -outputPath "reports\calculator-security.csv"
    
    Generates CSV format results and saves to custom location.

.EXAMPLE
    .\codeql-javascript.ps1 -uploadToGitHub -autoDetectRepo
    
    Analyzes calculator and uploads SARIF results to GitHub Security tab using auto-detected repository.

.EXAMPLE
    .\codeql-javascript.ps1 -uploadToGitHub -gitHubOrg "ms-mfg-community" -gitHubRepo "project-gengo"
    
    Analyzes calculator and uploads to specific GitHub repository's Security tab.

.EXAMPLE
    .\codeql-javascript.ps1 -sourcePath "C:\MyProject\calculator" -databasePath "C:\temp\codeql-db"
    
    Analyzes calculator from custom source path using custom database location.

.EXAMPLE
    .\codeql-javascript.ps1 -useCustomQueryOnly -customQueryPath ".\workshop-queries\xss-detection.ql"
    
    Runs specific custom query for workshop demonstration of XSS detection patterns.

.EXAMPLE
    .\codeql-javascript.ps1 -injectReDoSVulnerability -uploadToGitHub -autoDetectRepo
    
    Injects ReDoS vulnerability, analyzes calculator, and uploads results showing security alerts.

.EXAMPLE
    .\codeql-javascript.ps1 -remediateReDoSVulnerability -uploadToGitHub -autoDetectRepo
    
    Removes injected vulnerabilities, analyzes calculator, and uploads clean security results.

.EXAMPLE
    .\codeql-javascript.ps1 -injectReDoSVulnerability -forceNewAlerts -uploadToGitHub -autoDetectRepo
    
    Injects vulnerabilities with randomized patterns to force new GitHub alerts even if previous ones were dismissed.

.NOTES
    File Name      : codeql-javascript.ps1
    Author         : GHAS Workshop Team
    Prerequisite   : CodeQL CLI, GitHub CLI (for uploads), Git
    Version        : 2.0
    
    Requirements:
    - CodeQL CLI installed and in PATH
    - GitHub CLI (gh) for SARIF uploads
    - Git repository with remote origin (for auto-detection)
    - Calculator workspace in ../workspace/calculator directory
    
    Security Permissions:
    - For GitHub uploads: security_events:write permission required
    - Authentication: gh auth login must be completed

.LINK
    https://docs.github.com/en/code-security/code-scanning/using-codeql-code-scanning-with-your-existing-ci-system
    
.LINK
    https://codeql.github.com/docs/codeql-cli/

#>

param(
    [string]$sourcePath = "..\workspace\calculator", # Path to the calculator workspace
    [string]$databasePath = ".\calculator-db", # Path where the CodeQL database will be created (temporary)
    [string]$outputPath = ".\calculator-results.sarif", # Output file path for SARIF results
    [string]$language = "javascript", # Programming language to analyze
    [string]$desiredQuerySuite = "javascript-security-and-quality.qls",
    [string]$customQueryPath = ".\custom-security.ql", # Custom query file to use for analysis
    [string]$qlsPath = "$env:USERPROFILE\.codeql", # Path to search for CodeQL query suites
    [string]$sarifCategory = "calculator-analysis", # Category tag for the SARIF output
    [ValidateSet("sarif-latest", "csv", "json", "table")]
    [string]$format = "sarif-latest",
    [switch]$useCustomQueryOnly, # Switch to use only the custom query file instead of the query suite
    # GitHub upload parameters
    [string]$gitHubOrg = "",
    [string]$gitHubRepo = "",
    [switch]$uploadToGitHub,
    [switch]$autoDetectRepo,
    [switch]$injectReDoSVulnerability,
    [switch]$remediateReDoSVulnerability,
    [switch]$forceNewAlerts
)

# Functions
# Auto-detect GitHub org/repo from git remote
function Get-GitHubRepoInfo {
    try {
        $remoteUrl = git remote get-url origin
        Write-Host "Git remote URL: $remoteUrl" -ForegroundColor Gray
        
        # Parse different URL formats
        if ($remoteUrl -match "github\.com[:/]([^/]+)/([^/]+?)(?:\.git)?$") {
            $org = $matches[1]
            $repo = $matches[2]
            return @{
                Organization = $org
                Repository = $repo
                FullName = "$org/$repo"
            }
        } else {
            throw "Could not parse GitHub repository from remote URL: $remoteUrl"
        }
    }
    catch {
        Write-Warning "Failed to auto-detect GitHub repository: $($_.Exception.Message)"
        return $null
    }
}

# Workshop vulnerability management functions
function Invoke-VulnerabilityInjection {
    param(
        [string]$calculatorPath,
        [bool]$randomizePatterns = $false
    )
    
    $vulnerableFilePath = Join-Path $calculatorPath "vulnerable-demo.ts"
    
    if (Test-Path $vulnerableFilePath) {
        Write-Host "⚠️  Vulnerable demo file already exists at: $vulnerableFilePath" -ForegroundColor Yellow
        return
    }
    
    # Generate random strings for unique vulnerability fingerprints
    if ($randomizePatterns) {
        Write-Host "🎲 Generating randomized vulnerability patterns for fresh GitHub alerts..." -ForegroundColor Cyan
        $randomChars = @('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j')
        $randomChar1 = Get-Random -InputObject $randomChars
        $randomChar2 = Get-Random -InputObject $randomChars
        $randomChar3 = Get-Random -InputObject $randomChars
        $randomId = Get-Random -Minimum 1000 -Maximum 9999
        $randomVar = "var$randomId"
        $randomFunc = "func$randomId"
    } else {
        Write-Host "🚨 Injecting ReDoS vulnerability for workshop demonstration..." -ForegroundColor Red
        $randomChar1 = 'a'
        $randomChar2 = 'b' 
        $randomChar3 = 'c'
        $randomId = '1234'
        $randomVar = 'userInput'
        $randomFunc = 'demonstrateRegexDoS'
    }
    
    $vulnerableContent = @"
/**
 * INTENTIONALLY VULNERABLE CODE FOR GHAS WORKSHOP DEMONSTRATION
 * 
 * This file contains security vulnerabilities that CodeQL will detect.
 * Use this for workshop demonstrations to show security alerts in GitHub.
 * 
 * Generated: $(Get-Date)
 * Pattern ID: $randomId
 * ⚠️  DO NOT USE IN PRODUCTION - FOR EDUCATIONAL PURPOSES ONLY ⚠️
 */

/**
 * XSS Vulnerability Demo - Medium Severity
 * CodeQL will detect: js/xss-through-dom
 */
function demonstrateXSS_$randomId() {
    // PATTERN 1: URL parameter XSS (CodeQL's favorite detection pattern)
    const urlParams = new URLSearchParams(window.location.search);
    const userMessage = urlParams.get('message') || '<script>alert("XSS-$randomId")</script>';
    
    const container = document.getElementById('demo-container-$randomId');
    if (container) {
        container.innerHTML = userMessage; // This WILL be detected
    }
    
    // PATTERN 2: Hash-based XSS (another CodeQL favorite)
    const hashContent = window.location.hash.substring(1);
    document.body.innerHTML += hashContent + "_$randomId"; // This WILL be detected
}

/**
 * Code Injection Vulnerability Demo - High Severity  
 * CodeQL will detect: js/code-injection
 */
function demonstrateCodeInjection_$randomId(mathExpression) {
    try {
        // VULNERABLE: eval() allows arbitrary code execution - Pattern $randomId
        return eval(mathExpression + "_$randomId"); // CodeQL will flag this as code injection
    } catch (error) {
        console.error('Calculation error-${randomId}:', error);
        return 0;
    }
}

/**
 * Regular Expression DoS Demo - Medium Severity
 * CodeQL will detect: js/redos - Pattern $randomId
 */
function ${randomFunc}_$randomId(input) {
    // VULNERABLE: Randomized regex vulnerable to catastrophic backtracking
    const vulnerableRegex = /^($randomChar1+)+$/; // Exponential time complexity - Pattern $randomId
    const altRegex = /^($randomChar2*)*$randomChar3+$/; // Alternative ReDoS pattern
    
    return vulnerableRegex.test(input) || altRegex.test(input); // CodeQL will flag both patterns
}

/**
 * Path Traversal Vulnerability Demo - Medium Severity
 * CodeQL will detect: js/path-injection - Pattern $randomId
 */
function demonstratePathTraversal_$randomId(filename) {
    // VULNERABLE: User input directly used in file path - Pattern $randomId
    const filePath = './uploads_$randomId/' + filename; // CodeQL will flag this
    const altPath = './data_$randomId/' + filename; // Alternative pattern
    console.log('Accessing file-${randomId}', filePath, altPath);
}

/**
 * Calculator-specific vulnerable functions - Pattern $randomId
 */
class VulnerableCalculator_$randomId {
    private history_$randomId = [];
    
    /**
     * VULNERABLE: Stores and displays user expressions without validation
     */
    addToHistory_$randomId(expression) {
        this.history_$randomId.push(expression);
        
        // VULNERABLE: Display in DOM without sanitization - Pattern $randomId
        const historyElement = document.getElementById('calculation-history-$randomId');
        if (historyElement) {
            historyElement.innerHTML += '<div class="entry-$randomId">' + expression + '</div>'; // XSS risk
        }
    }
    
    /**
     * VULNERABLE: Evaluates mathematical expressions unsafely - Pattern $randomId
     */
    calculateUnsafe_$randomId(expression) {
        try {
            return eval(expression + "_calc_$randomId"); // Code injection risk - Pattern $randomId
        } catch (error) {
            return 0;
        }
    }
    
    /**
     * Additional XSS vector - Pattern $randomId
     */
    displayResult_$randomId(result) {
        // VULNERABLE: document.write with user data
        document.write('Result-${randomId} ' + result + '<br>'); // XSS via document.write
    }
}

// Trigger vulnerability detection with randomized patterns
const demoCalc_$randomId = new VulnerableCalculator_$randomId();
demoCalc_$randomId.addToHistory_$randomId('2 + 2 /* pattern $randomId */');
${randomFunc}_$randomId('$randomChar1$randomChar1$randomChar1$randomChar1$randomChar1$randomChar1$randomChar1$randomChar1!');

// Additional XSS trigger
demonstrateXSS_$randomId();

// Force multiple vulnerability instances
for (let i = 0; i < 3; i++) {
    const testRegex_$randomId = /^($randomChar3+)+test_$randomId$/;
    testRegex_$randomId.test('input_' + i + '_$randomId');
}
"@
    
    try {
        Set-Content -Path $vulnerableFilePath -Value $vulnerableContent -Encoding UTF8
        if ($randomizePatterns) {
            Write-Host "✅ Randomized vulnerabilities injected successfully: $vulnerableFilePath" -ForegroundColor Green
            Write-Host "   Pattern ID: $randomId | Chars: $randomChar1, $randomChar2, $randomChar3" -ForegroundColor Cyan
            Write-Host "   Expected alerts: js/redos, js/xss-through-dom, js/code-injection, js/xss" -ForegroundColor Cyan
        } else {
            Write-Host "✅ ReDoS vulnerability injected successfully: $vulnerableFilePath" -ForegroundColor Green
            Write-Host "   Expected alerts: js/redos, js/xss-through-dom, js/code-injection" -ForegroundColor Cyan
        }
    }
    catch {
        Write-Error "Failed to inject vulnerability: $($_.Exception.Message)"
    }
}

function Invoke-VulnerabilityRemediation {
    param([string]$calculatorPath)
    
    $vulnerableFilePath = Join-Path $calculatorPath "vulnerable-demo.ts"
    
    if (-not (Test-Path $vulnerableFilePath)) {
        Write-Host "✅ No vulnerable demo file found - calculator is already clean" -ForegroundColor Green
        return
    }
    
    Write-Host "🛠️  Remediating vulnerabilities for clean demonstration..." -ForegroundColor Yellow
    
    try {
        Remove-Item -Path $vulnerableFilePath -Force
        Write-Host "✅ Vulnerable demo file removed: $vulnerableFilePath" -ForegroundColor Green
        Write-Host "   Calculator is now clean and should show 0 security issues" -ForegroundColor Cyan
    }
    catch {
        Write-Error "Failed to remove vulnerable file: $($_.Exception.Message)"
    }
}

# Process workshop vulnerability switches
if ($injectReDoSVulnerability -and $remediateReDoSVulnerability) {
    Write-Error "Cannot use both -injectReDoSVulnerability and -remediateReDoSVulnerability at the same time."
    exit 1
}

if ($forceNewAlerts -and -not $injectReDoSVulnerability) {
    Write-Error "The -forceNewAlerts switch can only be used with -injectReDoSVulnerability."
    exit 1
}

if ($injectReDoSVulnerability) {
    Invoke-VulnerabilityInjection -calculatorPath $sourcePath -randomizePatterns $forceNewAlerts
}

if ($remediateReDoSVulnerability) {
    Invoke-VulnerabilityRemediation -calculatorPath $sourcePath
}

# create the codeql database for calculator app
Write-Host "Creating CodeQL database for calculator app..." -ForegroundColor Cyan
Write-Host "Source: $sourcePath" -ForegroundColor Gray
Write-Host "Database: $databasePath" -ForegroundColor Gray
codeql database create $databasePath --language=$language --source-root=$sourcePath --overwrite --verbose

# Ensure JavaScript queries are downloaded
Write-Host "Downloading CodeQL JavaScript queries..." -ForegroundColor Cyan
codeql pack download codeql/javascript-queries
codeql pack download codeql/javascript-all

# return the path of the $fullQlsPath
$queryFile = Get-ChildItem -Path "$qlsPath" -Recurse -Filter $desiredQuerySuite -ErrorAction SilentlyContinue | Select-Object -First 1
if ($queryFile) {
    $fullQlsPath = $queryFile.FullName
    Write-Host "Found query suite at: $fullQlsPath"
} else {
    Write-Error "Query suite '$desiredQuerySuite' not found in CodeQL packages at path: $qlsPath"
    # download javascript query suites
    codeql pack download codeql/javascript-queries
}

# Set output file extension based on format
$outputExtension = switch ($format) {
    "sarif-latest" { ".sarif" }
    "csv" { ".csv" }
    "json" { ".json" }
    "table" { ".txt" }
    default { ".sarif" }
}

$outputPath = $outputPath -replace '\.[^.]+$', $outputExtension
Write-Host "Calculator analysis output will be saved to: $outputPath" -ForegroundColor Yellow

# run codeql analysis on calculator app
Write-Host "Analyzing calculator application..." -ForegroundColor Cyan
if ($useCustomQueryOnly) {
    Write-Host "Using custom query only: $customQueryPath" -ForegroundColor Cyan
    # Check if custom query file exists
    if (Test-Path $customQueryPath) {
        try {
            codeql database analyze $databasePath $customQueryPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
        }
        catch {
            Write-Warning "Custom query failed. Falling back to standard JavaScript security queries."
            codeql database analyze $databasePath "codeql/javascript-queries:codeql-suites/javascript-security-and-quality.qls" --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
        }
    } else {
        Write-Warning "Custom query file not found at: $customQueryPath. Using standard queries only."
        codeql database analyze $databasePath $fullQlsPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
    }
} else {
    Write-Host "Using standard query suite: $fullQlsPath" -ForegroundColor Cyan
    codeql database analyze $databasePath $fullQlsPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
}

# remove database directory to cleanup
Remove-Item -Path $databasePath -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Calculator database directory cleaned up: $databasePath" -ForegroundColor Yellow

# Parse and display calculator analysis results
Write-Host "Parsing calculator analysis results..." -ForegroundColor Cyan
if (Test-Path $outputPath) {
    $sarif = Get-Content -Path $outputPath -Raw | ConvertFrom-Json
} else {
    Write-Error "SARIF output file not found at: $outputPath"
    exit 1
}

Write-Host "=== Calculator Security Analysis Results ===" -ForegroundColor Green
Write-Host "Schema Version: $($sarif.'$schema')" -ForegroundColor Cyan
Write-Host "SARIF Version: $($sarif.version)" -ForegroundColor Cyan

foreach ($run in $sarif.runs) {
    Write-Host "`n--- Tool Information ---" -ForegroundColor Yellow
    Write-Host "Tool: $($run.tool.driver.name)"
    Write-Host "Version: $($run.tool.driver.semanticVersion)"
    Write-Host "Organization: $($run.tool.driver.organization)"
    
    Write-Host "`n--- Results Summary ---" -ForegroundColor Yellow
    Write-Host "Total Results: $($run.results.Count)"
    
    if ($run.results.Count -gt 0) {
        Write-Host "`n--- Security Findings ---" -ForegroundColor Red
        foreach ($result in $run.results) {
            Write-Host "Rule ID: $($result.ruleId)" -ForegroundColor Magenta
            Write-Host "Message: $($result.message.text)" -ForegroundColor White
            Write-Host "Level: $($result.level)" -ForegroundColor Yellow
            
            foreach ($location in $result.locations) {
                $file = $location.physicalLocation.artifactLocation.uri
                $line = $location.physicalLocation.region.startLine
                Write-Host "Location: ${file}:${line}" -ForegroundColor Cyan
            }
            Write-Host "---"
        }
    } else {
        Write-Host "✅ Calculator app: No security issues found!" -ForegroundColor Green
    }
    
    Write-Host "`n--- Calculator Files Analyzed ---" -ForegroundColor Yellow
    foreach ($artifact in $run.artifacts) {
        Write-Host "📄 $($artifact.location.uri)"
    }
}

if ($uploadToGitHub) {

    Write-Host "`n=== GitHub Authentication Check ===" -ForegroundColor Cyan
    
    # Check if already authenticated to GitHub
    try {
        $authStatus = gh auth status 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Already authenticated to GitHub" -ForegroundColor Green
            Write-Host "$authStatus" -ForegroundColor Gray
        } else {
            Write-Host "🔐 GitHub authentication required" -ForegroundColor Yellow
            gh auth login
        }
    }
    catch {
        Write-Host "🔐 GitHub authentication required" -ForegroundColor Yellow
        gh auth login
    }

    Write-Host "`n=== Uploading SARIF to GitHub ===" -ForegroundColor Cyan
    
    # Determine org/repo
    if ($autoDetectRepo) {
        $repoInfo = Get-GitHubRepoInfo
        if ($repoInfo) {
            $gitHubOrg = $repoInfo.Organization
            $gitHubRepo = $repoInfo.Repository
            Write-Host "Auto-detected: $($repoInfo.FullName)" -ForegroundColor Green
        } else {
            Write-Error "Could not auto-detect repository. Please specify -gitHubOrg and -gitHubRepo manually."
            exit 1
        }
    }
    
    # Validate org/repo are provided
    if (-not $gitHubOrg -or -not $gitHubRepo) {
        Write-Error "GitHub organization and repository must be specified. Use -gitHubOrg and -gitHubRepo parameters or -autoDetectRepo switch."
        exit 1
    }
    
    try {
        # Get git information
        $commitSha = git rev-parse HEAD
        $currentBranch = git branch --show-current
        $ref = "refs/heads/$currentBranch"
        
        # Prepare SARIF for upload (GitHub requires Base64-encoded gzipped content)
        Write-Host "Preparing SARIF file for upload..." -ForegroundColor Gray
        $sarifContent = Get-Content $outputPath -Raw
        $sarifBytes = [Text.Encoding]::UTF8.GetBytes($sarifContent)
        
        # Compress using gzip
        $memoryStream = [System.IO.MemoryStream]::new()
        $gzipStream = [System.IO.Compression.GzipStream]::new($memoryStream, [System.IO.Compression.CompressionMode]::Compress)
        $gzipStream.Write($sarifBytes, 0, $sarifBytes.Length)
        $gzipStream.Close()
        
        # Base64 encode the compressed data
        $compressedBytes = $memoryStream.ToArray()
        $base64Sarif = [Convert]::ToBase64String($compressedBytes)
        $memoryStream.Dispose()
        
        Write-Host "SARIF compressed and encoded (size: $($compressedBytes.Length) bytes)" -ForegroundColor Gray
        
        # Upload to GitHub
        $apiUrl = "repos/$gitHubOrg/$gitHubRepo/code-scanning/sarifs"
        Write-Host "Uploading to: $apiUrl" -ForegroundColor Yellow
        
        gh api $apiUrl `
          --method POST `
          --field sarif="$base64Sarif" `
          --field commit_sha="$commitSha" `
          --field ref="$ref" `
          --field started_at="$(Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ')" `
          --field tool_name="CodeQL Calculator Analysis"
          
        Write-Host "✅ SARIF successfully uploaded to GitHub Security tab!" -ForegroundColor Green
        Write-Host "View results at: https://github.com/$gitHubOrg/$gitHubRepo/security/code-scanning" -ForegroundColor Cyan
    }
    catch {
        Write-Error "Failed to upload SARIF to GitHub: $($_.Exception.Message)"
        Write-Host "Make sure you're authenticated with 'gh auth login' and have security_events:write permission" -ForegroundColor Yellow
    }
}


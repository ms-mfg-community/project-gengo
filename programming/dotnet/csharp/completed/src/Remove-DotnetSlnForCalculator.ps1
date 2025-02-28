# 1. Get the repository root path
$repoRoot = git rev-parse --show-toplevel

# 2. Append to this root path, the relative root path of \programming\dotnet\csharp\workspace\src and assign this string value to the variable $targetPath
$targetPath = Join-Path -Path $repoRoot -ChildPath "programming/dotnet/csharp/workspace/src"

# 3. Set the current path to $targetPath
Set-Location -Path $targetPath

# 4. Remove the calculator-xunit-testing folder from the $targetPath
Remove-Item -Path "calculator-xunit-testing" -Recurse -Force
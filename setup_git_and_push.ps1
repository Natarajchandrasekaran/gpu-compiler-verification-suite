# ==============================================================================
# Helper Script: Initialize Local Git and Push to GitHub
# ==============================================================================

param(
    [string]$GitHubUsername = ""
)

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " NVIDIA Compiler Verification Suite - Git Repository Setup " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# 1. Prompt for GitHub username if not provided
if (-not $GitHubUsername) {
    $GitHubUsername = Read-Host "Enter your GitHub username (e.g. nataraj05)"
}

if (-not $GitHubUsername) {
    Write-Host "[!] GitHub username cannot be empty." -ForegroundColor Red
    exit 1
}

$repoName = "gpu-compiler-verification-suite"
$remoteUrl = "https://github.com/$GitHubUsername/$repoName.git"
$webUrl = "https://github.com/$GitHubUsername/$repoName"

Write-Host "`n[*] Your GitHub Repository URL for your application is:" -ForegroundColor Yellow
Write-Host "    $webUrl" -ForegroundColor Green

# 2. Check Git availability
$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCmd) {
    Write-Host "`n[!] Git is not yet installed in your system PATH." -ForegroundColor Yellow
    Write-Host "    You can install it automatically by running:" -ForegroundColor White
    Write-Host "    winget install --id Git.Git -e --source winget" -ForegroundColor Cyan
    Write-Host "`nAlternatively, download Git for Windows from: https://git-scm.com/download/win" -ForegroundColor White
    Write-Host "`nOnce Git is installed, re-run this script to push automatically!" -ForegroundColor Yellow
    exit 0
}

# 3. Initialize and commit
Write-Host "`n[*] Initializing local Git repository..." -ForegroundColor Cyan
git init
git checkout -b main
git add .
git commit -m "Initial commit: GPU and Embedded Compiler Verification Suite"

# 4. Set remote
git remote remove origin -ErrorAction SilentlyContinue
git remote add origin $remoteUrl

Write-Host "`n============================================================" -ForegroundColor Green
Write-Host " Repository initialized successfully!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host "`nNext Step: Create an empty public repository named '$repoName' on GitHub:" -ForegroundColor White
Write-Host "  1. Open: https://github.com/new" -ForegroundColor Cyan
Write-Host "  2. Repository name: $repoName" -ForegroundColor Cyan
Write-Host "  3. Leave 'Add a README file' UNCHECKED" -ForegroundColor Cyan
Write-Host "  4. Click 'Create repository'" -ForegroundColor Cyan
Write-Host "`nThen run this command in this folder to publish:" -ForegroundColor White
Write-Host "  git push -u origin main" -ForegroundColor Yellow
Write-Host "`nYour application link is ready: $webUrl" -ForegroundColor Green

# GitHub Setup Script for Quiz Application
# Run this script AFTER installing Git

Write-Host "=== Quiz Application GitHub Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if Git is installed
$gitInstalled = $false
try {
    $null = git --version 2>&1
    $gitInstalled = $true
    $gitVersion = git --version
    Write-Host "Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    $gitInstalled = $false
}

if (-not $gitInstalled) {
    Write-Host "Git is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Git first:" -ForegroundColor Yellow
    Write-Host "1. Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "2. Install with default settings" -ForegroundColor Yellow
    Write-Host "3. Restart PowerShell and run this script again" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit
}

Write-Host ""
Write-Host "Step 1: Checking Git configuration..." -ForegroundColor Cyan

# Check Git user configuration
$userName = git config --global user.name 2>$null
$userEmail = git config --global user.email 2>$null

if ([string]::IsNullOrEmpty($userName) -or [string]::IsNullOrEmpty($userEmail)) {
    Write-Host "Git user configuration not set." -ForegroundColor Yellow
    $configName = Read-Host "Enter your name (for Git commits)"
    $configEmail = Read-Host "Enter your email (for Git commits)"
    git config --global user.name "$configName"
    git config --global user.email "$configEmail"
    Write-Host "Git configuration saved" -ForegroundColor Green
} else {
    Write-Host "Git configured as: $userName ($userEmail)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Step 2: Initializing Git repository..." -ForegroundColor Cyan

# Initialize Git if not already initialized
if (Test-Path ".git") {
    Write-Host "Git repository already initialized" -ForegroundColor Green
} else {
    git init
    Write-Host "Git repository initialized" -ForegroundColor Green
}

Write-Host ""
Write-Host "Step 3: Adding files to Git..." -ForegroundColor Cyan
git add .
Write-Host "Files added to staging" -ForegroundColor Green

Write-Host ""
Write-Host "Step 4: Creating initial commit..." -ForegroundColor Cyan
git commit -m "Initial commit: Quiz application with SvelteKit"
Write-Host "Initial commit created" -ForegroundColor Green

Write-Host ""
Write-Host "Step 5: Setting up GitHub remote..." -ForegroundColor Cyan
Write-Host "You need to create a repository on GitHub first:" -ForegroundColor Yellow
Write-Host "1. Go to: https://github.com/new" -ForegroundColor Yellow
Write-Host "2. Repository name: quiz-app (or your preferred name)" -ForegroundColor Yellow
Write-Host "3. Choose Public or Private" -ForegroundColor Yellow
Write-Host "4. DO NOT initialize with README" -ForegroundColor Yellow
Write-Host "5. Click Create repository" -ForegroundColor Yellow
Write-Host ""

$repoUrl = Read-Host "Enter your GitHub repository URL (e.g., https://github.com/adrianhelms000/quiz-app.git)"

if ($repoUrl) {
    # Check if remote already exists
    $existingRemote = git remote get-url origin 2>$null
    if ($existingRemote) {
        Write-Host "Remote 'origin' already exists: $existingRemote" -ForegroundColor Yellow
        $update = Read-Host "Update it? (y/n)"
        if ($update -eq "y") {
            git remote set-url origin $repoUrl
            Write-Host "Remote updated" -ForegroundColor Green
        }
    } else {
        git remote add origin $repoUrl
        Write-Host "Remote added" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "Step 6: Pushing to GitHub..." -ForegroundColor Cyan
    Write-Host "You will be prompted for your GitHub username and Personal Access Token" -ForegroundColor Yellow
    Write-Host "Get a token from: https://github.com/settings/tokens" -ForegroundColor Yellow
    Write-Host ""
    
    # Rename branch to main if needed
    $currentBranch = git branch --show-current
    if ($currentBranch -ne "main") {
        git branch -M main
    }
    
    $push = Read-Host "Push to GitHub now? (y/n)"
    if ($push -eq "y") {
        git push -u origin main
        Write-Host ""
        Write-Host "=== Setup Complete! ===" -ForegroundColor Green
        Write-Host "Your quiz application is now on GitHub!" -ForegroundColor Green
        Write-Host "Visit: $repoUrl" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "To push later, run: git push -u origin main" -ForegroundColor Yellow
    }
} else {
    Write-Host "Skipped remote setup. You can add it later with:" -ForegroundColor Yellow
    Write-Host "git remote add origin <your-repo-url>" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to exit"

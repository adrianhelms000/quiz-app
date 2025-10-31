# Manual Git Setup Commands

If the script doesn't work, run these commands manually in PowerShell (after restarting PowerShell):

## Step 1: Navigate to your project
```powershell
cd C:\Users\adria\Documents
```

## Step 2: Configure Git (if not already done)
```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Step 3: Initialize Git repository
```powershell
git init
```

## Step 4: Add all files
```powershell
git add .
```

## Step 5: Create initial commit
```powershell
git commit -m "Initial commit: Quiz application with SvelteKit"
```

## Step 6: Add GitHub remote
**First, create the repository on GitHub at: https://github.com/new**

Then run:
```powershell
git remote add origin https://github.com/adrianhelms000/quiz-app.git
```
(Replace with your actual repository URL)

## Step 7: Rename branch to main
```powershell
git branch -M main
```

## Step 8: Push to GitHub
```powershell
git push -u origin main
```

When prompted:
- **Username**: `adrianhelms000`
- **Password**: Use your Personal Access Token from https://github.com/settings/tokens

## Troubleshooting: Git not found

If Git is still not found after restarting PowerShell, try:

1. Find where Git is installed (usually `C:\Program Files\Git\bin\git.exe`)
2. Add it to PATH manually, or
3. Use the full path:
```powershell
& "C:\Program Files\Git\bin\git.exe" --version
```

If that works, use the full path for all git commands.


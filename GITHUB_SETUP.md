# GitHub Setup Instructions

Follow these steps to push your quiz application to GitHub.

## Step 1: Install Git

1. Download Git for Windows from: https://git-scm.com/download/win
2. Install it with default settings
3. Restart your terminal/PowerShell

## Step 2: Configure Git (First Time Only)

Open PowerShell and run:

```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Replace with your actual name and GitHub email.

## Step 3: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `quiz-app` (or any name you prefer)
3. Description: "Programming Quiz Application built with SvelteKit"
4. Choose **Public** or **Private**
5. **DO NOT** check "Initialize with README" (we already have files)
6. Click "Create repository"

## Step 4: Initialize Git in Your Project

Open PowerShell in your Documents folder and run:

```powershell
# Navigate to your project (if not already there)
cd C:\Users\adria\Documents

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Quiz application with SvelteKit"

# Add your GitHub repository as remote (replace with your actual username/repo)
git remote add origin https://github.com/adrianhelms000/quiz-app.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

**Note:** When you push for the first time, GitHub will prompt you for your username and password/token.

## Step 5: Authentication

GitHub no longer accepts passwords. You'll need a Personal Access Token:

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name: "Quiz App Access"
4. Select scopes: Check **repo** (full control of private repositories)
5. Click "Generate token"
6. **Copy the token immediately** (you won't see it again!)
7. When pushing, use your GitHub username and the token as the password

## Alternative: Using GitHub CLI (gh)

If you have GitHub CLI installed:

```powershell
gh auth login
gh repo create quiz-app --public --source=. --remote=origin --push
```

## Updating Your Repository

After making changes:

```powershell
git add .
git commit -m "Description of your changes"
git push
```

## Files Included

The following files will be uploaded:
- ✅ All source code in `src/`
- ✅ Configuration files (package.json, svelte.config.js, etc.)
- ✅ README.md
- ✅ .gitignore (excludes node_modules, build files, etc.)

The following will NOT be uploaded (excluded by .gitignore):
- ❌ node_modules/
- ❌ .svelte-kit/
- ❌ build/
- ❌ .env files

## Troubleshooting

**"Git is not recognized"**
- Make sure Git is installed and you've restarted your terminal

**"Authentication failed"**
- Use a Personal Access Token instead of a password
- Make sure you're using the correct username (adrianhelms000)

**"Repository not found"**
- Make sure the repository exists on GitHub
- Check the repository name matches in the remote URL

**"Everything up-to-date"**
- This means your local changes match what's on GitHub
- Make sure you've committed your changes with `git commit`


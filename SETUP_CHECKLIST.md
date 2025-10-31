# GitHub Setup Checklist

Follow these steps in order to push your quiz application to GitHub:

## ✅ Step 1: Install Git

- [ ] Download Git from: https://git-scm.com/download/win
- [ ] Install with default settings
- [ ] Restart PowerShell/terminal after installation
- [ ] Verify installation: Open PowerShell and type `git --version`

## ✅ Step 2: Configure Git (First Time Only)

Open PowerShell and run:

```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Replace with your actual name and the email associated with your GitHub account.

## ✅ Step 3: Create GitHub Repository

- [ ] Go to: https://github.com/new
- [ ] Repository name: `quiz-app` (or your preferred name)
- [ ] Description: "Programming Quiz Application built with SvelteKit"
- [ ] Choose: **Public** or **Private**
- [ ] **DO NOT** check "Initialize with README" (we already have files)
- [ ] Click "Create repository"
- [ ] Copy the repository URL (looks like: `https://github.com/adrianhelms000/quiz-app.git`)

## ✅ Step 4: Get Personal Access Token

GitHub requires a Personal Access Token instead of password:

- [ ] Go to: https://github.com/settings/tokens
- [ ] Click "Generate new token" → "Generate new token (classic)"
- [ ] Name: "Quiz App Access"
- [ ] Expiration: Choose your preference (90 days, 1 year, or no expiration)
- [ ] Select scopes: Check **repo** (full control of private repositories)
- [ ] Click "Generate token"
- [ ] **Copy the token immediately** - you won't see it again!

## ✅ Step 5: Run Setup Script

**Option A: Use the automated script**
- [ ] Right-click `setup-github.ps1` in your Documents folder
- [ ] Select "Run with PowerShell"
- [ ] Follow the prompts

**Option B: Run commands manually**

Open PowerShell in your Documents folder and run:

```powershell
cd C:\Users\adria\Documents

# Initialize Git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Quiz application with SvelteKit"

# Add GitHub remote (replace with your actual repository URL)
git remote add origin https://github.com/adrianhelms000/quiz-app.git

# Rename branch to main
git branch -M main

# Push to GitHub (you'll be prompted for username and token)
git push -u origin main
```

When prompted:
- **Username**: `adrianhelms000`
- **Password**: Paste your Personal Access Token

## ✅ Step 6: Verify Upload

- [ ] Go to your GitHub repository: `https://github.com/adrianhelms000/quiz-app`
- [ ] Verify all files are visible
- [ ] Check that `src/routes/+page.svelte` is there
- [ ] Check that `src/lib/data.json` is there
- [ ] Check that `README.md` is there

## 🎉 Done!

Your quiz application is now on GitHub!

## Future Updates

When you make changes to your code:

```powershell
git add .
git commit -m "Description of your changes"
git push
```

## Troubleshooting

**"Git is not recognized"**
- Make sure Git is installed and PowerShell is restarted
- Try closing and reopening PowerShell

**"Authentication failed"**
- Make sure you're using a Personal Access Token (not password)
- Token must have "repo" scope checked
- Check that your username is correct (adrianhelms000)

**"Repository not found"**
- Make sure the repository exists on GitHub
- Check the repository URL is correct
- Make sure you have access to the repository

**"Everything up-to-date"**
- This means your local code matches GitHub
- Make sure you've committed your changes: `git commit -m "message"`

## Need Help?

- Git Documentation: https://git-scm.com/doc
- GitHub Help: https://docs.github.com
- Check `GITHUB_SETUP.md` for detailed instructions


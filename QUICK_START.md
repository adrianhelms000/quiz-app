# Quick Start Guide

## After Installing Git

Once you have Git installed, follow these steps:

### 1. Create GitHub Repository

Go to https://github.com/new and create a new repository:
- Name: `quiz-app` (or your preferred name)
- Description: "Programming Quiz Application built with SvelteKit"
- Choose Public or Private
- **Do NOT** initialize with README (we already have one)

### 2. Copy the Repository URL

After creating the repository, copy the URL (it will look like):
```
https://github.com/adrianhelms000/quiz-app.git
```

### 3. Run These Commands in PowerShell

Open PowerShell in your Documents folder and run:

```powershell
# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Quiz application with SvelteKit"

# Add your GitHub repository as remote (replace with your actual URL)
git remote add origin https://github.com/adrianhelms000/quiz-app.git

# Push to GitHub (you'll be prompted for username and token)
git push -u origin main
```

### 4. Authentication

When prompted:
- **Username**: `adrianhelms000`
- **Password**: Use a [Personal Access Token](https://github.com/settings/tokens)
  - Generate one at: https://github.com/settings/tokens
  - Select "repo" scope
  - Copy the token and use it as your password

### 5. Verify

Go to your GitHub repository page to verify all files are uploaded!

## Next Steps

- ✅ Your quiz application is now on GitHub!
- ✅ Share the repository URL with others
- ✅ Clone it on other machines with: `git clone https://github.com/adrianhelms000/quiz-app.git`

## Making Future Changes

After making changes to your code:

```powershell
git add .
git commit -m "Description of changes"
git push
```

That's it! 🎉


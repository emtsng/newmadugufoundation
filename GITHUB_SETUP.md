# GitHub Repository Setup Instructions

## Step 1: Create a GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in
2. Click the "+" icon in the top right corner
3. Select "New repository"
4. Repository name: `newmadugufoundation` (or your preferred name)
5. Description: "Django website for Madugu Foundation"
6. Choose Public or Private
7. **DO NOT** initialize with README, .gitignore, or license (we already have these)
8. Click "Create repository"

## Step 2: Push Your Code to GitHub

After creating the repository, GitHub will show you commands. Use these commands instead (they're already set up):

```bash
# Add the remote repository (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/newmadugufoundation.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Alternative: Using SSH (if you have SSH keys set up)

```bash
git remote add origin git@github.com:YOUR_USERNAME/newmadugufoundation.git
git branch -M main
git push -u origin main
```

## Quick One-Liner (after creating repo on GitHub)

Replace `YOUR_USERNAME` with your actual GitHub username:

```bash
git remote add origin https://github.com/YOUR_USERNAME/newmadugufoundation.git && git branch -M main && git push -u origin main
```

## Troubleshooting

If you get authentication errors:
- Use a Personal Access Token instead of password
- Or set up SSH keys for easier authentication

If the branch name is different:
- Check your current branch: `git branch`
- Rename if needed: `git branch -M main`


# GitHub Pages Deployment Guide

This guide explains how to deploy this website to GitHub Pages.

## Prerequisites

1. A GitHub repository
2. GitHub Pages enabled in your repository settings

## Automatic Deployment (Recommended)

The project includes a GitHub Actions workflow that automatically deploys your site when you push to the `main` or `master` branch.

### Setup Steps

1. **Enable GitHub Pages in Repository Settings:**
   - Go to your repository on GitHub
   - Navigate to **Settings** → **Pages**
   - Under **Source**, select **GitHub Actions**
   - Save the settings

2. **Push to Main Branch:**
   - The workflow (`.github/workflows/deploy.yml`) will automatically:
     - Copy pages from `pages/` directory to root
     - Copy assets directory
     - Fix all asset paths for GitHub Pages
     - Deploy to GitHub Pages

3. **Access Your Site:**
   - Your site will be available at: `https://[username].github.io/[repository-name]`
   - If you have a custom domain (CNAME file), it will use that domain

## Manual Deployment

If you prefer to deploy manually:

1. **Prepare the site locally:**
   ```bash
   ruby prepare-gh-pages.rb
   ```
   This creates a `_site` directory with all files ready for deployment.

2. **Deploy using one of these methods:**

   **Option A: Using gh-pages branch (Traditional method)**
   ```bash
   git checkout --orphan gh-pages
   git rm -rf .
   cp -r _site/* .
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin gh-pages
   ```

   **Option B: Using GitHub CLI**
   ```bash
   gh pages deploy _site --branch gh-pages
   ```

## Custom Domain Setup

If you have a custom domain (CNAME file exists):

1. The CNAME file will be automatically copied to the deployment
2. Configure your DNS settings:
   - Add a CNAME record pointing to `[username].github.io`
   - Wait for DNS propagation (can take up to 24 hours)

## Troubleshooting

### Common Issues

1. **404 Errors:**
   - Ensure all HTML files are in the root of the `_site` directory
   - Check that asset paths are correct (should be `assets/` for root files, `../assets/` for subdirectory files)

2. **Assets Not Loading:**
   - Verify the `assets` directory was copied to `_site`
   - Check browser console for 404 errors on specific assets
   - Ensure paths use relative URLs, not absolute

3. **GitHub Actions Fails:**
   - Check the Actions tab in your GitHub repository
   - Review error messages in the workflow logs
   - Ensure Ruby is available (the workflow sets it up automatically)

4. **Custom Domain Not Working:**
   - Verify CNAME file is in the root of your repository
   - Check DNS settings with your domain provider
   - Wait for DNS propagation

### Testing Locally

Before deploying, test the prepared site locally:

```bash
# Prepare the site
ruby prepare-gh-pages.rb

# Serve locally (using Python)
cd _site
python -m http.server 8000

# Or using Ruby
cd _site
ruby -run -e httpd . -p 8000
```

Then visit `http://localhost:8000` to test.

## File Structure After Deployment

```
_site/
├── index.html
├── about.html
├── contact.html
├── ... (all HTML pages)
├── programs/
│   └── ... (program pages)
├── get-involved/
│   └── ... (get-involved pages)
├── assets/
│   ├── css/
│   ├── js/
│   ├── img/
│   └── vendor/
└── CNAME (if exists)
```

## Notes

- The `pages/` directory structure is preserved in the deployment
- All asset paths are automatically fixed during preparation
- The deployment script handles nested directories correctly
- GitHub Actions workflow runs automatically on push to main/master


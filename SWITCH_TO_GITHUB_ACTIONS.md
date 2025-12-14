# Switch to GitHub Actions Deployment

## Current Status

Your site is currently using the **old GitHub Pages build system** (Jekyll-based), which is why you're seeing:
- "Your GitHub Pages site is currently being built from the master branch"
- The old build system doesn't understand your project structure

## Why Switch?

The old build system expects Jekyll files, but your project is a static HTML site. Switching to GitHub Actions will:
- ✅ Properly prepare your site using the `prepare-gh-pages.rb` script
- ✅ Fix all asset paths automatically
- ✅ Deploy your static HTML files correctly
- ✅ Work with your custom domain (`madugufoundation.com`)

## Steps to Switch

### Step 1: Commit and Push Your Changes

First, make sure all the new files are committed and pushed:

```bash
git add .
git commit -m "Add GitHub Actions workflow for deployment"
git push origin master
```

### Step 2: Switch to GitHub Actions in Settings

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Pages**
3. Under **Source**, you'll see it's currently set to:
   - **Branch: master** (old build system)
   
4. **Change it to:**
   - **Source: GitHub Actions** (select from dropdown)
   
5. Click **Save**

### Step 3: Trigger the Workflow

After switching to GitHub Actions, you need to trigger the workflow:

**Option A: Push a new commit**
```bash
# Make a small change to trigger the workflow
git commit --allow-empty -m "Trigger GitHub Actions deployment"
git push origin master
```

**Option B: Manual trigger**
- Go to **Actions** tab in your repository
- Click on "Deploy to GitHub Pages" workflow
- Click "Run workflow" button
- Select `master` branch
- Click "Run workflow"

### Step 4: Monitor the Deployment

1. Go to **Actions** tab
2. You'll see "Deploy to GitHub Pages" workflow running
3. Click on it to see the progress
4. The workflow will:
   - Checkout your code
   - Setup Ruby
   - Run `prepare-gh-pages.rb` to fix paths
   - Deploy to GitHub Pages

### Step 5: Verify Deployment

Once the workflow completes:
1. Check the **Actions** tab - it should show a green checkmark ✅
2. Visit your site: `http://madugufoundation.com/`
3. Check that:
   - CSS files load correctly
   - Images display properly
   - JavaScript works
   - All pages are accessible

## What Happens During Deployment

The GitHub Actions workflow will:

1. **Checkout** your code from the `master` branch
2. **Setup Ruby** environment
3. **Prepare the site** by running `prepare-gh-pages.rb`:
   - Copies `pages/*` to `_site/` root
   - Copies `assets/` directory
   - Fixes all asset paths:
     - Root files: `../assets/` → `assets/`
     - Subdirectory files: `../../assets/` → `../assets/`
   - Copies `CNAME` file
4. **Deploy** the prepared `_site/` directory to GitHub Pages

## Troubleshooting

### If the workflow fails:

1. **Check the workflow logs:**
   - Go to **Actions** tab
   - Click on the failed workflow run
   - Review error messages

2. **Common issues:**

   **Issue: "Error: _site directory was not created"**
   - The `prepare-gh-pages.rb` script failed
   - Check that Ruby is working: The workflow sets it up automatically
   - Verify the script runs locally: `ruby prepare-gh-pages.rb`

   **Issue: "Permission denied"**
   - Make sure GitHub Pages permissions are enabled
   - Go to **Settings** → **Actions** → **General**
   - Under "Workflow permissions", select "Read and write permissions"
   - Check "Allow GitHub Actions to create and approve pull requests"

   **Issue: "404 errors on the site"**
   - The old build might still be cached
   - Wait a few minutes for the new deployment to propagate
   - Clear your browser cache
   - Check that `index.html` exists in the root of `_site/`

### If assets don't load:

1. Check the browser console for 404 errors
2. Verify asset paths in the deployed HTML:
   - Root files should have `assets/` (not `../assets/`)
   - Subdirectory files should have `../assets/` (not `../../assets/`)

### If custom domain doesn't work:

1. The `CNAME` file should be in the root of `_site/`
2. DNS is already configured correctly (I can see your Cloudflare DNS)
3. Wait for DNS propagation (can take up to 24 hours)
4. The DNS check in GitHub Pages settings should complete automatically

## After Switching

Once you've switched to GitHub Actions:

- ✅ Every push to `master` will automatically deploy
- ✅ You'll see deployment status in the **Actions** tab
- ✅ Your site will be properly built with correct asset paths
- ✅ Custom domain will continue to work

## Rollback (if needed)

If you need to go back to the old build system:

1. Go to **Settings** → **Pages**
2. Under **Source**, select **Branch: master**
3. Select `/ (root)` or `/docs` as the folder
4. Click **Save**

However, this won't work well with your project structure, so GitHub Actions is the recommended approach.

---

**Next Step:** Follow Step 1 above to commit and push, then switch to GitHub Actions in your repository settings!


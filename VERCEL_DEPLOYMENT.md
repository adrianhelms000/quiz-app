# Deploying to Vercel

Your quiz application is now configured for Vercel deployment!

## Quick Deploy (Recommended)

### Method 1: Deploy via Vercel Dashboard (Easiest)

1. **Go to Vercel**: https://vercel.com
2. **Sign up/Login** with your GitHub account
3. **Click "Add New Project"**
4. **Import your GitHub repository**:
   - Select `adrianhelms000/quiz-app`
   - Vercel will auto-detect SvelteKit
5. **Configure Project**:
   - Framework Preset: **SvelteKit** (should be auto-detected)
   - Root Directory: `./` (default)
   - Build Command: `npm run build` (should be auto-filled)
   - Output Directory: `.svelte-kit` (should be auto-filled)
   - Install Command: `npm install` (should be auto-filled)
6. **Click "Deploy"**
7. **Wait for deployment** (usually 1-2 minutes)
8. **Get your live URL!** (e.g., `https://quiz-app.vercel.app`)

### Method 2: Deploy via Vercel CLI

1. **Install Vercel CLI**:
   ```powershell
   npm install -g vercel
   ```

2. **Login to Vercel**:
   ```powershell
   vercel login
   ```

3. **Deploy**:
   ```powershell
   vercel
   ```

4. **Follow the prompts**:
   - Link to existing project? No (for first time)
   - Project name: `quiz-app` (or your choice)
   - Directory: `./` (press Enter)
   - Override settings? No (press Enter)

5. **For production deployment**:
   ```powershell
   vercel --prod
   ```

## Configuration

The project is configured with:
- ✅ `@sveltejs/adapter-vercel` - Vercel adapter installed
- ✅ `svelte.config.js` - Updated to use Vercel adapter
- ✅ `vercel.json` - Vercel configuration file

## Environment Variables

If you need to add environment variables later:
1. Go to your project on Vercel dashboard
2. Settings → Environment Variables
3. Add your variables

## Custom Domain

After deployment, you can add a custom domain:
1. Go to your project on Vercel
2. Settings → Domains
3. Add your domain

## Automatic Deployments

Vercel automatically deploys:
- **Production**: Every push to `main` branch
- **Preview**: Every push to other branches (creates preview URLs)

## Troubleshooting

**Build fails:**
- Check that all dependencies are in `package.json`
- Ensure `npm run build` works locally
- Check Vercel build logs for errors

**Application not working:**
- Verify the adapter is correct in `svelte.config.js`
- Check browser console for errors
- Review Vercel function logs

**Static files not loading:**
- Ensure files are in `static/` folder
- Check that paths are relative (not absolute)

## Useful Commands

```powershell
# Build locally to test
npm run build

# Preview production build locally
npm run preview

# Deploy to Vercel
vercel

# Deploy to production
vercel --prod

# View deployment logs
vercel logs
```

## Next Steps

After deployment:
1. ✅ Your app will be live at a Vercel URL
2. ✅ Share the URL with others
3. ✅ Set up custom domain (optional)
4. ✅ Configure environment variables if needed

Your quiz application will be live in minutes! 🚀


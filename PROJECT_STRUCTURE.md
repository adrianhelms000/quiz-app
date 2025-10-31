# Project Structure

This document describes the structure of the Quiz Application project.

## Main Project Files

### Source Code
- `src/routes/+page.svelte` - Main quiz application component (complete quiz logic)
- `src/lib/data.json` - Question database with 295 questions (15 per level × 10 levels × 2 subjects)
- `src/lib/index.ts` - Library exports
- `src/app.html` - HTML template
- `src/app.d.ts` - TypeScript declarations

### Configuration
- `package.json` - Project dependencies and scripts
- `svelte.config.js` - SvelteKit configuration
- `vite.config.ts` - Vite build configuration
- `tsconfig.json` - TypeScript configuration
- `.gitignore` - Git ignore rules

### Documentation
- `README.md` - Project overview and usage instructions
- `GITHUB_SETUP.md` - Step-by-step GitHub setup guide
- `PROJECT_STRUCTURE.md` - This file

### Static Assets
- `static/favicon.png` - Site favicon

## Excluded from Repository

The following are excluded via `.gitignore`:
- `node_modules/` - Dependencies (install with `npm install`)
- `.svelte-kit/` - Build cache
- `build/` - Production build output
- Other project folders (`myapp/`, `archive/`, etc.)
- Temporary files (`.txt`, `.log`, etc.)

## What Gets Uploaded to GitHub

When you push to GitHub, these files will be included:
✅ All source code in `src/`
✅ Configuration files (`package.json`, `svelte.config.js`, etc.)
✅ Documentation files (`README.md`, etc.)
✅ Static assets in `static/`
✅ `.gitignore`

❌ NOT included: `node_modules/`, build artifacts, other projects

## Quick Start After Cloning

1. `npm install` - Install dependencies
2. `npm run dev` - Start development server
3. Open `http://localhost:5173`


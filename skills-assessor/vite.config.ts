import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		fs: {
			// Allow serving files from parent directory's node_modules
			allow: [
				// Project root
				path.resolve(__dirname),
				// Parent directory (Documents) for node_modules access
				path.resolve(__dirname, '..')
			]
		}
	}
});


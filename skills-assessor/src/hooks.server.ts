import type { Handle } from '@sveltejs/kit';

// Suppress Chrome DevTools 404 errors
export const handle: Handle = async ({ event, resolve }) => {
	// Handle Chrome DevTools configuration request
	if (event.url.pathname === '/.well-known/appspecific/com.chrome.devtools.json') {
		return new Response(JSON.stringify({}), {
			headers: {
				'Content-Type': 'application/json'
			}
		});
	}

	return resolve(event);
};


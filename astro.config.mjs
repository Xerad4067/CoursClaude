// Configuration du site du cours (Astro + Starlight).
// Pour changer l'adresse de publication, modifie seulement SITE et BASE ci-dessous.
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import { fileURLToPath } from 'node:url';

const SITE = 'https://xerad4067.github.io';
const BASE = process.env.BASE_PATH ?? '/CoursClaude';

// Ajoute automatiquement BASE devant les liens internes écrits en Markdown ([texte](/page/)).
// Sans cela, un lien « /parcours-a/ » pointerait hors du site une fois publié sur GitHub Pages.
function prefixerLiensInternes() {
	const base = BASE.replace(/\/$/, '');
	const visiter = (noeud) => {
		if (noeud.type === 'element' && noeud.tagName === 'a') {
			const href = noeud.properties?.href;
			if (typeof href === 'string' && href.startsWith('/') && !href.startsWith('//') && base && href !== base && !href.startsWith(base + '/')) {
				noeud.properties.href = base + href;
			}
		}
		if (noeud.children) noeud.children.forEach(visiter);
	};
	return () => (arbre) => visiter(arbre);
}

export default defineConfig({
	site: SITE,
	base: BASE,
	trailingSlash: 'always',
	markdown: {
		rehypePlugins: [prefixerLiensInternes()],
	},
	vite: {
		resolve: {
			alias: { '@exercices': fileURLToPath(new URL('./exercices', import.meta.url)) },
		},
	},
	integrations: [
		starlight({
			title: 'Cours Claude · Dev de jeux',
			description: "Cours pas à pas pour devenir autonome : installation, Lua, Nanos World, mapping, Git et bases SLAM.",
			defaultLocale: 'root',
			locales: { root: { label: 'Français', lang: 'fr' } },
			lastUpdated: false,
			pagination: true,
			favicon: '/favicon.svg',
			customCss: [
				'@fontsource/roboto/400.css',
				'@fontsource/roboto/500.css',
				'@fontsource/roboto/700.css',
				'@fontsource/roboto-mono/400.css',
				'@fontsource/roboto-mono/700.css',
				'./src/styles/theme.css',
			],
			expressiveCode: {
				styleOverrides: {
					codeFontFamily: "'Roboto Mono', ui-monospace, monospace",
					uiFontFamily: "'Roboto', system-ui, sans-serif",
					codeFontSize: '0.95rem',
				},
			},
			components: {
				ThemeProvider: './src/overrides/ThemeProvider.astro',
				PageTitle: './src/overrides/PageTitle.astro',
				Footer: './src/overrides/Footer.astro',
			},
			sidebar: [
				{ label: 'Accueil et tableau de bord', link: '/' },
				{ label: 'Installer mon environnement', items: [{ autogenerate: { directory: 'installer' } }] },
				{ label: 'Parcours A · Installer et démarrer', items: [{ autogenerate: { directory: 'parcours-a' } }] },
				{ label: 'Parcours B · Lua et logique', items: [{ autogenerate: { directory: 'parcours-b' } }] },
				{ label: 'Boîte à outils', items: [{ autogenerate: { directory: 'outils' } }] },
				{ label: 'Ma progression', items: [{ autogenerate: { directory: 'moi' } }] },
			],
		}),
	],
});

// Vérifie, dans le site construit (dossier dist/), que tous les liens INTERNES pointent vers une page ou un fichier
// qui existe (et que les ancres #titre existent). Les liens externes ne sont pas testés ici (pas de réseau).
// Utilisation : npm run build && node scripts/verifier-liens.mjs
import fs from 'node:fs';
import path from 'node:path';

const racine = path.resolve(import.meta.dirname, '..');
const dist = path.join(racine, 'dist');
const base = process.env.BASE_PATH ?? '/CoursClaude';
if (!fs.existsSync(dist)) { console.log('dist/ introuvable : lance d\'abord npm run build'); process.exit(1); }

function tous(dossier) {
	return fs.readdirSync(dossier, { withFileTypes: true }).flatMap((e) => {
		const c = path.join(dossier, e.name);
		return e.isDirectory() ? tous(c) : [c];
	});
}
const pages = tous(dist).filter((f) => f.endsWith('.html'));
const ancres = new Map();
const ids = (html) => new Set([...html.matchAll(/\sid="([^"]+)"/g)].map((m) => m[1]));
const cible = (url) => {
	let p = decodeURIComponent(url.slice(base.length)) || '/';
	const f = path.join(dist, p);
	if (p.endsWith('/')) return path.join(f, 'index.html');
	return fs.existsSync(f) && fs.statSync(f).isFile() ? f : path.join(f, 'index.html');
};
let liens = 0, casses = 0;
for (const page of pages) {
	const html = fs.readFileSync(page, 'utf8');
	const rel = path.relative(dist, page);
	for (const m of html.matchAll(/\s(?:href|src)="([^"]+)"/g)) {
		const brut = m[1];
		if (/^(https?:|mailto:|data:|javascript:|#)/.test(brut)) {
			if (brut.startsWith('#') && brut.length > 1) {
				liens++;
				if (!ids(html).has(decodeURIComponent(brut.slice(1)))) { casses++; console.log(`❌ ${rel} : ancre introuvable ${brut}`); }
			}
			continue;
		}
		if (!brut.startsWith('/')) continue;
		liens++;
		const [url, ancre] = brut.split('#');
		if (!url.startsWith(base)) { casses++; console.log(`❌ ${rel} : lien sans la base ${base} : ${brut}`); continue; }
		const f = cible(url);
		if (!fs.existsSync(f)) { casses++; console.log(`❌ ${rel} : lien cassé ${brut}`); continue; }
		if (ancre && f.endsWith('.html')) {
			if (!ancres.has(f)) ancres.set(f, ids(fs.readFileSync(f, 'utf8')));
			if (!ancres.get(f).has(decodeURIComponent(ancre))) { casses++; console.log(`❌ ${rel} : ancre introuvable ${brut}`); }
		}
	}
}
console.log(`Liens internes vérifiés : ${liens} · cassés : ${casses} (dans ${pages.length} pages)`);
process.exit(casses ? 1 : 0);

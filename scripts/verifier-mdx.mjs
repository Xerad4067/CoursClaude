// Compile chaque page MDX pour détecter tout de suite les erreurs de syntaxe (balise non fermée, accolade ou « < » dans le texte…).
// Beaucoup plus rapide qu'un build complet. Utilisation : node scripts/verifier-mdx.mjs [préfixe de chemin, ex. parcours-c]
import fs from 'node:fs';
import path from 'node:path';
import { compile } from '@mdx-js/mdx';
import remarkGfm from 'remark-gfm';

const docs = path.resolve(import.meta.dirname, '../src/content/docs');
const filtre = process.argv[2];
const tous = (d) => fs.readdirSync(d, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? tous(path.join(d, e.name)) : e.name.endsWith('.mdx') ? [path.join(d, e.name)] : []));
let n = 0, ko = 0;
for (const f of tous(docs).sort()) {
	const rel = path.relative(docs, f).replace(/\\/g, '/');
	if (filtre && !rel.startsWith(filtre)) continue;
	n++;
	try {
		// On remplace l'en-tête (frontmatter) par des lignes vides : les numéros de ligne restent justes.
		const texte = fs.readFileSync(f, 'utf8').replace(/^---\n([\s\S]*?)\n---\n/, (m) => '\n'.repeat(m.split('\n').length - 1));
		await compile(texte, { remarkPlugins: [remarkGfm] });
	} catch (e) {
		ko++;
		console.log(`❌ ${rel} : ${e.message.split('\n')[0]} (ligne ${e.line ?? '?'}, colonne ${e.column ?? '?'})`);
	}
}
console.log(`Pages MDX compilées : ${n} · erreurs de syntaxe : ${ko}`);
process.exit(ko ? 1 : 0);

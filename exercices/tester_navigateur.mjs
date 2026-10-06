// tester_navigateur.mjs : vérifie les exercices HTML/CSS/JavaScript dans un vrai navigateur (Chromium).
//
// Pour chaque exercice (dossier exercices/<MODULE>/exNN/) contenant solution.html :
//   * la page est ouverte hors ligne (file://), le JavaScript s'exécute ;
//   * on compare ce que la page AFFICHE (texte visible du <body>, lignes vides retirées) avec attendu.txt ;
//   * config.json (optionnel) : { "clics": ["#bouton"], "saisies": { "#nom": "Sam" } } pour simuler des actions
//     (les saisies sont faites avant les clics, les clics dans l'ordre) ;
//   * casse.html (optionnel, débogage) ne doit PAS donner le bon résultat.
//
// Utilisation : node exercices/tester_navigateur.mjs [MODULE]
// Nécessite Playwright (installé dans l'environnement cloud ; non requis pour suivre le cours).
import { createRequire } from 'node:module';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const racine = path.dirname(fileURLToPath(import.meta.url));
const filtre = process.argv[2];
const require = createRequire(import.meta.url);

let chromium;
for (const chemin of ['playwright', '/opt/node-tools/node_modules/playwright', '/opt/node22/lib/node_modules/playwright']) {
	try {
		({ chromium } = require(chemin));
		break;
	} catch {}
}
if (!chromium) {
	console.log('Playwright introuvable : test navigateur ignoré (voir ETAT_AVANCEMENT_COURS.md).');
	process.exit(0);
}

const normaliser = (t) =>
	t
		.replace(/\r\n/g, '\n')
		.split('\n')
		.map((l) => l.trimEnd())
		.filter((l) => l.trim() !== '')
		.join('\n')
		.trim();

const navigateur = await chromium.launch(process.env.PLAYWRIGHT_BROWSERS_PATH ? { executablePath: '/opt/pw-browsers/chromium' } : {});
let total = 0;
let reussis = 0;
let casses = 0;
const echecs = [];

async function rendre(fichier, config) {
	const page = await navigateur.newPage();
	const erreurs = [];
	page.on('pageerror', (e) => erreurs.push(String(e)));
	await page.goto(pathToFileURL(fichier).href);
	for (const [sel, valeur] of Object.entries(config.saisies ?? {})) await page.fill(sel, valeur);
	for (const sel of config.clics ?? []) await page.click(sel);
	const texte = await page.evaluate(() => document.body.innerText);
	await page.close();
	return { texte, erreurs };
}

const modules = fs
	.readdirSync(racine)
	.filter((d) => !d.startsWith('_') && fs.statSync(path.join(racine, d)).isDirectory())
	.sort();
for (const module of modules) {
	if (filtre && filtre !== module) continue;
	const exos = fs.readdirSync(path.join(racine, module)).filter((d) => d.startsWith('ex')).sort();
	for (const nom of exos) {
		const dossier = path.join(racine, module, nom);
		const solution = path.join(dossier, 'solution.html');
		if (!fs.existsSync(solution)) continue;
		total++;
		const id = `${module}/${nom}`;
		const cfgChemin = path.join(dossier, 'config.json');
		const config = fs.existsSync(cfgChemin) ? JSON.parse(fs.readFileSync(cfgChemin, 'utf8')) : {};
		const attenduChemin = path.join(dossier, 'attendu.txt');
		let probleme;
		try {
			const { texte, erreurs } = await rendre(solution, config);
			if (erreurs.length) probleme = 'erreur JavaScript : ' + erreurs[0];
			else if (!fs.existsSync(attenduChemin)) probleme = 'attendu.txt manquant';
			else if (normaliser(texte) !== normaliser(fs.readFileSync(attenduChemin, 'utf8')))
				probleme = `affichage différent\n      attendu : ${JSON.stringify(normaliser(fs.readFileSync(attenduChemin, 'utf8')))}\n      obtenu  : ${JSON.stringify(normaliser(texte))}`;
			const casse = path.join(dossier, 'casse.html');
			if (!probleme && fs.existsSync(casse)) {
				const r = await rendre(casse, config);
				if (!r.erreurs.length && normaliser(r.texte) === normaliser(fs.readFileSync(attenduChemin, 'utf8'))) probleme = "casse.html donne le bon résultat : il n'est pas cassé";
				else casses++;
			}
		} catch (e) {
			probleme = String(e);
		}
		if (probleme) {
			echecs.push(id);
			console.log(`ÉCHEC ${id} (HTML/JS navigateur) : ${probleme}`);
		} else {
			reussis++;
			console.log(`OK    ${id} (HTML/JS navigateur)`);
		}
	}
}
await navigateur.close();
console.log('-'.repeat(50));
console.log(`Pages testées dans Chromium : ${total} · réussies : ${reussis} · échecs : ${echecs.length}`);
console.log(`Pages « cassées » vérifiées comme vraiment cassées : ${casses}`);
process.exit(echecs.length ? 1 : 0);

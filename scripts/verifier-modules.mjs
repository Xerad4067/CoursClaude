// Contrôle de structure des modules du cours (avant le build). Utilisation : node scripts/verifier-modules.mjs [parcours-x]
// Erreurs (❌) : à corriger. Avertissements (⚠️) : à regarder. Code de sortie 1 s'il y a au moins une erreur.
import fs from 'node:fs';
import path from 'node:path';

const racine = path.resolve(import.meta.dirname, '..');
const docs = path.join(racine, 'src/content/docs');
const filtre = process.argv[2];

function fichiers(dossier) {
	return fs.readdirSync(dossier, { withFileTypes: true }).flatMap((e) => {
		const chemin = path.join(dossier, e.name);
		return e.isDirectory() ? fichiers(chemin) : chemin.endsWith('.mdx') ? [chemin] : [];
	});
}
const front = (txt) => {
	const m = txt.match(/^---\n([\s\S]*?)\n---\n/);
	const d = {};
	if (m) for (const l of m[1].split('\n')) { const k = l.match(/^([a-z]+):\s*(.*)$/); if (k) d[k[1]] = k[2].replace(/^["']|["']$/g, ''); }
	return d;
};
const attr = (b, n) => { const m = b.match(new RegExp(`\\b${n}=(?:"([^"]*)"|'([^']*)')`)); return m ? (m[1] ?? m[2]) : undefined; };
const existeSolution = (dossier) => ['lua', 'py', 'js', 'sql', 'sh', 'html'].some((e) => fs.existsSync(path.join(racine, 'exercices', dossier, `solution.${e}`)));

let erreurs = 0, avertissements = 0, modules = 0, exercicesTotal = 0;
const idsVus = new Map();
const interdits = [/à compléter/i, /\bTODO\b/, /lorem ipsum/i, /leo\.gnvr/i, /gmail\.com/i, /ghp_[A-Za-z0-9]{20,}/, /github_pat_/];

for (const f of fichiers(docs).sort()) {
	const rel = path.relative(docs, f).replace(/\\/g, '/');
	if (filtre && !rel.startsWith(filtre)) continue;
	const txt = fs.readFileSync(f, 'utf8');
	const d = front(txt);
	const E = (m) => { erreurs++; console.log(`❌ ${rel} : ${m}`); };
	const W = (m) => { avertissements++; console.log(`⚠️  ${rel} : ${m}`); };
	for (const re of interdits) if (re.test(txt)) E(`texte interdit trouvé (${re})`);
	// Identifiants uniques sur tout le site (étapes, exercices, quiz).
	for (const b of txt.match(/<(FinEtape|Exercice|Quiz)\b[^>]*>/g) ?? []) {
		const id = attr(b, 'id');
		if (!id) { E(`balise sans id : ${b.slice(0, 60)}`); continue; }
		if (idsVus.has(id)) E(`identifiant en double : ${id} (aussi dans ${idsVus.get(id)})`);
		idsVus.set(id, rel);
	}
	const code = d.module ?? '';
	const estModule = /^[A-Z]{1,2}\d+$/.test(code);
	if (!estModule) continue;
	modules++;
	const parcours = d.parcours;
	const strict = parcours !== 'A'; // le parcours A (installation) n'a pas de code à tester
	const E2 = (m) => (strict ? E(m) : W(m));
	for (const k of ['title', 'parcours', 'module', 'duree', 'ou', 'prerequis', 'resultat']) if (!d[k]) E(`frontmatter « ${k} » manquant`);
	if (!/^objectifs:/m.test(txt)) E('frontmatter « objectifs » manquant');
	if (!txt.includes('<TroisDurees')) E('TroisDurees manquant');
	if (!txt.includes('<Videos')) E2('Videos manquant');
	if (!/^## Récapitulatif/m.test(txt)) E('section « ## Récapitulatif » manquante');
	if (!/^## Je suis bloqué/m.test(txt)) E('section « ## Je suis bloqué » manquante');
	if (!/^## Pour aller plus loin/m.test(txt)) E('section « ## Pour aller plus loin » manquante');
	if (!/^## Exercices/m.test(txt)) E('section « ## Exercices » manquante');
	if (!/^## Quiz/m.test(txt)) E('section « ## Quiz » manquante');
	if (!/Pourquoi c'est utile/i.test(txt)) W("pas de phrase « Pourquoi c'est utile ? »");
	if (!/^## Erreurs fréquentes/m.test(txt)) W('section « ## Erreurs fréquentes » manquante');
	if (!/^## Rappel|<Rappel/m.test(txt) && !['A', 'B', 'X'].includes(parcours)) E('Rappel (révision espacée) manquant (obligatoire à partir du parcours C)');
	const etapes = (txt.match(/<FinEtape\b/g) ?? []).length;
	if (etapes < 3) E(`seulement ${etapes} étape(s) (FinEtape) : 3 minimum`);
	if (!txt.includes('<Encadre')) W('aucun encadré');
	// Plus loin : 2 à 4 liens externes
	const plusLoin = txt.split(/^## Pour aller plus loin/m)[1] ?? '';
	const liens = (plusLoin.match(/\]\(https?:\/\//g) ?? []).length;
	if (liens < 2) E(`« Pour aller plus loin » : ${liens} lien(s) externe(s), 2 minimum`);
	if (liens > 4) W(`« Pour aller plus loin » : ${liens} liens (4 maximum conseillé)`);
	// Quiz : 10 questions
	for (const quiz of txt.match(/<Quiz\b[\s\S]*?\/>/g) ?? []) {
		const n = (quiz.match(/\{\s*q:/g) ?? []).length;
		if (n !== 10) E(`quiz ${attr(quiz, 'id')} : ${n} question(s), 10 attendues`);
	}
	if (!/<Quiz\b/.test(txt)) E('aucun Quiz');
	// Exercices
	const blocs = [...txt.matchAll(/<Exercice\b([^>]*)>([\s\S]*?)<\/Exercice>/g)];
	exercicesTotal += blocs.length;
	const max = parcours === 'X' ? 40 : 15;
	if (blocs.length < 8) E(`${blocs.length} exercice(s) : 8 minimum`);
	if (blocs.length > max) W(`${blocs.length} exercices : plus de ${max}`);
	const niveaux = { vert: 0, jaune: 0, rouge: 0 };
	let debug = 0, lecture = 0, projet = 0;
	for (const [, a, corps] of blocs) {
		const id = attr(a, 'id') ?? '?';
		const niveau = attr(a, 'niveau');
		const type = attr(a, 'type');
		const dossier = attr(a, 'dossier');
		if (!(niveau in niveaux)) E(`${id} : niveau invalide`); else niveaux[niveau]++;
		if (type === 'debug') debug++; if (type === 'lecture') lecture++; if (type === 'projet') projet++;
		if (!new RegExp(`^${code}-ex\\d{2}$`).test(id)) W(`${id} : l'identifiant devrait être ${code}-exNN`);
		for (const s of ['indice1', 'indice2', 'indice3', 'solution']) if (!corps.includes(`slot="${s}"`)) E(`${id} : slot « ${s} » manquant`);
		if (dossier) {
			if (!existeSolution(dossier)) E(`${id} : exercices/${dossier}/solution.* introuvable`);
			else if (!fs.existsSync(path.join(racine, 'exercices', dossier, 'attendu.txt'))) E(`${id} : attendu.txt manquant`);
			if (type === 'debug' && !['lua', 'py', 'js', 'sql', 'sh', 'html'].some((e) => fs.existsSync(path.join(racine, 'exercices', dossier, `casse.${e}`)))) E(`${id} : exercice de débogage sans casse.*`);
		} else if (['B', 'C', 'D'].includes(parcours)) W(`${id} : pas de dossier de solution testée`);
	}
	if (!niveaux.vert || !niveaux.jaune || !niveaux.rouge) E(`les trois niveaux 🟢🟡🔴 sont requis (vert ${niveaux.vert}, jaune ${niveaux.jaune}, rouge ${niveaux.rouge})`);
	if (!debug) E2('aucun exercice de débogage (type="debug")');
	if (!lecture) E2('aucun exercice de lecture (type="lecture")');
	if (!projet) E2('aucun mini-projet (type="projet")');
}
console.log('-'.repeat(50));
console.log(`Modules contrôlés : ${modules} · exercices : ${exercicesTotal} · erreurs : ${erreurs} · avertissements : ${avertissements}`);
process.exit(erreurs ? 1 : 0);

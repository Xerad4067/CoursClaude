// Progression du cours, stockée UNIQUEMENT dans ce navigateur (localStorage).
// Aucune donnée n'est envoyée à un serveur. Export / import pour passer d'une machine à l'autre.

const CLE = 'cours-progression-v1';

/** Date du jour au format AAAA-MM-JJ (heure locale). */
export function aujourdhui(date = new Date()) {
	const p = (n) => String(n).padStart(2, '0');
	return `${date.getFullYear()}-${p(date.getMonth() + 1)}-${p(date.getDate())}`;
}

function normaliser(d = {}) {
	return {
		version: 1,
		etapes: d.etapes || {},
		exercices: d.exercices || {},
		quiz: d.quiz || {},
		checklist: d.checklist || {},
		jours: Array.isArray(d.jours) ? d.jours : [],
		derniere: d.derniere || null,
		journal: Array.isArray(d.journal) ? d.journal : [],
		derniereExport: d.derniereExport || null,
	};
}

export function charger() {
	try {
		return normaliser(JSON.parse(localStorage.getItem(CLE) || '{}'));
	} catch {
		return normaliser();
	}
}

export function sauver(p, { silencieux = false } = {}) {
	try {
		localStorage.setItem(CLE, JSON.stringify(p));
	} catch {
		/* navigation privée ou stockage bloqué : le site reste utilisable */
	}
	if (!silencieux) window.dispatchEvent(new CustomEvent('progression:maj'));
}

/** Note qu'il y a eu une activité aujourd'hui (pour la série de jours). */
export function marquerJour(p) {
	const j = aujourdhui();
	if (!p.jours.includes(j)) p.jours.push(j);
}

/** Coche ou décoche un élément : type = 'etapes' | 'exercices' | 'checklist'. */
export function basculer(type, id, coche) {
	const p = charger();
	if (coche) p[type][id] = aujourdhui();
	else delete p[type][id];
	marquerJour(p);
	sauver(p);
	return p;
}

export function enregistrerQuiz(id, score, total) {
	const p = charger();
	const avant = p.quiz[id];
	if (!avant || score > avant.score) p.quiz[id] = { score, total, date: aujourdhui() };
	marquerJour(p);
	sauver(p);
	return p;
}

// ---------- Niveaux, XP, série, badges ----------

export const NIVEAUX = [
	{ nom: 'Novice', xp: 0, icone: '🌱' },
	{ nom: 'Apprenti', xp: 300, icone: '🔧' },
	{ nom: 'Scripteur', xp: 1500, icone: '📜' },
	{ nom: 'Mappeur', xp: 3500, icone: '🗺️' },
	{ nom: 'Développeur', xp: 6000, icone: '🚀' },
];

const XP_NIVEAU_EXO = { vert: 10, jaune: 20, rouge: 30 };

function indexer(manifeste) {
	const exos = {};
	for (const page of manifeste.pages) for (const e of page.exercices) exos[e.id] = e;
	return exos;
}

export function calculerXP(p, manifeste) {
	const exos = indexer(manifeste);
	let xp = Object.keys(p.etapes).length * 10;
	for (const id of Object.keys(p.exercices)) xp += XP_NIVEAU_EXO[exos[id]?.niveau] ?? 10;
	for (const q of Object.values(p.quiz)) xp += (q.score || 0) * 5;
	xp += Object.keys(p.checklist).length * 5;
	return xp;
}

export function niveauPour(xp) {
	let actuel = NIVEAUX[0];
	for (const n of NIVEAUX) if (xp >= n.xp) actuel = n;
	const suivant = NIVEAUX[NIVEAUX.indexOf(actuel) + 1] || null;
	return { actuel, suivant };
}

/** Série actuelle : jours consécutifs jusqu'à aujourd'hui (ou hier : une journée sans cours ne remet rien à zéro tout de suite). */
export function serieActuelle(p) {
	const jours = new Set(p.jours);
	const d = new Date();
	if (!jours.has(aujourdhui(d))) d.setDate(d.getDate() - 1);
	let n = 0;
	while (jours.has(aujourdhui(d))) {
		n++;
		d.setDate(d.getDate() - 1);
	}
	return n;
}

/** Avancement d'une liste de pages : { fait, total, pourcent }. */
export function avancement(p, pages) {
	let fait = 0;
	let total = 0;
	for (const page of pages) {
		for (const e of page.etapes) {
			total++;
			if (p.etapes[e.id]) fait++;
		}
		for (const e of page.exercices) {
			total++;
			if (p.exercices[e.id]) fait++;
		}
		for (const q of page.quiz) {
			total++;
			if (p.quiz[q.id] && p.quiz[q.id].score >= Math.ceil(p.quiz[q.id].total * 0.7)) fait++;
		}
	}
	return { fait, total, pourcent: total ? Math.round((fait / total) * 100) : 0 };
}

export function badges(p, manifeste) {
	const exos = indexer(manifeste);
	const parcours = (lettre) => manifeste.pages.filter((pg) => pg.parcours === lettre);
	const fini = (lettre) => parcours(lettre).length > 0 && avancement(p, parcours(lettre)).pourcent === 100;
	const nbDebug = Object.keys(p.exercices).filter((id) => exos[id]?.type === 'debug').length;
	const nbRouges = Object.keys(p.exercices).filter((id) => exos[id]?.niveau === 'rouge').length;
	const quizParfait = Object.values(p.quiz).some((q) => q.score === q.total && q.total > 0);
	const jours = [...p.jours].sort();
	let retour = false;
	for (let i = 1; i < jours.length; i++) {
		if ((new Date(jours[i]) - new Date(jours[i - 1])) / 86400000 >= 4) retour = true;
	}
	return [
		{ icone: '👣', nom: 'Premier pas', detail: 'Terminer ta première étape', obtenu: Object.keys(p.etapes).length >= 1 },
		{ icone: '🧰', nom: 'Machines prêtes', detail: 'Cocher 10 points de la checklist des machines', obtenu: Object.keys(p.checklist).length >= 10 },
		{ icone: '✍️', nom: 'Premier exercice', detail: 'Réussir un exercice', obtenu: Object.keys(p.exercices).length >= 1 },
		{ icone: '🐞', nom: 'Chasseur de bugs', detail: 'Réussir 5 exercices de débogage', obtenu: nbDebug >= 5 },
		{ icone: '🔥', nom: 'Amateur de défis', detail: 'Réussir 5 exercices 🔴', obtenu: nbRouges >= 5 },
		{ icone: '🎯', nom: 'Sans faute', detail: 'Obtenir 10/10 à un quiz', obtenu: quizParfait },
		{ icone: '📅', nom: 'Régulier', detail: 'Travailler 3 jours de suite', obtenu: serieActuelle(p) >= 3 || aMeilleureSerie(jours, 3) },
		{ icone: '🌈', nom: 'Retour gagnant', detail: 'Revenir après une pause de plusieurs jours (les pauses font partie du jeu)', obtenu: retour },
		{ icone: '🅰️', nom: 'Parcours A terminé', detail: 'Tout cocher dans le parcours A', obtenu: fini('A') },
		{ icone: '🌙', nom: 'Parcours B terminé', detail: 'Tout cocher dans le parcours B', obtenu: fini('B') },
	];
}

function aMeilleureSerie(joursTries, n) {
	let serie = 1;
	for (let i = 1; i < joursTries.length; i++) {
		const ecart = (new Date(joursTries[i]) - new Date(joursTries[i - 1])) / 86400000;
		serie = ecart === 1 ? serie + 1 : 1;
		if (serie >= n) return true;
	}
	return n <= 1 && joursTries.length > 0;
}

// ---------- Export / import (synchronisation entre tes deux machines) ----------

export function exporter() {
	const p = charger();
	p.derniereExport = new Date().toISOString();
	sauver(p);
	const blob = new Blob([JSON.stringify(p, null, 2)], { type: 'application/json' });
	const a = document.createElement('a');
	a.href = URL.createObjectURL(blob);
	a.download = 'progression-cours.json';
	document.body.appendChild(a);
	a.click();
	a.remove();
	setTimeout(() => URL.revokeObjectURL(a.href), 1000);
}

/** Fusionne deux progressions : on garde tout ce qui a été fait sur l'une OU l'autre machine. */
export function fusionner(a, b) {
	const x = normaliser(a);
	const y = normaliser(b);
	const quiz = { ...x.quiz };
	for (const [id, q] of Object.entries(y.quiz)) if (!quiz[id] || q.score > quiz[id].score) quiz[id] = q;
	const journal = [...x.journal];
	for (const n of y.journal) if (!journal.some((m) => m.date === n.date && m.texte === n.texte)) journal.push(n);
	journal.sort((m, n) => (m.date < n.date ? 1 : -1));
	const plusRecente = (u, v) => (!u ? v : !v ? u : u.date > v.date ? u : v);
	return normaliser({
		etapes: { ...y.etapes, ...x.etapes },
		exercices: { ...y.exercices, ...x.exercices },
		checklist: { ...y.checklist, ...x.checklist },
		quiz,
		jours: [...new Set([...x.jours, ...y.jours])].sort(),
		derniere: plusRecente(x.derniere, y.derniere),
		journal,
		derniereExport: x.derniereExport,
	});
}

export async function importer(fichier) {
	const texte = await fichier.text();
	const donnees = JSON.parse(texte);
	if (typeof donnees !== 'object' || donnees === null || donnees.version !== 1) {
		throw new Error("Ce fichier ne ressemble pas à une progression du cours (champ « version » manquant).");
	}
	const p = fusionner(charger(), donnees);
	sauver(p);
	return p;
}

/** Relie toutes les cases à cocher d'une page à la progression. */
export function brancherCases(racine = document) {
	const p = charger();
	const liens = [
		['[data-case-exercice]', 'exercices', 'caseExercice'],
		['[data-case-etape]', 'etapes', 'caseEtape'],
		['[data-case-checklist]', 'checklist', 'caseChecklist'],
	];
	for (const [selecteur, type, cle] of liens) {
		racine.querySelectorAll(selecteur).forEach((input) => {
			const id = input.dataset[cle];
			input.checked = Boolean(p[type][id]);
			input.addEventListener('change', () => basculer(type, id, input.checked));
		});
	}
}

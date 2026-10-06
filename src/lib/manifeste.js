// Construit, au moment du build, la liste de tout ce qui peut être coché dans le cours
// (étapes, exercices, quiz), dans l'ordre des parcours. Le tableau de bord s'en sert.
import { getCollection } from 'astro:content';

function attribut(balise, nom) {
	const m = balise.match(new RegExp(`\\b${nom}=(?:"([^"]*)"|'([^']*)')`));
	return m ? (m[1] ?? m[2]) : undefined;
}

function balises(corps, nom) {
	return [...corps.matchAll(new RegExp(`<${nom}\\b[^>]*>`, 'g'))].map((m) => m[0]);
}

export async function construireManifeste() {
	const base = import.meta.env.BASE_URL.replace(/\/$/, '');
	const entrees = await getCollection('docs');
	const pages = entrees
		.filter((e) => e.data.parcours)
		.map((e) => {
			const corps = e.body ?? '';
			return {
				id: e.id,
				url: `${base}/${e.id}/`,
				titre: e.data.title,
				parcours: e.data.parcours,
				module: e.data.module ?? '',
				ordre: e.data.sidebar?.order ?? 999,
				etapes: balises(corps, 'FinEtape').map((b) => ({
					id: attribut(b, 'id'),
					titre: attribut(b, 'titre'),
					prochaine: attribut(b, 'prochaine'),
				})),
				exercices: balises(corps, 'Exercice').map((b) => ({
					id: attribut(b, 'id'),
					titre: attribut(b, 'titre'),
					niveau: attribut(b, 'niveau'),
					type: attribut(b, 'type') ?? '',
				})),
				quiz: balises(corps, 'Quiz').map((b) => ({ id: attribut(b, 'id') })),
			};
		});
	pages.sort((a, b) => a.parcours.localeCompare(b.parcours) || a.ordre - b.ordre || a.id.localeCompare(b.id));
	// Contrôle qualité : un identifiant en double casserait la progression.
	const vus = new Set();
	for (const p of pages) {
		for (const x of [...p.etapes, ...p.exercices, ...p.quiz]) {
			if (!x.id) throw new Error(`Élément sans id dans ${p.id}`);
			if (vus.has(x.id)) throw new Error(`Identifiant en double : ${x.id} (${p.id})`);
			vus.add(x.id);
		}
	}
	return { pages };
}

// Contrôleur commun des labos « exécuter du code » (Lua et Python).
// Le moteur tourne dans un Web Worker : on peut l'arrêter (boucle infinie) sans figer la page,
// et il n'est chargé qu'au premier clic sur « Exécuter » (la page se lit sans lui).
// Protocole des messages avec le worker (voir labo-lua.worker.js et labo-python.worker.js) :
//   page -> worker : { type: 'run', code, entrees, echo, base }
//   worker -> page : { type: 'etat', texte } | { type: 'pret', info } | { type: 'demarre' }
//                    { type: 'sortie', texte, erreur } | { type: 'fin', ok, message, ligne }
//                    { type: 'echec-moteur', message }
import { allerALigne, annoncer, brancherEditeur, copierTexte, decouperEntrees, ecrireStockage, effacerFragment, lireFragment, lireStockage, remplacerContenu } from './labo-commun.js';

const MAX_CARACTERES = 200_000; // au-delà, la sortie est coupée et l'exécution arrêtée

/**
 * @param {HTMLElement} racine  l'élément .labo du composant
 * @param {object} config { langue, nom, creerWorker, delaiDefaut, conseil }
 */
export function brancherLaboCode(racine, config) {
	const $ = (sel) => racine.querySelector(sel);
	const zone = $('[data-zone="code"]');
	const zoneEntrees = $('[data-zone="entrees"]');
	const sortie = $('[data-role="sortie"]');
	const statut = $('[data-role="statut"]');
	const info = $('[data-role="moteur"]');
	const message = $('[data-role="message"]');
	const ligneErreur = $('[data-role="ligne-erreur"]');
	const precedent = $('[data-role="precedent"]');
	const selectExemples = $('[data-role="exemples"]');
	const selectDelai = $('[data-role="delai"]');
	const caseEcho = $('[data-role="echo"]');
	const boutonExecuter = $('[data-action="executer"]');
	const boutonArreter = $('[data-action="arreter"]');
	const detailsEntrees = $('[data-role="details-entrees"]');
	const donnees = JSON.parse($('[data-role="donnees"]').textContent || '{}');
	const exemples = donnees.exemples || [];
	const cle = config.langue;

	// ---- État mémorisé (localStorage, avec try/catch dans labo-commun) ----
	const memo = lireStockage(cle, {}) || {};
	const exemple0 = exemples[0] || { code: '', entrees: '' };
	zone.value = typeof memo.code === 'string' ? memo.code : exemple0.code;
	zoneEntrees.value = typeof memo.entrees === 'string' ? memo.entrees : exemple0.entrees || '';
	if (selectDelai && [5, 10, 30, 60].includes(memo.delai)) selectDelai.value = String(memo.delai);
	if (caseEcho && typeof memo.echo === 'boolean') caseEcho.checked = memo.echo;
	let ancien = typeof memo.precedent === 'string' ? memo.precedent : null;

	const sauver = () => ecrireStockage(cle, { code: zone.value, entrees: zoneEntrees.value, delai: Number(selectDelai?.value) || config.delaiDefaut, echo: caseEcho ? caseEcho.checked : true, precedent: ancien });

	const editeur = brancherEditeur(zone, {
		gouttiere: $('[data-role="gouttiere"]'),
		position: $('[data-role="position"]'),
		surExecuter: () => executer(),
		surChangement: () => {
			sauver();
			ligneErreur.hidden = true;
		},
	});
	brancherEditeur(zoneEntrees, { surExecuter: () => executer(), surChangement: sauver });

	const montrerPrecedent = () => {
		precedent.hidden = ancien === null;
	};
	// Garde l'ancien code avant de le remplacer (exemple, exercice, réinitialisation) : rien n'est perdu.
	const remplacerCode = (code, entrees, texteMessage) => {
		if (zone.value.trim() !== '' && zone.value !== code) ancien = zone.value;
		remplacerContenu(zone, code);
		zoneEntrees.value = entrees || '';
		if (detailsEntrees) detailsEntrees.open = (entrees || '') !== '';
		sauver();
		montrerPrecedent();
		editeur.majGouttiere();
		editeur.majPosition();
		ligneErreur.hidden = true;
		annoncer(message, texteMessage);
	};
	montrerPrecedent();

	// ---- Code venu d'un exercice : #code=<base64url> (le fragment ne part jamais vers un serveur) ----
	const frag = lireFragment();
	if (typeof frag.code === 'string') {
		remplacerCode(frag.code, frag.entrees || '', "Code de l'exercice chargé dans le labo. Ton code d'avant est gardé : bouton « Retrouver mon code d'avant ».");
		effacerFragment();
	}
	if (detailsEntrees && zoneEntrees.value !== '') detailsEntrees.open = true;

	// ---- Exécution ----
	let worker = null;
	let etat = 'repos'; // 'repos' | 'chargement' | 'execution'
	let minuteur = null;
	let debutExecution = 0;
	let file = [];
	let total = 0;
	let rafEnCours = false;
	let premiereCharge = true;

	const reglerEtat = (nouveau) => {
		etat = nouveau;
		boutonExecuter.disabled = etat !== 'repos';
		boutonArreter.disabled = etat === 'repos';
		racine.dataset.etat = etat;
		sortie.setAttribute('aria-busy', etat === 'repos' ? 'false' : 'true');
	};
	reglerEtat('repos');

	const afficherFile = () => {
		rafEnCours = false;
		const lot = file;
		file = [];
		for (const { texte, erreur } of lot) {
			if (erreur) {
				const s = document.createElement('span');
				s.className = 'err';
				s.textContent = texte;
				sortie.appendChild(s);
			} else {
				sortie.appendChild(document.createTextNode(texte));
			}
		}
		sortie.scrollTop = sortie.scrollHeight;
	};
	const planifierAffichage = () => {
		if (!rafEnCours) {
			rafEnCours = true;
			(typeof requestAnimationFrame === 'function' ? requestAnimationFrame : setTimeout)(afficherFile);
		}
	};
	const ecrire = (texte, erreur = false) => {
		file.push({ texte, erreur });
		planifierAffichage();
	};
	const ajouterLigneFinale = (texte, classe) => {
		afficherFile();
		const p = document.createElement('span');
		p.className = classe;
		p.textContent = (sortie.textContent && !sortie.textContent.endsWith('\n') ? '\n' : '') + texte + '\n';
		sortie.appendChild(p);
		sortie.scrollTop = sortie.scrollHeight;
	};

	const arreterWorker = () => {
		clearTimeout(minuteur);
		if (worker) {
			worker.terminate();
			worker = null;
		}
	};

	const arreter = (raison) => {
		if (etat === 'repos') return;
		arreterWorker();
		afficherFile();
		if (raison === 'delai') {
			const s = Number(selectDelai?.value) || config.delaiDefaut;
			ajouterLigneFinale(`⏱ Arrêté : le programme tournait depuis plus de ${s} secondes (boucle infinie ?).`, 'err');
			annoncer(statut, `Arrêté après ${s} secondes.`, 0);
		} else if (raison === 'sortie') {
			ajouterLigneFinale(`✂ Arrêté : la sortie dépasse ${MAX_CARACTERES.toLocaleString('fr-FR')} caractères (boucle qui affiche sans fin ?).`, 'err');
			annoncer(statut, 'Arrêté : sortie trop longue.', 0);
		} else {
			ajouterLigneFinale('⏹ Arrêté par toi.', 'note');
			annoncer(statut, 'Exécution arrêtée.', 0);
		}
		reglerEtat('repos');
	};

	const finir = (m) => {
		clearTimeout(minuteur);
		afficherFile();
		const duree = Math.max(1, Math.round(performance.now() - debutExecution));
		if (m.ok) {
			if (total === 0) ajouterLigneFinale("(Le programme n'a rien affiché.)", 'note');
			annoncer(statut, `✅ Terminé en ${duree} ms.`, 0);
		} else {
			ajouterLigneFinale(m.message || 'Erreur.', 'err');
			annoncer(statut, `❌ Erreur après ${duree} ms.`, 0);
			if (m.ligne) {
				ligneErreur.hidden = false;
				const bouton = ligneErreur.querySelector('button');
				bouton.textContent = `Aller à la ligne ${m.ligne}`;
				bouton.dataset.ligne = String(m.ligne);
			}
			const conseil = config.conseil ? config.conseil(m.message || '', decouperEntrees(zoneEntrees.value).length) : null;
			if (conseil) ajouterLigneFinale(conseil, 'note');
		}
		reglerEtat('repos');
	};

	const surMessage = (e) => {
		const m = e.data || {};
		switch (m.type) {
			case 'etat':
				annoncer(statut, m.texte, 0);
				break;
			case 'pret':
				info.textContent = m.info;
				premiereCharge = false;
				break;
			case 'demarre': {
				reglerEtat('execution');
				debutExecution = performance.now();
				const s = Number(selectDelai?.value) || config.delaiDefaut;
				annoncer(statut, `Exécution en cours… (arrêt automatique après ${s} s)`, 0);
				clearTimeout(minuteur);
				minuteur = setTimeout(() => arreter('delai'), s * 1000);
				break;
			}
			case 'sortie':
				total += m.texte.length;
				if (total > MAX_CARACTERES) {
					arreter('sortie');
				} else {
					ecrire(m.texte, !!m.erreur);
				}
				break;
			case 'fin':
				finir(m);
				break;
			case 'echec-moteur':
				arreterWorker();
				afficherFile();
				ajouterLigneFinale(`Le moteur ${config.nom} n'a pas pu démarrer : ${m.message}`, 'err');
				ajouterLigneFinale("Le reste de la page fonctionne. Recharge la page et réessaie ; si ça persiste, utilise l'installation locale (voir la page « Installer mon environnement »).", 'note');
				annoncer(statut, 'Le moteur ne démarre pas.', 0);
				reglerEtat('repos');
				break;
		}
	};

	const creerWorker = () => {
		const w = config.creerWorker();
		w.onmessage = surMessage;
		w.onerror = (e) => {
			e.preventDefault?.();
			surMessage({ data: { type: 'echec-moteur', message: e.message || 'erreur inconnue du worker' } });
		};
		w.onmessageerror = () => surMessage({ data: { type: 'echec-moteur', message: 'message illisible' } });
		return w;
	};

	function executer() {
		if (etat !== 'repos') return;
		sortie.textContent = '';
		file = [];
		total = 0;
		ligneErreur.hidden = true;
		sauver();
		reglerEtat('chargement');
		if (!worker) {
			annoncer(statut, premiereCharge ? `Chargement du moteur ${config.nom} (${config.poids}, une seule fois)…` : `Redémarrage du moteur ${config.nom}…`, 0);
			try {
				worker = creerWorker();
			} catch (err) {
				surMessage({ data: { type: 'echec-moteur', message: String(err && err.message ? err.message : err) } });
				return;
			}
		} else {
			annoncer(statut, 'Préparation…', 0);
		}
		worker.postMessage({
			type: 'run',
			code: zone.value,
			entrees: decouperEntrees(zoneEntrees.value),
			echo: caseEcho ? caseEcho.checked : true,
			base: import.meta.env.BASE_URL,
		});
	}

	// ---- Boutons et réglages ----
	boutonExecuter.addEventListener('click', executer);
	boutonArreter.addEventListener('click', () => arreter('manuel'));
	$('[data-action="copier"]').addEventListener('click', async () => {
		const ok = await copierTexte(zone.value);
		annoncer(message, ok ? 'Code copié dans le presse-papiers.' : 'Copie impossible : sélectionne le code et fais Ctrl+C.');
	});
	$('[data-action="reinitialiser"]').addEventListener('click', () => {
		remplacerCode(exemple0.code, exemple0.entrees || '', "Code remis à l'exemple de départ. Ton code d'avant est gardé : bouton « Retrouver mon code d'avant ».");
	});
	precedent.querySelector('button').addEventListener('click', () => {
		if (ancien === null) return;
		const reprise = ancien;
		ancien = zone.value;
		remplacerContenu(zone, reprise);
		sauver();
		editeur.majGouttiere();
		editeur.majPosition();
		annoncer(message, "Ton code d'avant est revenu.");
	});
	ligneErreur.querySelector('button').addEventListener('click', (e) => allerALigne(zone, Number(e.currentTarget.dataset.ligne)));
	if (selectExemples) {
		selectExemples.addEventListener('change', () => {
			const i = Number(selectExemples.value);
			selectExemples.value = '';
			if (Number.isNaN(i) || !exemples[i]) return;
			remplacerCode(exemples[i].code, exemples[i].entrees || '', `Exemple « ${exemples[i].titre} » chargé. Clique sur Exécuter.`);
		});
	}
	selectDelai?.addEventListener('change', sauver);
	caseEcho?.addEventListener('change', sauver);

	// Libère le worker si on quitte la page.
	window.addEventListener('pagehide', arreterWorker);
}

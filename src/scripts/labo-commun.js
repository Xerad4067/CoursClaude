// Fonctions communes aux mini-labos (Lua, Python, SQL, HTML/CSS/JS).
// Rien n'est envoyé à un serveur : tout reste dans ce navigateur (localStorage pour mémoriser ton code).

const PREFIXE = 'cours-labo-';

/** Lit une valeur mémorisée (JSON). Ne plante jamais : navigation privée ou stockage bloqué => valeur par défaut. */
export function lireStockage(nom, defaut = null) {
	try {
		const brut = localStorage.getItem(PREFIXE + nom);
		return brut === null ? defaut : JSON.parse(brut);
	} catch {
		return defaut;
	}
}

/** Mémorise une valeur (JSON). Renvoie false si le stockage est indisponible. */
export function ecrireStockage(nom, valeur) {
	try {
		localStorage.setItem(PREFIXE + nom, JSON.stringify(valeur));
		return true;
	} catch {
		return false;
	}
}

/** Texte (UTF-8) vers base64url, utilisable dans un fragment d'URL (#code=...). */
export function versBase64Url(texte) {
	const octets = new TextEncoder().encode(texte);
	let binaire = '';
	for (let i = 0; i < octets.length; i += 0x8000) {
		binaire += String.fromCharCode(...octets.subarray(i, i + 0x8000));
	}
	return btoa(binaire).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

/** base64url vers texte (UTF-8). Renvoie null si le texte n'est pas du base64url valide. */
export function depuisBase64Url(valeur) {
	try {
		const b64 = valeur.replace(/-/g, '+').replace(/_/g, '/');
		const binaire = atob(b64 + '='.repeat((4 - (b64.length % 4)) % 4));
		return new TextDecoder().decode(Uint8Array.from(binaire, (c) => c.charCodeAt(0)));
	} catch {
		return null;
	}
}

/**
 * Lit le fragment de l'URL (la partie après #, qui ne part jamais vers un serveur).
 * Clés reconnues : code, entrees, html, css, js (en base64url) et base (texte simple).
 */
export function lireFragment() {
	const resultat = {};
	try {
		const brut = location.hash.replace(/^#/, '');
		if (!brut) return resultat;
		const params = new URLSearchParams(brut);
		for (const cle of ['code', 'entrees', 'html', 'css', 'js']) {
			const v = params.get(cle);
			if (v !== null) {
				const texte = depuisBase64Url(v);
				if (texte !== null) resultat[cle] = texte;
			}
		}
		const base = params.get('base');
		if (base && /^[\w-]{1,60}$/.test(base)) resultat.base = base;
	} catch {
		/* fragment illisible : on l'ignore */
	}
	return resultat;
}

/** Retire le fragment de la barre d'adresse (pour qu'un rechargement n'écrase pas ton travail). */
export function effacerFragment() {
	try {
		history.replaceState(null, '', location.pathname + location.search);
	} catch {
		/* sans importance */
	}
}

/** Copie un texte dans le presse-papiers. Renvoie true si ça a marché. */
export async function copierTexte(texte) {
	try {
		await navigator.clipboard.writeText(texte);
		return true;
	} catch {
		/* on essaie la méthode de secours */
	}
	try {
		const t = document.createElement('textarea');
		t.value = texte;
		t.setAttribute('readonly', '');
		t.style.position = 'fixed';
		t.style.opacity = '0';
		document.body.appendChild(t);
		t.select();
		const ok = document.execCommand('copy');
		t.remove();
		return ok;
	} catch {
		return false;
	}
}

/** Insère du texte à la sélection en gardant l'historique « annuler » (Ctrl+Z) quand c'est possible. */
function inserer(zone, texte) {
	let ok = false;
	try {
		ok = document.execCommand('insertText', false, texte);
	} catch {
		ok = false;
	}
	if (!ok) {
		zone.setRangeText(texte, zone.selectionStart, zone.selectionEnd, 'end');
		zone.dispatchEvent(new Event('input', { bubbles: true }));
	}
}

/** Remplace tout le contenu de la zone (annulable avec Ctrl+Z quand le navigateur le permet). */
export function remplacerContenu(zone, texte) {
	zone.focus();
	zone.select();
	if (texte === '') {
		inserer(zone, '');
	} else {
		inserer(zone, texte);
	}
	if (zone.value !== texte) {
		zone.value = texte;
		zone.dispatchEvent(new Event('input', { bubbles: true }));
	}
	zone.setSelectionRange(0, 0);
	zone.scrollTop = 0;
}

/** Place le curseur au début de la ligne n (1 = première ligne) et la sélectionne. */
export function allerALigne(zone, n) {
	const lignes = zone.value.split('\n');
	const index = Math.min(Math.max(n, 1), lignes.length) - 1;
	let debut = 0;
	for (let i = 0; i < index; i++) debut += lignes[i].length + 1;
	zone.focus();
	zone.setSelectionRange(debut, debut + lignes[index].length);
	const hauteurLigne = parseFloat(getComputedStyle(zone).lineHeight) || 20;
	zone.scrollTop = Math.max(0, (index - 2) * hauteurLigne);
}

/**
 * Branche les confort d'une zone de code : numéros de ligne, position du curseur, Tab = 2 espaces,
 * Entrée qui garde l'indentation, Ctrl+Entrée = exécuter.
 * Accessibilité : la touche Échap désactive la capture de Tab jusqu'à la sortie de la zone,
 * pour que la navigation au clavier ne reste jamais « piégée » dans l'éditeur.
 */
export function brancherEditeur(zone, { gouttiere, position, surExecuter, surChangement } = {}) {
	let captureTab = true;

	const majGouttiere = () => {
		if (!gouttiere) return;
		const n = zone.value.split('\n').length;
		if (gouttiere.dataset.n !== String(n)) {
			gouttiere.dataset.n = String(n);
			gouttiere.textContent = Array.from({ length: n }, (_, i) => i + 1).join('\n');
		}
		gouttiere.style.paddingBottom = `${zone.offsetHeight - zone.clientHeight + 10}px`;
		gouttiere.scrollTop = zone.scrollTop;
	};
	const majPosition = () => {
		if (!position) return;
		const avant = zone.value.slice(0, zone.selectionStart);
		const ligne = avant.split('\n').length;
		const colonne = avant.length - avant.lastIndexOf('\n');
		position.textContent = `Ligne ${ligne}, colonne ${colonne}`;
	};

	zone.addEventListener('input', () => {
		majGouttiere();
		majPosition();
		if (surChangement) surChangement();
	});
	zone.addEventListener('scroll', () => {
		if (gouttiere) gouttiere.scrollTop = zone.scrollTop;
	});
	for (const evt of ['keyup', 'click', 'focus', 'select']) zone.addEventListener(evt, majPosition);
	zone.addEventListener('blur', () => {
		captureTab = true;
	});
	if (typeof ResizeObserver === 'function') new ResizeObserver(majGouttiere).observe(zone);

	zone.addEventListener('keydown', (e) => {
		if (e.isComposing) return;
		if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
			e.preventDefault();
			if (surExecuter) surExecuter();
			return;
		}
		if (e.key === 'Escape') {
			captureTab = false;
			return;
		}
		if (e.key === 'Tab' && captureTab && !e.ctrlKey && !e.altKey && !e.metaKey) {
			e.preventDefault();
			const debut = zone.selectionStart;
			const fin = zone.selectionEnd;
			const texte = zone.value;
			const multiLigne = texte.slice(debut, fin).includes('\n');
			if (!multiLigne && !e.shiftKey) {
				inserer(zone, '  ');
				return;
			}
			// Indenter ou désindenter toutes les lignes touchées par la sélection.
			const debutLigne = texte.lastIndexOf('\n', debut - 1) + 1;
			let finLigne = texte.indexOf('\n', fin);
			if (finLigne === -1) finLigne = texte.length;
			const bloc = texte.slice(debutLigne, finLigne);
			const nouveau = bloc
				.split('\n')
				.map((l) => (e.shiftKey ? l.replace(/^ {1,2}/, '') : '  ' + l))
				.join('\n');
			zone.setSelectionRange(debutLigne, finLigne);
			inserer(zone, nouveau);
			zone.setSelectionRange(debutLigne, debutLigne + nouveau.length);
			return;
		}
		if (e.key === 'Enter' && !e.shiftKey && !e.altKey) {
			const avant = zone.value.slice(0, zone.selectionStart);
			const ligne = avant.slice(avant.lastIndexOf('\n') + 1);
			const indentation = ligne.match(/^[ \t]*/)[0];
			if (indentation) {
				e.preventDefault();
				inserer(zone, '\n' + indentation);
			}
		}
	});

	majGouttiere();
	majPosition();
	return { majGouttiere, majPosition };
}

/** Petit message d'état (copié, réinitialisé…) annoncé aux lecteurs d'écran. */
export function annoncer(element, texte, dureeMs = 4000) {
	if (!element) return;
	element.textContent = texte;
	clearTimeout(element._labo);
	if (dureeMs) element._labo = setTimeout(() => (element.textContent = ''), dureeMs);
}

/** Découpe les « entrées clavier simulées » : une par ligne, sans la ligne vide finale (comme le testeur du dépôt). */
export function decouperEntrees(texte) {
	if (texte === '') return [];
	const lignes = texte.replace(/\r\n/g, '\n').split('\n');
	if (lignes[lignes.length - 1] === '') lignes.pop();
	return lignes;
}

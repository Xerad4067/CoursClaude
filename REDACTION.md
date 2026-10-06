# REDACTION.md : guide pour écrire un module du cours

Ce guide s'adresse à toute personne ou tout agent qui écrit une page du cours (module, bilan, salle d'entraînement).
Il complète `CLAUDE.md` (règles du projet) et `PROMPT.md` (cahier des charges, qui fait foi).
Modèle à imiter : `src/content/docs/parcours-b/b6-tables.mdx` et `b4-boucles.mdx`.

## 1. Règles non négociables

1. **N'invente jamais** une commande, une fonction, une option, un identifiant de paquet, un lien ou une vidéo.
   Chaque fait technique vient d'une source lue (doc officielle ou son dépôt source sur GitHub) ou d'un test exécuté.
2. **Aucun secret, jeton, mot de passe ou donnée personnelle.** Personnage d'exemple : « Sam », « Kim », « Alex ».
   Adresses de démonstration : `sam@example.invalid` ou `…@exemple.fr`. Jamais d'adresse e-mail réelle.
3. Ce qui n'a pas pu être exécuté se dit : « non testé sur Windows », « non testé dans le jeu », « non vérifié ».
4. Tutoiement, ton chaleureux et direct, français. Termes techniques anglais gardés avec leur traduction à la première occurrence.
5. **Une notion à la fois** : définition simple, analogie, exemple court commenté, explication ligne par ligne, puis pratique.
   Jamais plus de quelques paragraphes sans que l'apprenant pratique. Aucune notion utilisée avant d'être expliquée.
6. Exemples sur le thème **roleplay / jeu** (métiers, argent, véhicules, magasin, maison, parc, grotte).
7. Ne propose **jamais** d'installer Unreal ni de lancer le client du jeu sur le portable. Les parcours A à D n'ont besoin d'aucun accès à Nanos World.

## 2. Où mettre les fichiers

| Quoi | Où |
|---|---|
| Page d'un module | `src/content/docs/parcours-x/xN-sujet.mdx` (minuscules, tirets) |
| Exercices testés | `exercices/<MODULE>/exNN/` (par exemple `exercices/C2/ex03/`) |
| Données SQL communes | `exercices/_donnees/<nom>.sql` |
| Notes de recherche, sources, glossaire proposé | `recherche/` (jamais dans `SOURCES.md`, `PLAN.md`, `ETAT_AVANCEMENT_COURS.md`, `CLAUDE.md` : le coordinateur les fusionne) |

**Ne modifie pas** les fichiers partagés : `astro.config.mjs`, `theme.css`, `progression.js`, `Accueil.astro`, `SOURCES.md`, `PLAN.md`, `ETAT_AVANCEMENT_COURS.md`, `CLAUDE.md`, les pages `outils/`. Si tu as besoin d'un changement, écris-le dans ta réponse finale.
**Ne lance pas `npm run build`** (plusieurs agents travaillent en même temps) et **n'utilise pas git** : le coordinateur construit et commite.

## 3. En-tête d'une page de module (frontmatter)

```yaml
---
title: "C2 · Déboguer méthodiquement"     # code + titre
description: Une phrase qui dit ce que le module apporte.
parcours: C                              # A à H, ou X pour la salle d'entraînement
module: C2                               # code unique, lettres + chiffres : C2, D7, X3, XP2
duree: 3 h                               # durée réaliste pour un débutant qui se distrait vite
ou: les-deux                             # portable | pc | les-deux
prerequis: Module C1 et le parcours B jusqu'à B5.
resultat: Une phrase : ce que tu auras de visible à la fin.
objectifs:                               # 3 à 5 objectifs mesurables (verbes d'action)
  - Reproduire un bug avant de le corriger
sidebar:
  order: 2                               # position dans le parcours
---
```

Puis les imports (copie ceux de `b6-tables.mdx`, ajoute `Rappel` à partir du parcours C) :

```mdx
import Encadre from '../../../components/Encadre.astro';
import FinEtape from '../../../components/FinEtape.astro';
import TroisDurees from '../../../components/TroisDurees.astro';
import Exercice from '../../../components/Exercice.astro';
import Quiz from '../../../components/Quiz.astro';
import Videos from '../../../components/Videos.astro';
import Rappel from '../../../components/Rappel.astro';
```

## 4. Structure d'un module (dans cet ordre)

1. `<TroisDurees quinze="…" quarante="…" deuxh="…" />` : trois durées (15 min / 45 min / 2 h).
2. **Rappel** (à partir du parcours C, obligatoire) : `<Rappel questions={[{ q: "…", r: "…", de: "B5" }, … ]} />`, **3 à 5 questions** sur des modules **antérieurs** (révision espacée).
3. Une ligne `**Pourquoi c'est utile ?** …` : lien concret avec un serveur roleplay, une map ou le BTS SIO SLAM.
4. **3 à 5 étapes** `## Étape N · Titre (20 min)` de 15 à 25 minutes chacune. Chaque étape finit par `<FinEtape id="C2-e1" titre="…" victoire="…" prochaine="…" />` :
   mini-victoire **visible** (une commande affiche le bon résultat, un test passe…) et « prochaine action » **précise** pour la reprise du lendemain.
   Dans les attributs : **pas de `>`**, pas de guillemets droits `"` à l'intérieur (utilise « » ).
5. `## Erreurs fréquentes` : tableau symptôme / cause / solution, avec les **vrais messages d'erreur** (copiés d'une exécution réelle).
6. `## Exercices` : **8 à 15 exercices** (🟢 échauffement, 🟡 application, 🔴 défi) en difficulté **croissante**, dont **au moins** un `type="debug"`, un `type="lecture"` et un `type="projet"` (mini-projet qui nourrit le projet fil rouge).
7. `## Quiz du module Xn` : `<Quiz id="C2-quiz" questions={[…10 questions…]} />`.
8. `## Récapitulatif` : une page : 5 à 10 puces.
9. `## Je suis bloqué, que faire ?` : relire l'erreur, isoler, chercher dans la doc, demander à une IA (prompt modèle qui demande des **indices**), demander sur Discord.
10. `<Videos recherche="mots-clés français" liste={[]} />` : **uniquement un lien de recherche** tant qu'aucune vidéo n'est vérifiée (voir SOURCES.md). N'invente jamais d'identifiant de vidéo.
11. `## Pour aller plus loin` : **2 à 4 liens externes vérifiés** (voir §8).

Encadrés : `<Encadre type="retenir|piege|astuce|bloque|analogie">…</Encadre>` (titre optionnel `titre="…"`). Utilise-en à peu près un par étape.

## 5. Les exercices

```mdx
<Exercice id="C2-ex03" titre="La boutique qui oublie" niveau="jaune" type="debug" dossier="C2/ex03" fichier="boutique.lua">
Énoncé en 2 à 6 lignes, résultat attendu décrit en mots.

<div slot="indice1">Un petit coup de pouce (où regarder).</div>
<div slot="indice2">La piste (quelle notion).</div>
<div slot="indice3">Presque la solution (sans l'écrire en entier).</div>
<div slot="solution">Explication de la solution : pourquoi ça marche, erreur classique à retenir.</div>
</Exercice>
```

- `niveau` : `vert`, `jaune` ou `rouge`. `type` (facultatif) : `debug`, `lecture`, `projet`. Un `projet` ajoute `<div slot="validation">critères de validation</div>`.
- **Identifiants** : exercice `C2-ex03`, étape `C2-e1`, quiz `C2-quiz`, uniques dans tout le site.
- Le composant affiche, depuis `exercices/<dossier>/` :
  - `solution.<ext>` : la solution (repliée, avec ton explication `slot="solution"` en dessous) ;
  - `attendu.txt` : le résultat attendu, **exactement ce que le programme affiche** (le test compare au caractère près, hors espaces finaux) ;
  - `casse.<ext>` : le code à réparer (obligatoire pour `type="debug"`, et il **doit** ne pas donner le bon résultat : le testeur le vérifie) ;
  - `depart.<ext>` : un code de départ à compléter (facultatif) ;
  - pour `type="lecture"` : la solution est le code **à lire** (affiché dans l'énoncé) et `attendu.txt` est révélé dans la solution.
- Les **commentaires du code sont en français** (le code est affiché à l'apprenant).
- **Déterminisme** : pas d'heure, pas de hasard non contrôlé, pas d'ordre de `pairs`/`dict` dépendant de l'implémentation.
- Chaque exercice teste **une seule idée** ; un 🔴 combine deux ou trois idées déjà vues. L'énoncé donne le **résultat attendu** avant le code.
- Le site ne code pas la réponse en dur : « code montré = code testé ».

### Fichiers de test par langage

| Langage | Fichiers | Testeur | Particularités |
|---|---|---|---|
| **Lua 5.4** | `solution.lua`, `attendu.txt`, `casse.lua`, `config.lua` | `lua exercices/tester.lua [MODULE]` | `config.lua` : `return { entrees = {"Sam","12"}, aleatoire = {7, 3} }` (réponses clavier simulées pour `io.read`, valeurs imposées pour `math.random`). `require("nom")` charge `nom.lua` du même dossier. `prelude = "nanos"` charge le simulateur Nanos World (parcours E). |
| **Python 3** | `solution.py`, `attendu.txt`, `casse.py`, `entrees.txt` | `python exercices/tester_autres.py [MODULE]` | `entrees.txt` : une ligne par `input()` (le texte « tapé » est affiché comme dans un vrai terminal). Un module voisin se charge avec `import nom` (même dossier). |
| **JavaScript** (Node.js) | `solution.js`, `attendu.txt`, `casse.js` | idem | Affichage avec `console.log`. |
| **SQL** (SQLite) | `solution.sql`, `attendu.txt`, `config.json` = `{"base": "boutique"}` | idem | La base `exercices/_donnees/boutique.sql` est chargée avant la solution. Chaque `SELECT` s'affiche : une ligne d'en-têtes puis les lignes, séparées par ` \| `, puis une ligne vide ; `INSERT/UPDATE/DELETE` affichent `N ligne(s) modifiée(s)`. Mets un `ORDER BY` sur toute requête dont l'ordre compte. |
| **Git** | `solution.sh`, `attendu.txt` | idem | Script bash exécuté dans un dossier vide avec une identité de test ; la sortie doit être indépendante des identifiants de commit (utilise `--format=%s`, `--oneline` interdit car il contient un hash). Dans le cours, explique que les fichiers se créent avec VS Code et que les commandes `git` sont les mêmes dans PowerShell ; le script bash est la « vérification » de l'auteur. |
| **TOML** (Package.toml, Config.toml, Assets.toml…) | `solution.toml`, `attendu.txt` (= le contenu lu, en JSON trié ; on le génère avec `python -c "import tomllib,json;print(json.dumps(tomllib.load(open('solution.toml','rb')),indent=2,sort_keys=True,ensure_ascii=False))"`), `casse.toml` | `python exercices/tester_autres.py [MODULE]` | Ne prouve QUE la syntaxe TOML et la présence des clés attendues : jamais que le jeu accepte le fichier. Dis-le dans l'exercice (« vérifié comme TOML valide, non testé dans le jeu »). |
| **HTML/CSS/JS** | `solution.html`, `attendu.txt`, `casse.html`, `config.json` (`{"clics":["#bouton"],"saisies":{"#nom":"Sam"}}`) | `node exercices/tester_navigateur.mjs [MODULE]` | Compare le **texte visible** de la page (Chromium). Un seul fichier HTML autonome (CSS et JS inclus). |

Lance **tes** testeurs à la fin et colle leur sortie dans ta réponse. Un exercice sans test réussi n'est pas livré.
Les exercices qui ne peuvent pas être testés automatiquement (mapping dans Unreal, installation sous Windows) n'ont pas de `dossier` ; leur solution est une **liste de vérifications observables** (« tu dois voir… ») et la page dit clairement « non testé en conditions réelles ».

## 6. Le quiz (10 questions exactement)

```mdx
<Quiz id="C2-quiz" questions={[
  { q: "Question avec `code` ?", choix: ["Réponse A", "Réponse B", "Réponse C", "Réponse D"], ok: 1, pourquoi: "Explication courte de la bonne réponse." },
  …
]} />
```
- `ok` = index de la bonne réponse (0 = première). **Varie** la position de la bonne réponse.
- 3 ou 4 choix plausibles (pas de réponse absurde). Une vraie erreur courante parmi les mauvais choix.
- Dans `q`, `choix`, `pourquoi` : seulement `` `code` ``, `**gras**`, et `\"` pour un guillemet droit ; pas de `<` ni `>` bruts.

## 7. Pièges MDX (la page ne compile pas sinon)

- **Jamais** `{` `}` `<` `>` bruts dans le texte courant : mets-les dans des backticks (`` `{ }` ``), un bloc de code, ou écris `&lt;`.
- Une ligne qui commence par `<` est vue comme une balise : évite « <nombre> » dans le texte.
- Dans `<div slot="…">`, écris du texte et du Markdown inline sur une ou plusieurs lignes ; pour un bloc de code dans un slot, laisse une **ligne vide** avant et après les triple backticks.
- Blocs de code : ` ```lua title="c2/boutique.lua" ` ; terminal : ` ```text ` pour une sortie, ` ```powershell ` pour des commandes (ajoute « non testée sur Windows » si c'est le cas). Langages possibles : `lua`, `python`, `sql`, `html`, `css`, `js`, `bash`, `powershell`, `text`, `toml`, `json`.
- Liens internes **absolus sans la base** : `[B6](/parcours-b/b6-tables/)` (un plugin ajoute `/CoursClaude`). Vérifie que la page cible existe.
- Pas de tableau avec `|` dans une cellule : écris `&#124;`.

**Vérification rapide (obligatoire avant de rendre ton travail)** :

```text
node scripts/verifier-mdx.mjs parcours-c        # syntaxe MDX de tes pages
node scripts/verifier-modules.mjs parcours-c    # structure : exercices, indices, quiz, sections, liens, texte interdit
lua exercices/tester.lua C2                     # tes exercices Lua
python exercices/tester_autres.py C2            # tes exercices Python / JS / SQL / Git
node exercices/tester_navigateur.mjs D8         # tes pages HTML/JS
```

## 8. Sources et liens externes

- Les sites de documentation (docs.python.org, developer.mozilla.org, git-scm.com, docs.github.com, sqlite.org, lua.org, docs.nanos-world.com…) sont **bloqués** depuis le conteneur. Pour vérifier une page, lis son **dépôt source sur GitHub** avec `curl https://raw.githubusercontent.com/<dépôt>/<branche>/<chemin>` (ex. `python/cpython` dossier `Doc/`, `mdn/content` et `mdn/translated-content` pour MDN, `git/git` dossier `Documentation/`, `progit/progit2-fr` pour Pro Git en français, `github/docs`). Le dépôt `nanos-world/docs` est cloné dans `/home/user/nanos-world/docs`.
- Un lien « Pour aller plus loin » doit pointer vers une page **dont tu as vu la source** (le chemin existe dans le dépôt qui génère le site) ou figurer déjà dans `SOURCES.md`. En cas de doute, **ne mets pas le lien**.
- Note chaque nouvelle source dans `recherche/sources-<ton-nom>.md` : URL, dépôt/chemin lu, ce que ça a permis de vérifier, date (06/10/2026), « non testé sur Windows » si besoin. Le coordinateur les fusionne dans `SOURCES.md`.
- Propose les nouveaux termes de glossaire dans `recherche/glossaire-<ton-nom>.md` (terme, définition en une phrase, module).
- Commandes Windows (`winget`, PowerShell) : uniquement celles déjà vérifiées dans `INSTALLATION.md`/`SOURCES.md`, ou vérifiées par toi dans le dépôt officiel des manifestes (`microsoft/winget-pkgs`). Python : `winget install -e --id Python.Python.3.13` (voir `recherche/sources-python-winget.md`).

## 9. Qualité attendue

- Durées **réalistes** pour un débutant qui se distrait vite (compte large).
- Difficulté **strictement croissante** dans un module comme entre modules ; rien d'utilisé avant d'être expliqué.
- Les messages d'erreur cités sont **réels** (exécute le code cassé et copie la sortie).
- Termes homogènes avec `src/content/docs/outils/glossaire.mdx` (lis-le avant d'écrire).
- Pas de remplissage, pas de « à compléter », pas de copie de longs passages de la doc officielle : reformule en français et renvoie vers la source.
- Chaque module reste **autonome** : un lien vers le module précédent pour les prérequis, jamais de dépendance cachée.

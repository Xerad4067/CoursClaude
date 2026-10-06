# CLAUDE.md : contexte du projet « Cours Claude »

Ce fichier est lu au début de chaque session Claude Code. Il résume le projet, les règles et les commandes.
Le cahier des charges complet est `PROMPT.md` : **il fait foi**. L'état du travail est dans `ETAT_AVANCEMENT_COURS.md`.

## Le projet
Un site de cours statique (Astro + Starlight, thème sombre, Roboto auto-hébergée) publié sur GitHub Pages,
qui apprend à un débutant complet à devenir autonome : installation de l'environnement, Lua, scripts Nanos World,
petites maps (Unreal Engine 5.7), Git/GitHub, bases SLAM (POO, SQL, HTML/CSS/JS).

## L'apprenant (rappel)
- Débutant complet, francophone, étudiant en BTS SIO, choix de l'option SLAM vers janvier 2027.
- Se distrait vite, disponibilité de 15 min à 2 h : étapes courtes, mini-victoires, « prochaine action ».
- Veut **comprendre** : d'abord des indices, jamais la solution d'emblée. Tutoiement, ton chaleureux et direct.
- Deux machines Windows : **portable HP** (code, léger, GPU intégré : jamais d'Unreal ni de client du jeu) et **PC fixe** (jeu, Unreal, Blender, 16 Go de RAM).
- Accès à Nanos World **en attente** : les parcours A à D ne doivent jamais en dépendre.

## Commandes
| Action | Commande |
|---|---|
| Installer les dépendances | `npm install` |
| Site en local (rechargement auto) | `npm run dev` → http://localhost:4321/CoursClaude/ |
| Construire le site (obligatoire avant de livrer) | `npm run build` |
| Voir le site construit (avec la recherche) | `npm run preview` |
| Tester toutes les solutions Lua | `lua exercices/tester.lua` (dans le conteneur Linux : `lua5.4 exercices/tester.lua`) |
| Tester un seul module | `lua exercices/tester.lua B3` |

Le build doit se terminer avec le code 0 et le testeur Lua avec « échecs : 0 » avant tout commit de contenu.

## Organisation
- `src/content/docs/` : pages (MDX). Dossiers : `installer/`, `parcours-a/`, `parcours-b/`, `outils/`, `moi/`.
- Une page par module : `parcours-x/xN-sujet.mdx`, frontmatter `parcours`, `module`, `duree`, `ou` (`portable` | `pc` | `les-deux`), `prerequis`, `resultat`, `objectifs`, `sidebar.order`.
- `src/components/` : `Exercice`, `Quiz`, `FinEtape`, `Encadre`, `TroisDurees`, `Videos`, `Checklist`, `Accueil`, `Reussites`, `Journal`, `OutilsProgression`.
- `src/scripts/progression.js` : progression dans le navigateur (localStorage), XP, niveaux, badges, export/import.
- `src/lib/manifeste.js` : liste les `FinEtape`, `Exercice` et `Quiz` de chaque page (attributs entre guillemets, sans `>` dans les valeurs).
- `exercices/<MODULE>/exNN/` : `solution.lua` + `attendu.txt` (+ `casse.lua` pour le débogage, `depart.lua`, `config.lua` pour les entrées clavier et nombres aléatoires simulés). Le composant `Exercice` affiche ces fichiers : le code montré est exactement le code testé.
- `INSTALLATION.md` et `OUTILS-RECOMMANDES.md` sont importés tels quels dans les pages `installer/tutoriel` et `installer/outils`.

## Conventions de contenu
- Français, tutoiement ; termes techniques anglais gardés avec leur traduction à la première occurrence.
- Une notion à la fois : définition simple, analogie, exemple court commenté, explication ligne par ligne.
- Chaque étape (15-20 min) finit par `<FinEtape id titre victoire prochaine />`.
- Chaque module : `<TroisDurees>`, encadrés (`<Encadre type="retenir|piege|astuce|bloque|analogie">`), 8 à 15 exercices 🟢🟡🔴 avec 3 indices (`<div slot="indice1">`…) et solution, au moins un exercice `type="debug"` et un `type="lecture"`, un mini-projet `type="projet"`, un `<Quiz>` de 10 questions, un récapitulatif, « Je suis bloqué », vidéos de secours, « Pour aller plus loin ».
- Identifiants uniques : étapes `B3-e1`, exercices `B3-ex01`, quiz `B3-quiz`.
- Exemples sur le thème roleplay (métiers, argent, véhicules, magasin, maison, parc, grotte).
- Liens internes en absolu sans la base (`/parcours-b/b1-variables-types/`) : un plugin ajoute `/CoursClaude`.

## Règles d'honnêteté et de sécurité (non négociables)
- **N'invente jamais** une commande, une fonction, un identifiant de paquet, un lien ou une vidéo. Vérifie dans la doc officielle (ou son dépôt source sur GitHub si le site est bloqué) et ajoute la source dans `SOURCES.md` avec la date.
- Marque « non testé sur Windows » / « non testé en conditions réelles » ce qui n'a pas pu être exécuté.
- Aucun secret, jeton, mot de passe ou donnée personnelle dans le dépôt ou le site.
- Ne jamais pousser sur `main` sans accord. Commits réguliers avec des messages clairs (ils servent d'exemple).
- Demander avant : installer un logiciel, supprimer des fichiers, `git push`, modifier quoi que ce soit hors du dossier.
- Tutorat : donner des indices et poser des questions avant de donner une solution.

## Reprendre une session
1. Lire `ETAT_AVANCEMENT_COURS.md` (section « Comment reprendre »).
2. `npm install`, puis `npm run build` et `lua exercices/tester.lua` pour vérifier que tout est vert.
3. Continuer la vague en cours (voir `PLAN.md`, section 7).

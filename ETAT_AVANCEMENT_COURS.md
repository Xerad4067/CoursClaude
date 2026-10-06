# État d'avancement du cours

> Dernière mise à jour : **6 octobre 2026**, fin de la **Vague 1**.
> Ce fichier dit ce qui est fait, ce qui reste à faire, ce qui **n'a pas pu être testé**, les décisions qui t'attendent, et comment reprendre.

## 1. Résumé

| Étape | État |
|---|---|
| Phase 0 : recherche, `PLAN.md`, `OUTILS-RECOMMANDES.md`, `INSTALLATION.md`, `SOURCES.md` | ✅ Terminée |
| Vague 1 : tutoriels d'installation (portable + PC fixe), `CLAUDE.md`, site complet, parcours A et B | ✅ Terminée |
| Vague 2 : parcours C et D (+ mini-labos navigateur) | ⏳ À faire |
| Vague 3 : parcours E (scripts Nanos World) et F (mapping) | ⏳ À faire |
| Vague 4 : parcours G et H, vérification globale | ⏳ À faire |
| Phase finale : résumé de démarrage | ⏳ À faire (l'essentiel est déjà dans `README.md`) |

Tout le travail est sur la branche `claude/epic-turing-ip1xx5` (rien n'a été poussé sur `main`).

## 2. Ce qui est fait (Vague 1)

### Documents
- `PLAN.md` : constats de recherche, choix d'Astro Starlight justifié, architecture, parcours et durées (≈ 148 h), planning express 12 semaines, écarts avec le cahier des charges.
- `INSTALLATION.md` : 18 sections, portable et PC fixe (Terminal, winget, VS Code, Git, identité noreply, connexion GitHub par navigateur, extensions, Lua 5.4, Node.js 24, dépôt et synchronisation, site du cours, Claude Code, Steam/Nanos World, serveur dédié, Unreal 5.7 avec 16 Go, Blender, Discord), avec vérifications, erreurs fréquentes et désinstallation.
- `OUTILS-RECOMMANDES.md`, `SOURCES.md` (sources + date + méthode d'accès + vidéos non visionnées), `CLAUDE.md`, `README.md`.
- `.vscode/settings.json` + `.vscode/extensions.json`, `.claude/settings.json` (permissions raisonnables), `.gitignore`, workflow `.github/workflows/deploy.yml`.

### Site (Astro 7.3.5 + Starlight 0.42.5)
- Thème **sombre par défaut**, **Roboto / Roboto Mono auto-hébergées** (aucun CDN), accents par parcours, focus clavier visible.
- **Mode concentration**, **minuteur** 15/25/45 min, **taille du texte** réglable (barre d'outils en bas à droite).
- Recherche intégrée hors ligne (Pagefind), blocs de code avec **nom de fichier**, bouton **Copier** et **cadre terminal**.
- Composants : `Exercice` (3 indices progressifs, solution repliable **importée du fichier testé**), `Quiz` (correction expliquée, meilleur score gardé), `FinEtape` (mini-victoire + prochaine action + case), `Encadre`, `TroisDurees`, `Videos` (chargement au clic via youtube-nocookie + lien direct + lien de recherche), `Checklist`.
- **Progression locale** : cases par étape/exercice/checklist, % par parcours et par module, XP, niveaux (Novice → Apprenti → Scripteur → Mappeur → Développeur), 10 badges, série de jours **sans culpabilisation**, « Reprendre où j'en suis », « Ta prochaine action », **export / import** (fusion) et rappel d'export.
- Pages : Accueil (tableau de bord), Installer mon environnement (présentation, tutoriel complet, checklist par machine, mon environnement, où travailler), Boîte à outils (glossaire, aide-mémoire Terminal/Lua/Git/Nanos World/Unreal, dépannage, Plan B Nanos World, parcours express, IA tuteur), Ma progression (synchroniser, journal de bord, mes réussites).

### Parcours
- **Parcours A** (≈ 6 h) : A1 à A5 + bilan. 42 exercices (3 indices + solution chacun), 6 quiz de 10 questions, étapes de 15-20 min avec mini-victoire et prochaine action.
- **Parcours B** (≈ 24 h) : B1 à B8 + bilan. 64 exercices Lua (dont 8 de débogage, 8 de lecture de code, 8 mini-projets), 9 quiz de 10 questions.

### Tests réalisés (dans le conteneur Linux)
- `lua5.4 exercices/tester.lua` : **73 exercices testés, 73 réussis, 0 échec**, et les **10 codes « cassés »** des exercices de débogage vérifiés comme réellement cassés (Lua 5.4.6, la même version que le paquet `DEVCOM.Lua` pour Windows).
- `npm run build` : **code de sortie 0** (voir la fin de ce fichier pour le nombre de pages).
- Liens internes du site vérifiés automatiquement après le build (aucun lien interne cassé).
- Messages d'erreur Lua cités dans le cours : produits réellement avec Lua 5.4.6.

## 3. Ce qui n'a PAS pu être testé (honnêteté)

| Élément | Pourquoi | Comment le vérifier |
|---|---|---|
| **Toutes les commandes Windows** (winget, PowerShell, git config, installation de VS Code, Git, Lua, Node.js, Claude Code) | Je travaille dans un conteneur Linux, pas sur tes machines | Suis le parcours A ; signale toute différence dans ton journal ou à Claude avec le message exact |
| Les intitulés des écrans Windows en français (installeur VS Code, Gestionnaire d'identification, fenêtre de connexion GitHub) | Vérifiés en anglais dans les sources, traduction non vue | Compare à l'écran ; les intitulés anglais exacts sont donnés |
| L'ajout de Lua au PATH par le paquet `DEVCOM.Lua` | Le README du paquet ne le documente pas explicitement | `lua -v` après réouverture du terminal ; sinon section 8.4 du tutoriel |
| Le **comportement du site dans un vrai navigateur** (progression, quiz, minuteur, mode concentration, export/import, lecture des vidéos) | Seul le build a été testé, pas l'exécution du JavaScript dans un navigateur | `npm run build` puis `npm run preview`, et essaie chaque fonction ; note les problèmes |
| La **publication sur GitHub Pages** | Le workflow ne se déclenche que sur `main`, et Pages doit être activé par toi | Voir « Décisions » ci-dessous |
| **Nanos World** (client, serveur dédié, extension VS Code, SteamCMD anonyme) | Accès au jeu en attente ; rien installé | Parcours E (Vague 3), dès que ton accès est ouvert |
| **Unreal Engine 5.7**, Windows SDK, raccourcis de l'éditeur, Blender | Rien installé | Parcours F (Vague 3), sur le PC fixe |
| **Vidéos YouTube** | Trouvées par recherche web, jamais visionnées ; YouTube inaccessible depuis le conteneur (durée et chaîne souvent inconnues) | Regarde les premières minutes ; si une vidéo ne convient pas, utilise le lien de recherche proposé |
| Recommandations d'Epic (32 Go de RAM) | Lues dans un résumé de moteur de recherche, page non ouverte | https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-specifications-for-unreal-engine |
| Plan B « LÖVE » | Piste signalée seulement, version de Lua non vérifiée | À vérifier sur love2d.org si tu choisis cette alternative |

## 4. Décisions qui t'attendent

1. **Publier le site** : le dépôt doit être **public** (GitHub Free), puis **Settings → Pages → Source : GitHub Actions**, puis fusionner la branche `claude/epic-turing-ip1xx5` dans `main` (Pull Request). Je n'ai rien poussé sur `main`.
2. **Langage du parcours D** : je propose **Python** pour la lecture comparée avec Lua. Si ton lycée utilise PHP, C# ou Java en SLAM, dis-le avant la Vague 2.
3. **Mini-labos dans le navigateur** (Lua, SQL, HTML/CSS/JS) : reportés à la Vague 2 (optionnels selon ton cahier des charges). Tu exécutes Lua en local en attendant.
4. **Plan B** : si l'accès à Nanos World devient impossible, veux-tu un parcours de remplacement (piste : LÖVE, 2D en Lua) ?

## 5. Reste à faire

- **Vague 2** : parcours C (penser en développeur, débogage méthodique, Git approfondi : branches, merge, conflits, PR, issues, revue, README, licence, simulation d'équipe) et parcours D (référentiel SLAM à vérifier en détail, algorithmique, POO, SQL avec SQLite, HTML/CSS/JS, Lua ↔ Python, UML), révisions espacées en début de module à partir du parcours C, labos navigateur.
- **Vague 3** : parcours E et F, chaque appel d'API vérifié dans la doc officielle Nanos World (dépôt `nanos-world/docs`) et dans la doc d'Unreal 5.7.
- **Vague 4** : parcours G (projet fil rouge) et H, vérification globale (liens externes, numérotation, vocabulaire, difficulté, accessibilité dans un navigateur, build final).
- Améliorations repérées : vidéos francophones précises pour B2 à B8 (pour l'instant, liens de recherche YouTube uniquement, faute de vidéo vérifiée) ; test du site dans un navigateur (Playwright est disponible dans l'environnement cloud).

## 6. Comment reprendre

```powershell
git pull
npm install
npm run build
lua exercices/tester.lua
```
(Dans le conteneur Linux : `lua5.4 exercices/tester.lua`.)

Puis dans Claude Code : « Lis `CLAUDE.md`, `PROMPT.md` et `ETAT_AVANCEMENT_COURS.md`, puis réalise la Vague 2 ». Les conventions (format des modules, des exercices, des identifiants) sont dans `CLAUDE.md`.

## 7. Résultats de la dernière vérification

Vérification finale du 6 octobre 2026, dans le conteneur cloud :

```text
npm run build                 -> code de sortie 0 (33 page(s) built)
lua5.4 exercices/tester.lua   -> code de sortie 0
Version : Lua 5.4
Exercices testés : 73 · réussis : 73 · échecs : 0
Codes « cassés » vérifiés comme vraiment cassés : 10
Liens internes vérifiés : 1265 · cassés : 0
```

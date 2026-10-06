# PLAN du cours : de zéro à l'autonomie (Lua, Nanos World, mapping, Git, bases SLAM)

> Document de référence du projet. Rédigé le **6 octobre 2026** (Phase 0), mis à jour à chaque vague.
> Le cours est un **complément** à ton BTS SIO, pas un remplacement. Rien ici ne garantit un résultat scolaire, un accès à Nanos World ou un emploi.

---

## 1. Ce que j'ai pu détecter (et ce que je n'ai pas pu)

Je tourne dans un **conteneur cloud** (Ubuntu 24.04, 4 cœurs, 15 Go de RAM), **pas sur tes machines**. Conséquences :

- Je n'ai **pas pu inspecter** ton portable HP ni ton PC fixe. Les tutoriels sont écrits pour les deux machines d'après la section 3 de ton cahier des charges et la **documentation officielle**.
- Chaque commande Windows du cours porte la mention **« non testée sur Windows »** : je les ai vérifiées dans les sources officielles, mais je n'ai pas pu les exécuter sur un vrai Windows 11.
- La page **Checklist par machine** du site contient les **commandes de vérification en lecture seule** (`git --version`, `code --version`, `node --version`, `lua -v`, `winget --version`, infos système) à lancer sur chaque machine. Si tu veux que je les interprète, colle-moi leur résultat.
- Ce que j'ai pu tester réellement : **le build du site** et **tous les exercices Lua** (Lua 5.4.6, la même version que le paquet `DEVCOM.Lua` proposé pour Windows).

### Accès web pendant la recherche (honnêteté)
Le proxy du conteneur bloquait plusieurs sites officiels (docs.nanos-world.com, git-scm.com, docs.github.com, lua.org, learn.microsoft.com, docs.astro.build, youtube.com). Je les ai contournés **sans perte de fiabilité** en lisant leurs **sources officielles publiées sur GitHub** (la documentation de Nanos World, de GitHub, de VS Code, de Microsoft et d'Astro est open source) et le dépôt officiel des manifestes `winget`. Le détail est dans `SOURCES.md`.

---

## 2. Résultats de recherche qui changent le cours

| Sujet | Ce que dit la source officielle (vérifié le 06/10/2026) | Conséquence pour toi |
|---|---|---|
| Accès à Nanos World | Le jeu est en **Closed Testing**. Inscription via un formulaire (réponses **en anglais**, réponses générées par IA rejetées). Les membres actifs du Discord sont prioritaires. Des **playtests publics** ont lieu sur Steam sans candidature. Le blog officiel d'août 2026 annonce un **playtest public d'Halloween du 30 octobre au 1er novembre 2026**. | Les parcours A à D n'ont besoin d'aucun accès. Le site contient un **Plan B**. Le playtest d'Halloween est une occasion d'essayer le client sur le PC fixe (dates à reconfirmer sur Discord). |
| Version de Lua | « nanos world runs **Lua 5.4** » | Tout le cours utilise **Lua 5.4**. Lua local sous Windows : paquet `DEVCOM.Lua` (5.4.6). |
| Version d'Unreal | Unreal Engine **5.7.X** (page *Setting Up Unreal Engine*) + Windows SDK requis pour « cooker » les assets. | Le parcours F se fera sur **UE 5.7**, sur le PC fixe uniquement. |
| Serveur dédié | Windows ou Linux, **2 × 1 GHz, 50 Mo de RAM, 30 Mo de disque** (+ assets et packages), ports **7777 TCP/UDP** et **7778 UDP**, Visual C++ Redistributable requis sous Windows. Téléchargeable via **SteamCMD** en connexion anonyme (app id `1936830`). | Ton **portable peut faire tourner le serveur** d'après ces prérequis (non testé). Il ne peut pas lancer le **client** du jeu : pour voir le résultat en jeu, il faut le PC fixe. |
| Extension VS Code | Extension officielle **« nanos world Lua »** (`go-horse-studios.nanos-world`), qui installe aussi **Lua** (`sumneko.lua`). | Recommandée dès le parcours A (utile même sans accès au jeu). |
| Cartes (maps) | Pipeline : niveau Unreal → *cook* via l'**ADK** (Assets Development Kit) → package de type `map`. La page officielle « Creating Custom Maps » est **signalée comme ancienne** (captures UE4). | Le parcours F (Vague 3) croisera la doc Nanos World et la doc d'Unreal 5.7, avec avertissement. |
| Unreal et 16 Go | Epic recommande **32 Go de RAM** pour UE 5.7. | Avertissement et réglages « petite machine » dans le tutoriel PC fixe. |
| GitHub Pages | Disponible pour les **dépôts publics** avec GitHub Free (privés : GitHub Pro ou plus). | Ton dépôt de cours doit être **public** pour être publié gratuitement. Aucune donnée personnelle dans le site. |
| Claude Code | Installation native Windows (`irm https://claude.ai/install.ps1 \| iex`) ou `winget install Anthropic.ClaudeCode`. Nécessite un **abonnement payant** (Pro, Max, Team, Enterprise) ou un compte Console. | Optionnel. Expliqué en fin de parcours A, sans obligation. |

---

## 3. Choix de l'outil de site : Astro Starlight

| Critère | **Astro Starlight** | Docusaurus | VitePress | MkDocs Material |
|---|---|---|---|---|
| Écosystème à installer | Node.js (déjà nécessaire) | Node.js | Node.js | **Python** en plus |
| Recherche intégrée hors ligne | Oui (Pagefind, générée au build) | Plugin tiers | Oui (locale) | Oui |
| Rendu du code | **Expressive Code** : coloration Lua, bouton Copier, **titre de fichier**, **cadre « terminal »** distinct | Prism | Shiki | Pygments |
| Composants interactifs | Composants Astro + MDX, JavaScript minimal | React (plus lourd) | Vue | Limité |
| Thème sombre + polices auto-hébergées | Oui | Oui | Oui | Oui |
| Poids du build | Léger (HTML statique) | Plus lourd (React) | Léger | Léger |
| Maintenance par un débutant | Fichiers Markdown/MDX, une seule config | Plus de concepts | Simple | Simple mais autre langage |

**Choix : Astro 7.3.5 + Starlight 0.42.5.** Raisons : un seul écosystème (Node.js, que tu installes de toute façon), recherche hors ligne, blocs de code avec nom du fichier et cadre terminal (ton cahier des charges le demande explicitement), composants interactifs légers (quiz, indices, progression) sans framework lourd, sortie 100 % statique compatible GitHub Pages et utilisable en local.

Limites assumées :
- La **recherche** ne fonctionne qu'après un build (`npm run build` puis `npm run preview`), pas en mode `npm run dev`.
- Le site construit doit être servi par `npm run preview` (ou GitHub Pages) : ouvrir `dist/index.html` en double-cliquant ne marche pas (chemins absolus).

---

## 4. Architecture du dépôt

```text
CoursClaude/
├── PROMPT.md                    ← ton cahier des charges (fait foi)
├── PLAN.md                      ← ce document
├── INSTALLATION.md              ← tutoriels d'installation complets (portable + PC fixe)
├── OUTILS-RECOMMANDES.md        ← tableau des outils et extensions
├── SOURCES.md                   ← sources, ce qu'elles vérifient, dates
├── CLAUDE.md                    ← contexte pour chaque nouvelle session Claude Code
├── ETAT_AVANCEMENT_COURS.md     ← fait / reste à faire / non testé / comment reprendre
├── README.md                    ← démarrage rapide
├── package.json, astro.config.mjs, tsconfig.json
├── .github/workflows/deploy.yml ← déploiement GitHub Pages
├── .vscode/                     ← settings.json + extensions.json recommandés
├── .claude/settings.json        ← permissions raisonnables pour Claude Code
├── exercices/                   ← solutions Lua testées + tester.lua
│   ├── tester.lua
│   ├── A5/ex01/solution.lua, attendu.txt, (casse.lua), (config.lua)
│   └── B1/ … B8/
└── src/
    ├── content.config.ts        ← schéma des pages (durée, machine, prérequis…)
    ├── content/docs/            ← toutes les pages du cours (Markdown/MDX)
    ├── components/              ← Exercice, Quiz, FinEtape, Video, tableau de bord…
    ├── overrides/               ← personnalisation de Starlight (en-tête de leçon, barre d'outils)
    ├── scripts/progression.js   ← progression stockée dans le navigateur
    └── styles/theme.css         ← thème sombre, Roboto, accents par parcours
```

**Principe anti-divergence** : les solutions affichées sur le site sont **importées directement** des fichiers `exercices/**/solution.lua`, et le « résultat attendu » vient de `attendu.txt`. Ce que tu lis est donc exactement ce qui a été testé.

---

## 5. Parcours, modules et durées (≈ 148 h)

Durées pensées pour un débutant qui se distrait facilement (pauses et relectures comprises).

| Parcours | Durée | Où | Modules | Vague |
|---|---|---|---|---|
| **A. Installer mon environnement et démarrer** | 6 h | 💻 + 🖥️ | A1 Le dev, le jeu en réseau et le terminal · A2 Installer le portable · A3 Installer le PC fixe · A4 Git et GitHub : synchroniser mes deux machines · A5 Premier script Lua, erreurs, recherche et IA tuteur · Bilan A | 1 |
| **B. Lua et logique** | 24 h | 🔀 | B1 Variables et types · B2 Opérateurs et chaînes · B3 Conditions · B4 Boucles · B5 Fonctions et portée · B6 Tables · B7 Tables imbriquées, closures, modules · B8 Métatables, objets, erreurs, chaînes avancées · Bilan B | 1 |
| **C. Penser en développeur + Git approfondi** | 16 h | 🔀 | Décomposer, pseudo-code, débogage méthodique, lire du code, DRY ; Git : branches, merge, conflits, PR, issues, revue, README, licence ; simulation d'équipe | 2 |
| **D. Passerelle SLAM** | 18 h | 🔀 | Algorithmique, POO (classes, encapsulation, héritage, polymorphisme), SQL avec SQLite, HTML/CSS/JS, lecture comparée Lua ↔ Python, UML simple | 2 |
| **E. Scripts Nanos World** | 34 h | 🖥️ (💻 pour écrire) | Serveur local, packages, serveur/client/partagé, événements, classes, timers, entrées, chat ; briques roleplay ; sauvegarde ; sécurité ; WebUI ; architecture | 3 |
| **F. Mapping** | 28 h | 🖥️ | UE 5.7 sur 16 Go, interface, niveaux, matériaux, éclairage, terrain, maisons, parcs, grottes, collisions, optimisation, export et test en jeu | 3 |
| **G. Projet fil rouge** | 16 h | 🖥️ | Mini serveur roleplay sur ta propre petite map | 4 |
| **H. Autonomie et employabilité** | 6 h | 🔀 | Portfolio GitHub, contribuer, travail en équipe, prochaines étapes | 4 |

### Mini-projets du parcours B (ils nourrissent le projet fil rouge)
B1 fiche de personnage · B2 ticket de caisse · B3 contrôle d'achat d'un véhicule · B4 **jeu de devinettes** · B5 **calculateur de salaire** · B6 **mini-inventaire** · B7 annuaire des métiers en modules · B8 **mini boutique en texte**.

### Format de chaque module (rappel)
Objectifs mesurables, durée, prérequis, machine, « pourquoi c'est utile », une notion à la fois (définition, analogie, exemple commenté), « On code ensemble », erreurs fréquentes avec les vrais messages, encadrés (À retenir, Piège à éviter, Astuce de pro, Si tu es bloqué), étapes de 15-20 min avec **mini-victoire** et **prochaine action**, trois durées (15 min / 45 min / 2 h), 8 à 15 exercices (🟢 🟡 🔴) avec **3 indices** et **solution commentée**, un exercice de débogage et un de lecture de code, un mini-projet, un **quiz de 10 questions**, vidéos de secours, « Pour aller plus loin ».

---

## 6. Parcours « Express avant janvier » (12 semaines)

Base indicative : **6 à 7 h par semaine**, en séances de 15 min à 2 h. Priorité **A → B → C → D** (essentiel SLAM). Les parcours E et F attendent ton accès à Nanos World.

| Semaine | Dates (2026) | Contenu | Heures |
|---|---|---|---|
| S1 | 6 → 12 oct. | **Parcours A complet : installation des deux machines**, premier dépôt synchronisé, premier script Lua | 6 h |
| S2 | 13 → 19 oct. | B1 Variables, B2 Opérateurs et chaînes | 6 h |
| S3 | 20 → 26 oct. | B3 Conditions, B4 Boucles | 6 h |
| S4 | 27 oct. → 2 nov. | B5 Fonctions (+ playtest public d'Halloween sur le PC fixe si tu veux, 30/10 → 1/11) | 6 h |
| S5 | 3 → 9 nov. | B6 Tables, B7 Modules | 6,5 h |
| S6 | 10 → 16 nov. | B8 Objets et erreurs, bilan B, début C | 6,5 h |
| S7 | 17 → 23 nov. | C : penser en développeur, débogage, Git (branches, conflits) | 6,5 h |
| S8 | 24 → 30 nov. | C : PR, issues, revue, simulation d'équipe ; bilan C | 6,5 h |
| S9 | 1 → 7 déc. | D : algorithmique et POO | 6,5 h |
| S10 | 8 → 14 déc. | D : SQL (SQLite), HTML/CSS/JS | 6,5 h |
| S11 | 15 → 21 déc. | D : Lua ↔ Python, UML, bilan D ; révisions espacées | 5 h |
| S12 | 22 → 28 déc. | Marge (fêtes, retard), révisions, projet passerelle ; E/F si accès ouvert | 3-5 h |

### Jalons par quinzaine (un résultat visible à chaque fois)
- **Jalon 1 (19 oct.)** : deux machines prêtes, dépôt GitHub synchronisé, fiche de personnage et ticket de caisse en Lua.
- **Jalon 2 (2 nov.)** : jeu de devinettes jouable dans le terminal, calculateur de salaire.
- **Jalon 3 (16 nov.)** : mini-inventaire, annuaire en modules, mini boutique en texte (parcours B terminé).
- **Jalon 4 (30 nov.)** : une Pull Request relue et fusionnée, un conflit résolu, un README propre.
- **Jalon 5 (14 déc.)** : une petite application « boutique » avec classes, une base SQLite et une page web.
- **Jalon 6 (28 déc.)** : bilan SLAM : tu sais expliquer variables, fonctions, POO, SQL, Git, avec tes propres projets sur GitHub.

### Rythme minimal (semaines chargées)
**3 séances de 30 min par semaine** (≈ 1 h 30). Dans ce cas, ordre de priorité : A en entier → B1 à B6 → la partie Git du parcours C → POO et SQL du parcours D. Ce qui saute : B8, UML, mini-labos. Une semaine à 0 h ne casse rien : le site ne « punit » pas les pauses.

### Quand ton accès Nanos World s'ouvre
Entrelace E et F : **deux séances de scripts (E) pour une séance de mapping (F)**, sans abandonner C/D avant janvier (règle : au moins 50 % du temps sur A-D jusqu'au 1er janvier).

---

## 7. Méthode de production (vagues) et état

| Vague | Contenu | État |
|---|---|---|
| Phase 0 | Recherche, PLAN, OUTILS-RECOMMANDES, INSTALLATION (version de départ), SOURCES | ✅ Terminée |
| Vague 1 | Tutoriels d'installation complets, CLAUDE.md, site complet (thème, composants, progression, déploiement), parcours A et B | Voir `ETAT_AVANCEMENT_COURS.md` |
| Vague 2 | Parcours C et D (+ labos SQL et HTML/CSS/JS, labo Lua) | À venir |
| Vague 3 | Parcours E et F | À venir |
| Vague 4 | Parcours G et H, vérification globale | À venir |

---

## 8. Écarts avec le cahier des charges, et pourquoi

1. **Détection de machine** : impossible en mode cloud. Remplacée par des commandes de vérification à lancer toi-même (page Checklist).
2. **Commandes Windows non exécutées** : vérifiées dans les sources officielles, marquées « non testée sur Windows ».
3. **Sites officiels bloqués par le proxy du conteneur** : vérification faite via leurs dépôts sources officiels sur GitHub (même contenu). Aucun lien n'a été inventé.
4. **Vidéos YouTube** : trouvées par recherche web (titre exact + URL), **jamais visionnées**. Je n'ai pas pu ouvrir YouTube pour vérifier la chaîne ou la durée : quand elles ne figuraient pas dans le résultat de recherche, je l'indique.
5. **Mini-labos dans le navigateur** : optionnels selon ton cahier des charges. Ils sont reportés à la **Vague 2** (labo Lua, labo SQL, labo HTML/CSS/JS) pour livrer d'abord un socle fiable. En attendant, tu exécutes Lua en local (installé au parcours A).
6. **Site à la racine du dépôt** (pas dans un sous-dossier) : une seule commande `npm install` puis `npm run dev`, et le déploiement GitHub Actions fonctionne sans configuration de chemin.
7. **Langage de comparaison du parcours D** : **Python** (léger à installer, très répandu pour l'algorithmique en BTS SIO, syntaxe proche de Lua). Le référentiel SLAM n'impose pas de langage ; si ton établissement utilise PHP, C# ou Java en SLAM, je l'adapterai (décision notée dans `ETAT_AVANCEMENT_COURS.md`).
8. **Nom d'utilisateur et dépôt GitHub** : détectés depuis le dépôt (`Xerad4067/CoursClaude`). Le site est configuré pour `https://xerad4067.github.io/CoursClaude/`. Un seul endroit à changer si tu renommes (`astro.config.mjs`).
9. **Niveau « Mappeur »** : il arrive après « Scripteur » comme tu l'as demandé, même si le mapping (F) est en parallèle de E ; les seuils d'XP sont réglés pour que chaque niveau corresponde à une vraie étape.

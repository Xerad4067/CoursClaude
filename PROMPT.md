MODE CLOUD AUTONOME : tu tournes dans un conteneur cloud, pas sur mes machines.
- Ignore la détection de machine : décris les deux machines d'après la section 3.
- N'installe rien et ne demande aucune confirmation : écris les tutoriels d'après la doc officielle
  et marque chaque commande comme "non testée sur Windows".
- Travaille sur une branche, ne pousse jamais sur main.
- Si une décision m'est nécessaire, note-la dans ETAT_AVANCEMENT_COURS.md et continue avec le reste.


# 0. COMMENT LIRE CE PROMPT

Ce prompt est long volontairement : il contient tout ce que tu dois savoir sur moi, mon matériel, mes objectifs et ma façon d'apprendre. Lis-le en entier avant d'agir. En cas de conflit entre deux consignes, l'ordre de priorité est : (1) honnêteté et sécurité, (2) autonomie réelle et pédagogie, (3) mon calendrier, (4) le reste.

---

# 1. OBJECTIF (GOAL)

Construis, dans ce dossier, un **site web de cours** (thème sombre, police Roboto, hébergé sur GitHub Pages, utilisable aussi en local) qui m'apprend, depuis zéro, à devenir **autonome** pour :

1. **installer et configurer mon environnement de développement** sur mes deux ordinateurs (tutoriels pas à pas) ;
2. programmer en **Lua** et penser comme un développeur ;
3. écrire des **scripts pour Nanos World** (plateforme multijoueur sandbox sur Unreal Engine) jusqu'à un mini serveur roleplay ;
4. créer de **petites maps** (maisons, petits parcs, grottes) pour Nanos World, avec une base solide pour approfondir plus tard ;
5. utiliser **Git et GitHub** comme dans une vraie équipe (et pour synchroniser mes deux machines) ;
6. acquérir des **bases transférables** (POO, SQL, HTML/CSS/JS, autre langage) utiles pour mon **BTS SIO option SLAM**.

Le cours représente **plus de 100 heures** (cible : environ 140 à 150 h), dans un format qui me garde motivé, me montre ma progression et m'évite de rester bloqué. Je ne vise pas de gros projets maintenant : je vise l'**autonomie sur de petits projets complets**.

Tu ne t'arrêtes pas tant que les « CRITÈRES DE RÉUSSITE » (section 14) ne sont pas remplis.

---

# 2. QUI JE SUIS

- **Débutant complet** en programmation. Francophone. Anglais : je comprends l'essentiel avec un traducteur. Donc cours, explications et commentaires de code **en français** ; termes techniques officiels gardés en anglais avec leur traduction à la première occurrence.
- Étudiant en **BTS SIO**. Je veux choisir l'option **SLAM** (développement) vers **janvier 2027**. Nous sommes le **6 octobre 2026** : il me reste environ **12 semaines**. Je dois avoir de vraies bases de développement d'ici là. Le cours est un **complément** à ma formation, pas un remplacement, et tu ne promets rien sur mes résultats scolaires.
- Objectif à long terme : devenir développeur de jeux vidéo et rejoindre une équipe.
- **Je me distrais vite.** Ma disponibilité varie d'un jour à l'autre, de 15 min à 2 h. Ma motivation dépend de l'intérêt que je trouve au cours.
- J'apprends mieux avec un **mélange d'explications écrites, de pratique et de vidéos**. Ce qui me motive le plus : des **petits défis avec un résultat visible** et **plusieurs petits exercices qui forment un projet à la fin**.
- Je veux **comprendre**, pas copier-coller. Quand j'ai besoin d'aide, je veux d'abord des indices, pas la solution.
- Préférences d'affichage : **thème sombre**, police sans serif **Roboto**, lecture confortable.

---

# 3. MATÉRIEL : DEUX MACHINES, DEUX RÔLES

## PC fixe : machine principale (jeu et mapping)
Windows 11, Intel Core i5-14400F, RTX 5060 Ti 16 Go, **16 Go de RAM**.
Rôle : **tout**, y compris ce que le portable ne peut pas faire : lancer le **jeu Nanos World**, **Unreal Engine** (mapping), Blender.
Avertissement à intégrer : 16 Go de RAM, c'est juste pour Unreal Engine. Donne des conseils concrets : fermer navigateur et applications, réduire la qualité de l'éditeur, taille du fichier d'échange Windows, espace disque nécessaire, petites maps, sauvegardes régulières. Indique la **version d'Unreal exigée par Nanos World** (à vérifier).

## Petit portable : machine de code et de concentration
HP 16-bu0035nfx (réf. 1241714), écran 16", Intel Core Ultra 5 225U (gamme basse consommation), 16 Go DDR5, SSD 512 Go, **carte graphique intégrée uniquement**, Windows.
- **Rien n'est encore installé dessus** (je viens de l'acheter). Je veux y installer **VS Code, Git, GitHub et les outils de développement**. **Je veux le tutoriel d'installation complet dans le cours.**
- Il sert à : coder (VS Code), lire le cours, utiliser Git/GitHub, faire les parcours A à D, écrire des scripts, lancer le site du cours en local, et **si la doc le confirme**, exécuter un **serveur dédié Nanos World local** pour tester des scripts (un serveur n'a normalement pas besoin d'affichage, **mais vérifie dans la doc officielle** ses prérequis : système, dépendances, ports, ressources, et dis-moi honnêtement si le portable peut le faire).
- Il **ne doit pas** servir à lancer le client du jeu ni Unreal Engine (GPU intégré, 512 Go de stockage). Ne me propose jamais d'y installer Unreal. Garde ses installations **légères** (pas de logiciel inutile).

## Synchronisation entre les deux machines
Mon code et mes exercices passent par **Git et GitHub** : je fais `push` sur une machine et `pull` sur l'autre. C'est aussi un excellent entraînement à Git. Prévois cette méthode dès le parcours A, avec les **cas d'erreur courants** (oublier de `pull`, conflits, fichiers non suivis). Pour la progression du site, voir section 7.5.

## Vieux portable (optionnel)
Je pourrais un jour y mettre Debian. À proposer seulement comme **exercice bonus tardif** (héberger un serveur de jeu de test), sans dépendance. Le site du cours est statique : **pas de LAMP ni de PHP nécessaire**.

## État actuel de mes machines (à détecter, pas à deviner)
J'ai un compte GitHub. J'ai peut-être VS Code sur l'une des machines, mais **je ne sais pas si Git est installé**. Je ne sais pas où je lancerai Claude Code. Donc :
- **Détecte sur quelle machine tu tournes** (modèle, processeur, RAM, espace disque, version de Windows, outils déjà présents : `git`, `code`, `node`, `lua`, `winget`) avec des **commandes en lecture seule**, et dis-moi ce que tu as trouvé.
- Écris les tutoriels pour **les deux machines**, quelle que soit celle sur laquelle tu es, et ajoute une page « **Checklist : où j'en suis sur chaque machine** » avec cases à cocher.
- Si tu ne peux pas inspecter l'autre machine, **demande-moi** de lancer les commandes de vérification que tu fournis et de te coller le résultat.

## Accès à Nanos World : EN ATTENTE
Ma demande d'accès (liste d'attente / whitelist) est en cours. **Vérifie les conditions d'accès actuelles dans la documentation officielle** et dis-moi honnêtement ce que tu trouves. Conséquence : **les parcours A à D n'ont besoin d'aucun accès à Nanos World**, et le site contient un « **Plan B si l'accès tarde** ». Si l'accès devient impossible ou très long, propose un parcours de remplacement (autre moteur ou framework de scripts de jeu), seulement comme alternative signalée.

---

# 4. INSTALLATION ET OUTILS : TUTORIELS PAS À PAS (PRIORITÉ ABSOLUE)

C'est la première chose dont j'ai besoin. Crée **`INSTALLATION.md`** et, sur le site, une section « **Installer mon environnement** » avec **un tutoriel complet par machine** (portable, PC fixe). Je suis débutant : **rien n'est sous-entendu**.

## 4.1 Format obligatoire de chaque tutoriel d'outil
Pour chaque outil : **à quoi il sert** (en une phrase simple), **essentiel / utile / optionnel**, source officielle, coût, **étapes numérotées et précises** (où cliquer, quelle option cocher, quelle commande taper), la **commande `winget` si elle existe et est vérifiée** (sinon le lien officiel), **ce que je dois voir si ça a marché** (commande de vérification et résultat attendu), **erreurs fréquentes** et leur solution, comment **désinstaller**, risques éventuels. Les commandes sont à taper dans **Windows Terminal / PowerShell** : explique-moi d'abord comment l'ouvrir et comment lire ce qui s'affiche.

## 4.2 Liste minimale à traiter (à compléter selon tes recherches)

**Sur le portable ET sur le PC fixe :**
1. **Windows Terminal / PowerShell** : ouvrir, se déplacer, notions de base (`cd`, `dir`, `mkdir`).
2. **Git pour Windows** : installation, **configuration de l'identité** (`user.name`, `user.email`) en expliquant comment utiliser l'**adresse e-mail « noreply » de GitHub** pour ne pas exposer ma vraie adresse (vérifie le fonctionnement actuel), fin de ligne, branche par défaut.
3. **Connexion à GitHub** : méthode la plus simple et sûre, **vérifiée** (par exemple Git Credential Manager avec connexion par navigateur, ou GitHub CLI). **Ne me demande jamais mon mot de passe dans le terminal ; n'écris jamais de jeton dans un fichier ni dans le dépôt.** SSH en option, expliqué simplement.
4. **VS Code** : installation (ou vérification), réglages recommandés (`settings.json`), thème, taille de police, terminal intégré, **extensions recommandées** (section 4.3), et **Settings Sync** pour retrouver la même configuration sur les deux machines (vérifie son fonctionnement actuel).
5. **Lua en local** (si c'est utile et fiable sur Windows : compare les options et choisis-en une, avec la **version correspondant à celle de Nanos World**, à vérifier).
6. **Node.js (version LTS actuelle)** pour construire et lancer le site du cours en local.
7. **Mon dépôt de cours** : créer le dépôt GitHub, le cloner sur chaque machine, premier commit/push/pull, **test de synchronisation entre les deux machines**.
8. **Claude Code** (voir 4.4) : seulement si tu me le recommandes, avec installation vérifiée dans la doc officielle.

**Sur le PC fixe uniquement :**
9. **Nanos World** (client et outils) quand mon accès sera ouvert, par la **méthode officielle vérifiée**.
10. **Unreal Engine** dans **la version exigée par Nanos World**, avec réglages pour 16 Go de RAM et espace disque nécessaire.
11. **Blender** (optionnel, pour le mapping avancé et les petits objets).
12. **Discord** (communauté Nanos World) : optionnel mais recommandé.

**Sur le portable, uniquement si la doc le confirme :**
13. **Serveur dédié Nanos World local** pour tester des scripts. Si c'est impossible ou déconseillé, dis-le clairement.

Donne un **ordre d'installation conseillé**, avec **ce qui est nécessaire tout de suite** (Git, VS Code, GitHub, Terminal) et ce qui peut attendre.

## 4.3 Extensions VS Code
Recommande un **petit jeu d'extensions** (pas 30), classées essentielles / utiles / optionnelles, avec éditeur vérifié et lien officiel. Cherche notamment : **support Lua** (serveur de langage), **aide à l'écriture de code Nanos World** (extension, définitions ou autocomplétion officielles, **s'ils existent**), **Git/GitHub** (historique, comparaison), Markdown, **correcteur orthographique français**, HTML/CSS, lint et mise en forme, affichage des erreurs en ligne. Fournis un `settings.json` et un `extensions.json` de recommandations pour le dossier du projet. Pour chaque extension : à quoi elle sert, comment vérifier qu'elle marche, quoi faire si elle ne marche pas.

## 4.4 Claude Code lui-même
Recherche dans la **documentation officielle de Claude Code** la manière **actuelle** de l'installer sur Windows 11 (et ses prérequis) et de bien le configurer pour ce projet. Recommande-moi ce qui est utile parmi (à vérifier, ne présume rien) :
- l'**intégration avec VS Code** (extension officielle) ;
- un fichier **`CLAUDE.md`** à la racine (tu le crées : règles du projet, conventions, commandes de build, rappel de mon profil, pour que chaque nouvelle session reprenne le contexte) ;
- des **réglages de permissions** raisonnables (lecture libre ; confirmation pour l'installation, la suppression, le réseau, `git push`) ;
- **commandes slash personnalisées, sous-agents, hooks, skills, plugins et serveurs MCP** : lesquels apportent un vrai bénéfice ici (documentation à jour, test du site dans un navigateur, intégration GitHub, aide au design), lesquels sont inutiles ;
- la **reprise** après interruption et la gestion d'une longue tâche.
**Sécurité** : ne recommande que des extensions, plugins ou MCP **officiels ou très largement utilisés** ; vérifie l'éditeur et la source ; signale les permissions demandées ; **demande-moi avant d'installer quoi que ce soit**.

## 4.5 Outils pour ne pas décrocher
Seulement si c'est pertinent et gratuit : un outil de révision espacée, un minuteur de concentration, un bloqueur de distractions. **2 ou 3 recommandations utiles**, pas une liste infinie.

## 4.6 Document de synthèse
Crée aussi `OUTILS-RECOMMANDES.md` : tableau récapitulatif (outil, rôle, essentiel/utile/optionnel, portable, PC fixe, source, coût, risques).

---

# 5. RÈGLES DE RECHERCHE ET D'HONNÊTETÉ (TRÈS IMPORTANT)

1. **Ne te fie pas à ta mémoire** pour Nanos World, Claude Code, Unreal, Git pour Windows, les extensions ou les versions : tout évolue. Fais des recherches multiples et **lis les pages en entier** avant d'écrire chaque parcours.
2. Sources prioritaires : documentation officielle de Nanos World et son dépôt GitHub (exemples de packages), de Lua, Git, GitHub, VS Code, Unreal Engine, Blender, Claude Code. Ensuite seulement : ressources communautaires récentes.
3. À vérifier absolument : version actuelle de Nanos World ; **version de Lua utilisée** ; installation d'un serveur ; **ce que le serveur dédié exige** ; structure d'un package ; classes et événements ; sauvegarde de données ; WebUI ; **pipeline complet de création de maps** (outils, version d'Unreal, export, test) ; conditions d'accès ; **commandes d'installation `winget` et leurs identifiants**.
4. Si une info est **incertaine, obsolète ou contradictoire**, écris-le avec la source et la date de vérification. **N'invente jamais** une fonction, une commande, un identifiant de paquet, un lien ou une option.
5. La documentation officielle est en anglais : pour chaque notion importante, **explique-la en français avec tes propres mots**, mets le lien officiel et ajoute un petit **lexique anglais/français**. Ne recopie pas de longs passages : reformule et renvoie vers la source.
6. Crée `SOURCES.md` : sources, ce qu'elles ont servi à vérifier, date de consultation.
7. Chaque module a « Pour aller plus loin » avec 2 à 4 liens **vérifiés**.
8. Vérifie le **référentiel du BTS SIO option SLAM** pour que le parcours D soit pertinent.
9. Si tu n'as pas accès au web, préviens-moi **immédiatement**.
10. Marque clairement ce qui **n'a pas pu être testé en conditions réelles** (jeu, Unreal, installation sur la machine que tu n'as pas pu inspecter).

---

# 6. VIDÉOS YOUTUBE EN FRANÇAIS (RÔLE : SECOURS)

- **L'essentiel du cours est écrit par toi.** Les vidéos servent quand je ne comprends pas : bloc repliable « 🎥 Pas compris ? Regarde ça ».
- Tu **ne peux pas regarder** une vidéo. N'intègre **que des vidéos trouvées via une vraie recherche web**, dont tu as vérifié l'existence. Note : titre exact, chaîne, durée approximative, langue, ce qu'elle couvre **d'après sa description**, date de vérification. Indique dans `SOURCES.md` que leur contenu n'a pas été visionné.
- **N'invente jamais** un lien ou un identifiant. En cas de doute, mets un **lien de recherche YouTube** avec de bons mots-clés.
- Préfère des vidéos **courtes (moins de 15 min)** ciblées sur une notion, de chaînes francophones reconnues ; quelques formations longues seulement si elles sont très pertinentes (Lua, Git, bases de programmation, Unreal Engine, Blender, SQL, HTML/CSS, **installation de VS Code et Git sur Windows**).
- Intégration : iframe `youtube-nocookie.com`, chargement différé, plus lien direct de secours.
- Contenu francophone sur Nanos World : probablement rare. **Dis-le honnêtement** et compense par tes explications.

---

# 7. SITE WEB

## 7.1 Technique
- **Site statique** généré depuis des fichiers Markdown, déployé sur **GitHub Pages** via **GitHub Actions**, et utilisable **en local** (commandes documentées). Compare brièvement des outils (Astro Starlight, Docusaurus, VitePress, MkDocs Material…) et **justifie** ton choix dans `PLAN.md` : simplicité, beauté, recherche intégrée, rendu du code Lua, composants interactifs, build léger (le portable est peu puissant), maintenance par un débutant.
- Le build doit passer sans erreur. **Teste-le.**
- Demande-moi mon nom d'utilisateur GitHub et le nom du dépôt quand tu en as besoin. Vérifie les contraintes de GitHub Pages (dépôt public ou privé selon mon type de compte). **Aucune donnée personnelle dans le site.**

## 7.2 Design
- **Thème sombre par défaut**, police **Roboto** (texte) et **Roboto Mono** ou équivalent lisible (code), **auto-hébergées**.
- Contrastes accessibles (WCAG AA), texte aéré, largeur de lecture confortable, taille de police réglable, navigation clavier, responsive (PC, portable 16", mobile).
- Un peu de personnalité (illustrations simples, icônes, couleur d'accent par parcours) sans surcharger : **la lisibilité d'abord**.
- Aucune dépendance obligatoire à un CDN externe : le site marche hors ligne en local.

## 7.3 Fonctions du site
- Accueil avec **« Reprendre où j'en suis »** et **« Ta prochaine action »**, tableau de bord de progression, parcours en cartes.
- Sommaire par parcours et module, précédent/suivant, fil d'Ariane, **recherche** dans tout le cours.
- Blocs de code avec **coloration Lua**, bouton **Copier**, **nom du fichier cible** et mention client/serveur quand c'est pertinent. Les commandes de terminal sont clairement distinguées du code.
- Exercices avec **3 indices progressifs** et **solution repliable commentée**.
- **Quiz interactifs** avec correction expliquée.
- Encadrés : « À retenir », « Piège à éviter », « Astuce de pro », « Si tu es bloqué ».
- **Mode concentration** (masque menu et distractions) avec **minuteur de séance** optionnel (15 / 25 / 45 min).
- Chaque leçon affiche : durée, **où la faire (💻 portable / 🖥️ PC fixe / 🔀 les deux)**, prérequis, résultat attendu.
- Pages : `Installer mon environnement`, `Checklist par machine`, `Glossaire`, `Aide-mémoire` (Terminal, Lua, Git, Nanos World, Unreal), `Dépannage`, `Où travailler`, `Mon environnement` (outils), `Plan B Nanos World`, `Journal de bord`, `Mes réussites`.

## 7.4 Mini-labos dans le navigateur (OPTIONNELS)
Puisque je vais installer mes outils, les labos ne sont **plus indispensables**. Ils servent aux **séances rapides** et au dépannage.
- **Labo Lua** (éditeur + bouton Exécuter + sortie/erreurs, dans le navigateur). **Vérifie sa version de Lua** et compare avec celle de Nanos World ; liste les différences.
- **Labo SQL** (SQLite) et **labo HTML/CSS/JS** avec aperçu en direct, pour le parcours D.
- Si une solution est trop lourde ou peu fiable, **dis-le** plutôt que de livrer un labo cassé. Un labo ne doit jamais bloquer la lecture. Il n'envoie aucune donnée à un serveur.

## 7.5 Progression et synchronisation
- Progression stockée **dans le navigateur** : cases par étape, pourcentage par module, niveaux (**Novice → Apprenti → Scripteur → Mappeur → Développeur**), XP, badges, série de jours (**sans culpabilisation** : une pause ne casse rien).
- Le stockage navigateur est **propre à chaque machine** : ajoute **Exporter / Importer ma progression** et un rappel visible. Explique-moi honnêtement le problème. Une fois que je maîtrise Git, propose une option pour **stocker le fichier de progression dans mon dépôt** afin de le synchroniser avec `push`/`pull`.
- **Aucun jeton ni compte** dans cette synchronisation.

---

# 8. PÉDAGOGIE

## 8.1 Format de chaque module
Objectifs mesurables ; durée ; prérequis ; où le faire ; **pourquoi c'est utile** (lien avec un serveur roleplay, une map ou le BTS) ; explication progressive en **une notion à la fois** (définition simple, analogie de la vie réelle, exemple court commenté, explication ligne par ligne) ; **« On code ensemble »** (pas-à-pas avec résultat attendu et vérification) ; **erreurs fréquentes** avec les vrais messages ; encadrés ; récapitulatif d'une page ; vidéos de secours ; « Pour aller plus loin ».

## 8.2 Micro-leçons
Chaque module est découpé en **étapes de 15 à 20 minutes** qu'on peut enchaîner ou arrêter après une seule. Chaque étape finit par **une mini-victoire visible** (commande qui affiche le bon résultat, test vert, objet dans le jeu, élément dans Unreal) et une **« Prochaine action »** précise pour la reprise du lendemain. Chaque leçon propose **trois durées** : « Si tu as 15 min », « 45 min », « 2 h ».

## 8.3 Exercices et évaluation
- **8 à 15 exercices par module** en trois niveaux : 🟢 échauffement, 🟡 application, 🔴 défi. Énoncé clair, résultat attendu, **3 indices progressifs**, critères de validation, **solution commentée** repliable.
- Des exercices de **débogage** (code cassé à réparer) et de **lecture de code**.
- Un **mini-projet par module** qui nourrit le projet fil rouge.
- Un **quiz de 10 questions** par module et un **bilan** à la fin de chaque parcours.
- **Révisions espacées** : à partir du parcours C, chaque module commence par 3 à 5 questions de rappel.
- **Points de contrôle** toutes les quelques heures : « Tu sais maintenant faire X, Y, Z ».

## 8.4 Anti-blocage et IA comme tuteur
- Section « **Je suis bloqué, que faire ?** » dans chaque module : relire l'erreur, isoler, chercher dans la doc, demander à une IA, demander sur Discord.
- **Prompts modèles** pour utiliser une IA comme tuteur **sans qu'elle fasse le travail à ma place**.
- `Dépannage` alimenté avec les vraies erreurs (notamment d'installation sous Windows : PATH non reconnu, droits, pare-feu, politique d'exécution PowerShell, conflit de fins de ligne, authentification GitHub refusée).

## 8.5 Ton
Chaleureux, direct, **tutoiement**, sans jargon inutile. Toujours le « pourquoi » avant le « comment ». Jamais plus de quelques paragraphes sans que je pratique. Exemples sur le thème roleplay (métiers, argent, véhicules, magasin, maison, parc, grotte).

---

# 9. PARCOURS ET CONTENU (≈ 140 à 150 H)

Ordre conseillé : **A → B → C → D** en priorité (aucun accès à Nanos World requis). **E** (scripts) et **F** (mapping) s'entrelacent dès que mon accès est ouvert, par exemple une séance de mapping toutes les trois séances. **G** et **H** viennent ensuite.

**Parcours A : Installer mon environnement et démarrer (≈ 6 h) : 💻 + 🖥️**
Ce qu'est le développement et comment fonctionne un jeu multijoueur (client/serveur, par analogies) ; Terminal/PowerShell de base ; **installation guidée complète sur le portable, puis sur le PC fixe** (tout le contenu de la section 4.2, étape par étape, avec vérification à chaque fois) ; configuration de VS Code et des extensions ; **premier dépôt GitHub, premier commit, premier push, puis `pull` sur l'autre machine** (test de synchronisation) ; premier « Hello World » en Lua ; lire une documentation en anglais avec un traducteur ; lire un message d'erreur ; chercher efficacement ; poser une bonne question à une IA ; configuration de Claude Code recommandée (4.4). Fin du parcours : checklist « Mes deux machines sont prêtes ».

**Parcours B : Lua et logique (≈ 24 h) : 🔀**
Niveau 1 : variables, types, opérateurs, chaînes, conditions, boucles, fonctions, tables (listes et dictionnaires), portée, `nil`, commentaires, nommage, lecture d'erreurs. Niveau 2 : tables imbriquées, fonctions comme valeurs, closures, **modules** (organisation en fichiers), métatables et objet simple, `pcall`/`error`, manipulation de chaînes, sérialisation JSON si pertinent. Mini-projets : mini-inventaire, calculateur de salaire, jeu de devinettes en texte, mini boutique en texte.

**Parcours C : Penser en développeur + Git/GitHub approfondi (≈ 16 h) : 🔀**
Décomposer un problème, pseudo-code, débogage méthodique (logs, isoler, reproduire), lire du code qu'on n'a pas écrit, DRY, fonctions courtes, relecture, tests manuels structurés. Git : `status`, `log`, `diff`, `branch`, `merge`, `.gitignore`, conflits, branches de fonctionnalité, Pull Requests, Issues, revue de code, bons messages de commit, README propre, licence. Simulation d'équipe : un conflit à résoudre et une PR à relire.

**Parcours D : Passerelle SLAM (≈ 18 h) : 🔀, prioritaire avant janvier**
D'après le **référentiel SLAM que tu auras vérifié** : algorithmique, **programmation orientée objet** (classes, objets, encapsulation, héritage, polymorphisme, exemples de jeu), **bases de données et SQL** (SQLite : `SELECT`, filtres, jointures, `INSERT`/`UPDATE`/`DELETE`, modélisation simple), **HTML/CSS/JavaScript** de base, **lecture comparée de Lua avec un autre langage** utilisé en SLAM (vérifie lequel : Python, PHP, Java, C#…), diagrammes UML simples. Justifie ton choix dans `PLAN.md`.

**Parcours E : Scripts Nanos World (≈ 34 h) : 🖥️ (💻 pour écrire le code)**
Installation et serveur local (vérifiés) ; structure d'un package ; code serveur / client / partagé ; événements (écouter, déclencher, communication client↔serveur) ; classes principales (à vérifier : Player, Character, Vehicle, Prop…) ; timers ; entrées ; chat et commandes. Premiers vrais scripts : bienvenue, spawns, téléportation, soins, armes, points. Briques roleplay : argent, inventaire, métiers, salaires par timer, zones et déclencheurs, véhicules, permissions et rôles admin. **Sauvegarde de données** (méthodes vérifiées) et **sécurité de base** (ne jamais faire confiance au client). **Interfaces WebUI** (HUD, menus). Architecture, performances, organisation en modules. Chaque script est expliqué ligne par ligne, avec la vérification dans le jeu.

**Parcours F : Mapping (≈ 28 h) : 🖥️, en parallèle de E**
Objectif : **petites maisons, petits parcs et grottes**, avec une base solide pour approfondir. Installation et réglages d'Unreal pour 16 Go de RAM ; interface, navigation, niveaux, acteurs, matériaux, éclairage ; terrain ; placement et modularité ; **intérieurs** (murs, portes, pièces, éclairage intérieur) ; **parcs** (terrain, chemins, végétation simple, mobilier) ; **grottes** (méthode adaptée, **à vérifier**) ; collisions ; optimisation ; **export vers Nanos World et test en jeu** (pipeline vérifié). Aperçu de Blender pour de petits objets, sans dépendance. Chaque étape produit quelque chose de visible. Fin : un petit « village » de test (maison + parc + grotte) réutilisé dans le projet fil rouge.

**Parcours G : Projet fil rouge (≈ 16 h) : 🖥️**
Un **mini serveur roleplay** avec **ma propre petite map** : argent, un ou deux métiers, inventaire simple, sauvegarde, HUD, commandes admin. Cahier des charges, étapes validables, checklist de qualité, démonstration finale. Les mini-projets des parcours précédents y sont réutilisés.

**Parcours H : Autonomie et employabilité (≈ 6 h) : 🔀**
Portfolio GitHub, README de projet, lire et contribuer à un projet existant, travailler en équipe (tickets, communication, Discord), méthode de débogage autonome, et prochaines étapes (approfondir mapping et 3D, un autre langage, Godot/Unreal).

---

# 10. PARCOURS « EXPRESS AVANT JANVIER »

Dans `PLAN.md` et sur le site, propose un **planning d'environ 12 semaines** (base indicative : 6 à 7 h par semaine, adaptable à mes jours variables) qui montre :
- ce qui est **essentiel pour SLAM** (A, B, C, D) et ce qui peut attendre ;
- un **rythme minimal** (par exemple 3 séances de 30 min par semaine) pour garder le contact les semaines chargées ;
- des **jalons** par quinzaine, avec un projet visible à chaque jalon ;
- **l'installation des deux machines dès la première semaine** ;
- l'entrelacement de E et F **dès que mon accès Nanos World sera ouvert**.
Précise que c'est un complément à mon BTS.

---

# 11. MÉTHODE DE PRODUCTION (VAGUES)

Le travail est énorme : procède par **vagues**, chacune livrable et utilisable.

**Phase 0 : Recherche et plan.** Détecte l'état de la machine (section 3), recherche, puis écris `PLAN.md` (architecture, outil de site choisi et pourquoi, parcours, durées, planning express, écarts avec ce prompt et pourquoi), `OUTILS-RECOMMANDES.md` et `INSTALLATION.md` (version de départ). Montre-les-moi, puis continue sans attendre sauf décision indispensable.
**Vague 1 : Installation + socle.** Tutoriels d'installation complets (portable et PC fixe), `CLAUDE.md`, site complet (thème, composants, progression, déploiement), **Parcours A et B entièrement rédigés**. À la fin, je peux commencer à installer mes machines et le cours.
**Vague 2 :** Parcours C et D.
**Vague 3 :** Parcours E et F (les plus vérifiés et documentés).
**Vague 4 :** Parcours G et H, vérification globale (liens, numérotation, vocabulaire, difficulté croissante, build final).
**Phase finale :** résumé court : par où commencer, comment lancer le site en local, comment le publier sur GitHub Pages, comment synchroniser mes deux machines, comment reprendre une session.

Règles :
- Pas de squelette vide ni de « à compléter plus tard ».
- Mets à jour `ETAT_AVANCEMENT_COURS.md` (terminé / reste à faire / comment reprendre) et `CLAUDE.md`.
- **Commits Git réguliers** avec de bons messages (ça me sert d'exemple).
- **Demande-moi confirmation avant** d'installer un logiciel, d'exécuter une commande qui modifie quoi que ce soit hors de ce dossier, de supprimer des fichiers, de faire un `git push` ou de changer des réglages système.
- Ne demande jamais mes mots de passe ; pour GitHub, utilise une connexion officielle via navigateur.
- Si tu manques de place ou de contexte, arrête-toi proprement, mets l'état à jour et dis-moi comment reprendre.

---

# 12. CONTRÔLE QUALITÉ

- **Exécute les exercices de Lua pur** (parcours A à D) et vérifie que toutes les solutions passent leurs tests.
- **Relis chaque tutoriel d'installation** : une étape manquante bloque un débutant. Chaque commande doit venir d'une source officielle vérifiée. Signale ce que tu n'as pas pu tester sur ma machine.
- Pour le code lié au moteur ou à Unreal : vérifie chaque appel contre la documentation officielle et signale ce qui n'a pas pu être testé en conditions réelles.
- Exemples complets, copiables, commentés en français, avec le nom du fichier cible.
- Aucune notion utilisée avant d'être expliquée ; vocabulaire homogène avec le glossaire ; liens internes et externes valides ; numérotation correcte ; difficulté strictement croissante ; pas de remplissage.
- Accessibilité et performance du site vérifiées (build, liens cassés, navigation clavier, contraste).
- Durées **réalistes pour un débutant qui se distrait facilement**.

---

# 13. SÉCURITÉ ET LIMITES

- Pas de logiciel non officiel ni de téléchargement douteux. Pas de crack, pas de contournement de licence.
- Pas de collecte de données personnelles. Le site et le dépôt ne contiennent aucun compte, jeton ou secret.
- Ne promets rien que tu ne peux pas vérifier (accès à Nanos World, résultats scolaires, emploi).

---

# 14. CRITÈRES DE RÉUSSITE

1. Recherche faite ; `SOURCES.md`, `OUTILS-RECOMMANDES.md`, `INSTALLATION.md` et `PLAN.md` détaillés ; vidéos vérifiées avec la limite de ce que tu as pu contrôler.
2. **Un tutoriel d'installation complet, vérifié et pas à pas existe pour le portable ET pour le PC fixe** (Terminal, Git, GitHub, VS Code, extensions, Lua, Node.js, dépôt, synchronisation entre les deux machines ; côté PC fixe : Nanos World, Unreal, Blender).
3. Mes recommandations d'extensions et d'outils (Claude Code, VS Code, Windows) sont justifiées, sourcées et classées par priorité ; rien n'a été installé sans mon accord.
4. Le site se construit sans erreur, est déployable sur GitHub Pages et utilisable en local, en thème sombre avec Roboto.
5. Parcours A à H entièrement rédigés, avec exercices, indices, solutions, quiz, et représentant réalistement plus de 100 h.
6. Parcours « Express avant janvier » clair, avec l'essentiel SLAM identifié.
7. Le mapping (maisons, parcs, grottes) est couvert de façon pratique, avec les limites de mon matériel prises en compte.
8. Le projet fil rouge est complet et validable par étapes.
9. Suivi de progression, niveaux, indices, mode concentration et « prochaine action » fonctionnent ; la synchronisation entre mes deux machines est expliquée.
10. Les incertitudes et ce qui n'a pas été testé sont signalés honnêtement.
11. Un débutant complet, sans accès à Nanos World au départ, peut commencer **dès aujourd'hui** par l'installation et ne reste pas bloqué.

Commence maintenant par la Phase 0 : détecte l'état de la machine, fais ta recherche, puis écris `PLAN.md`, `OUTILS-RECOMMANDES.md` et la première version de `INSTALLATION.md`.

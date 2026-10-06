# Sources consultées

> Toutes consultées le **6 octobre 2026**.
> **Méthode** : le proxy de l'environnement de travail bloquait plusieurs sites officiels. Dans ce cas, j'ai lu la **source officielle publiée sur GitHub** (la documentation de ces projets est open source et c'est elle qui génère le site). La colonne « Accès » l'indique :
> - **Direct** : page lue directement.
> - **Source GitHub** : fichier source officiel de la page, lu dans le dépôt de l'éditeur (dernier commit indiqué quand utile).
> - **Recherche** : existence et intitulé confirmés par un moteur de recherche (page non ouverte).

## 1. Nanos World

| Source | Accès | A servi à vérifier |
|---|---|---|
| Dépôt `nanos-world/docs` (commit `46a50bb` du 1er octobre 2026), qui génère https://docs.nanos-world.com | Source GitHub | Tout ce qui suit |
| https://docs.nanos-world.com/docs/signing-up-alpha | Source GitHub | Closed Testing, formulaire en anglais, réponses IA rejetées, priorité aux membres actifs, clés Playtest/Beta, branches `default`/`bleeding-edge`, playtests publics, règles des testeurs |
| https://docs.nanos-world.com/docs/scripting-reference/glossary/basic-types et `core-concepts/packages/package-loading-and-lua-environment` | Source GitHub | « nanos world runs **Lua 5.4** » |
| https://docs.nanos-world.com/docs/assets-modding/creating-assets/setting-up-ue | Source GitHub | **Unreal Engine 5.7.X**, Epic Games Launcher, Windows SDK `10.0.26100.0` |
| https://docs.nanos-world.com/docs/core-concepts/server-manual/server-installation | Source GitHub | Prérequis du serveur (2×1 GHz, 50 Mo RAM, 30 Mo, ports 7777/7778), VC++ Redistributable, SteamCMD, app id `1936830`, connexion anonyme, commandes en une ligne |
| https://docs.nanos-world.com/docs/getting-started/quick-start | Source GitHub | `--cli add package`, structure `Server/ Client/ Shared/ Package.toml`, `Config.toml` |
| https://docs.nanos-world.com/docs/getting-started/editor-setup | Source GitHub | Extension VS Code officielle `go-horse-studios.nanos-world` (dépend de `sumneko.lua`) |
| https://docs.nanos-world.com/docs/assets-modding/creating-assets/maps-and-levels/importing-maps | Source GitHub | Règles de création de maps ; page **marquée comme ancienne** (captures UE4) |
| https://docs.nanos-world.com/blog/august-2026 | Source GitHub | Playtest public d'Halloween du 30 octobre au 1er novembre 2026 ; Game Jam du 24 septembre au 23 octobre |
| Dépôt `nanos-world/nanos-world-server` (`Config.toml`, `_script.toml`) | Source GitHub | Ports, sections `[game]`, `packages`, modèle de `Package.toml` |
| https://github.com/nanos-world/assets-development-kit | Source GitHub | Existence de l'ADK |
| https://store.steampowered.com/app/1841660/nanos_world/ | Recherche | Page Steam officielle |

## 2. Outils Windows et winget

| Source | Accès | A servi à vérifier |
|---|---|---|
| Dépôt officiel des manifestes `microsoft/winget-pkgs` | Source GitHub | Identifiants et dernières versions : `Git.Git` (2.55.0.5), `Microsoft.VisualStudioCode` (1.140.0), `OpenJS.NodeJS.LTS` (24.19.0), `DEVCOM.Lua` (5.4.6), `Anthropic.ClaudeCode`, `GitHub.cli`, `BlenderFoundation.Blender` (5.2.2), `EpicGames.EpicGamesLauncher`, `Discord.Discord`, `Microsoft.WindowsTerminal`, `Valve.Steam`, `Microsoft.VCRedist.2015+.x64`, éditeurs et licences |
| https://learn.microsoft.com/windows/package-manager/winget/install (source `MicrosoftDocs/windows-dev-docs`) | Source GitHub | Options `--id`, `-e/--exact`, `-s/--source` |
| https://learn.microsoft.com/windows/package-manager/winget/ | Source GitHub | winget inclus dans App Installer sur Windows 11 ; lien Microsoft Store |
| https://learn.microsoft.com/windows/terminal/install (source `MicrosoftDocs/terminal`) | Source GitHub | Windows Terminal inclus dans Windows 11 |
| about_Execution_Policies (source `MicrosoftDocs/PowerShell-Docs`, 5.1) | Source GitHub | Politique **Restricted** par défaut sur Windows client ; `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| https://github.com/DevelopersCommunity/cmake-lua (README, CMakeLists.txt) | Source GitHub | `winget install --id DEVCOM.Lua`, exécutable `lua`, LuaRocks inclus |
| https://nodejs.org/en/about/previous-releases | Direct | Node.js 24 = Active LTS (24.21.0), 22 = Maintenance LTS, 20 en fin de vie |
| https://support.microsoft.com/windows/how-to-use-focus-in-windows-11-cbcc9ddb-8164-43fa-8919-b9a2af072382 | Recherche | Sessions de concentration (Horloge) dans Windows 11 |
| https://apps.ankiweb.net | Recherche | Site officiel d'Anki |

## 3. Git, GitHub, VS Code

| Source | Accès | A servi à vérifier |
|---|---|---|
| Installeur officiel Git pour Windows (`git-for-windows/build-extra`, `installer/install.iss`) | Source GitHub | Intitulés exacts des écrans et options de l'installeur |
| https://gitforwindows.org/ | Source GitHub (manifeste winget) | Page officielle de Git pour Windows |
| GitHub Docs « Caching your GitHub credentials in Git » (source `github/docs`) | Source GitHub | GCM recommandé, inclus dans Git pour Windows, OAuth ≥ 2.29, réinitialisation dans le Gestionnaire d'identification ; `gh auth login` |
| GitHub Docs « Email addresses reference » et pages associées (source `github/docs`) | Source GitHub | Format `ID+USERNAME@users.noreply.github.com`, « Keep my email addresses private », « Block command line pushes that expose my email » |
| GitHub Docs « Configuring Git to handle line endings », « Associating text editors with Git », « Setting your username in Git » | Source GitHub | `core.autocrlf true`, `core.editor "code --wait"`, `user.name` / `user.email` |
| GitHub Docs « What is GitHub Pages » + `data/reusables/gated-features/pages.md` | Source GitHub | Pages : dépôts publics avec GitHub Free ; privés avec Pro, Team, Enterprise |
| VS Code Docs « Setup Windows » (source `microsoft/vscode-docs`) | Source GitHub | User setup recommandé, sans droits admin, ajout au PATH, `code .` |
| VS Code Docs « Settings Sync » (source `microsoft/vscode-docs`) | Source GitHub | **Backup and Sync Settings...**, connexion GitHub ou Microsoft, conflits |
| https://marketplace.visualstudio.com/items?itemName=sumneko.lua | Recherche | Extension Lua (support Lua 5.4) |
| https://marketplace.visualstudio.com/items?itemName=go-horse-studios.nanos-world | Source GitHub (doc Nanos World) | Extension officielle Nanos World |
| https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker et `...code-spell-checker-french` | Recherche | Correcteur orthographique et dictionnaire français |
| https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens | Recherche | Error Lens |
| https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph | Recherche | Git Graph |
| https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-fr | Recherche | Pack de langue français |
| https://marketplace.visualstudio.com/items?itemName=astro-build.astro-vscode | Recherche | Extension Astro |
| https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code | Recherche | Extension Claude Code |
| https://marketplace.visualstudio.com/items?itemName=Derpius.nanosworld | Recherche | Extension **communautaire** à ne pas confondre avec l'officielle |

## 4. Claude Code

| Source | Accès | A servi à vérifier |
|---|---|---|
| https://code.claude.com/docs/en/setup | Direct | Prérequis, installation native PowerShell/CMD, `winget install Anthropic.ClaudeCode`, `claude --version`, `claude doctor`, abonnement requis, désinstallation |
| https://code.claude.com/docs/en/vs-code | Direct | Extension VS Code, VS Code ≥ 1.94, compte requis |
| https://code.claude.com/docs/en/permissions | Direct | Syntaxe `permissions.allow/ask/deny`, règles `Bash(npm run *)`, `PowerShell(...)`, fichier `.claude/settings.local.json` |
| https://code.claude.com/docs/en/cli-reference | Direct | `claude -c`, `claude --resume`, `claude update` |

## 5. Unreal Engine, Lua, Astro, BTS

| Source | Accès | A servi à vérifier |
|---|---|---|
| https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-specifications-for-unreal-engine | Recherche | Recommandation Epic : 32 Go de RAM, Windows 11, carte DirectX 12 (résumé du moteur de recherche, page non ouverte) |
| https://www.lua.org/manual/5.4/ | Source GitHub (lien cité par la doc Nanos World) | Manuel de référence Lua 5.4 ; le comportement des exemples a été vérifié en exécutant Lua 5.4.6 |
| Astro Docs « Deploy to GitHub Pages » (source `withastro/docs`) et README de `withastro/action` | Source GitHub | Workflow `actions/checkout@v7`, `withastro/action@v6`, `actions/deploy-pages@v5`, options `site`/`base`, Settings → Pages → Source : GitHub Actions |
| Paquets npm `astro` 7.3.5, `@astrojs/starlight` 0.42.5, `@fontsource/roboto` 5.3.0, `@fontsource/roboto-mono` 5.3.0 | Direct (registre npm) | Versions installées et API réelle (lue dans `node_modules`) |
| https://www.onisep.fr/ressources/univers-formation/Formations/Post-bac/bts-services-informatiques-aux-organisations-option-b-solutions-logicielles-et-applications-metiers | Recherche | Bloc 2 SLAM : concevoir et développer une solution applicative, maintenance, gestion des données ; Git cité ; épreuve E6 (à approfondir en Vague 2 pour le parcours D) |

## 6. Vidéos YouTube (contenu NON visionné)

> Je ne peux pas regarder les vidéos et je n'ai pas pu ouvrir YouTube depuis l'environnement de travail. Chaque vidéo ci-dessous a été **trouvée par une vraie recherche web** (titre et URL exacts tels que renvoyés par le moteur). La **chaîne** et la **durée** ne sont indiquées que si elles figuraient dans le titre ou le résumé du résultat. Le contenu décrit vient du titre ou du résumé, **pas d'un visionnage**. Si une vidéo ne te convient pas, le site propose aussi un **lien de recherche YouTube**.

| Titre exact (tel que trouvé) | URL | Durée | Ce qu'elle couvre (d'après le titre/résumé) | Utilisée dans |
|---|---|---|---|---|
| Apprendre Git & GitHub en 13 minutes - Tutoriel débutant 2026 | https://www.youtube.com/watch?v=m3QeXlytsjw | ≈ 13 min (titre) | Installation, commandes essentielles, premier push | A4 |
| Débuter avec Git et Github en 30 min | https://www.youtube.com/watch?v=hPfgekYUKgk | ≈ 30 min (titre) | Bases de Git et GitHub (La Capsule selon le résumé) | A4 |
| [1/??] Installation des outils - Git & GitHub pour Débutants - Tutoriel français 2018 | https://www.youtube.com/watch?v=HnwNsCKqqT8 | non indiquée | Installation de Git (vidéo de 2018 : écrans possiblement différents) | A2 |
| [5/??] Push/Pull/Clone - Git & GitHub pour Débutants - Tutoriel français 2018 | https://www.youtube.com/watch?v=BTyxX53OWmw | non indiquée | push, pull, clone | A4 |
| Comment Installer Visual Studio Code sur Windows | https://www.youtube.com/watch?v=Gu_FEF4yj5A | non indiquée | Installation de VS Code depuis le site officiel | A2 |
| VS Code : Installation étape par étape (Windows) | https://www.youtube.com/watch?v=GK-O9nWWTeU | non indiquée | Installation pas à pas de VS Code | A2 |
| 15 commandes indispensables pour débuter avec PowerShell | https://youtube.com/watch?pp=0gcJCfcAhR29_xXO&v=UYs8Cn-qvVg | non indiquée | Commandes PowerShell de base | A1 |
| Les commandes cd et pwd | https://www.youtube.com/watch?v=Wee5z6I4JbA | non indiquée | Se déplacer dans les dossiers | A1 |
| Apprendre Lua en partant de ZÉRO (Le vrai premier tutoriel) | https://www.youtube.com/watch?v=lIPNlzNMYNk | non indiquée | Introduction à Lua pour débutants | A5, B1 |
| [FR] [Partie 3] Apprendre le Lua: Les bases et les variables | https://www.youtube.com/watch?v=F-ixOxAwW1k | non indiquée | Variables en Lua | B1 |
| APPRENDRE LE LUA #1 les bases | https://www.youtube.com/watch?v=T184q0KGig0 | non indiquée | Bases de Lua | B1 |

**Contenu francophone sur Nanos World** : je n'ai trouvé **aucune** vidéo francophone sur Nanos World lors de mes recherches. Le cours compense par des explications écrites ; la communauté Discord (anglophone) reste la meilleure aide.

**Attention** : beaucoup de vidéos « Lua » francophones concernent **Roblox**, qui utilise **Luau**, un dérivé de Lua avec des différences. Elles ne sont pas retenues.

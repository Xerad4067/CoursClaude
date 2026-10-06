# Outils recommandés : tableau de synthèse

> Vérifié le **6 octobre 2026**. Priorité : **E** = essentiel, **U** = utile, **O** = optionnel.
> 💻 = portable HP (code, léger) · 🖥️ = PC fixe (jeu, Unreal, tout).
> Rien n'a été installé sur tes machines. Les commandes `winget` viennent du dépôt officiel des manifestes `microsoft/winget-pkgs` et de la doc de chaque éditeur : **non testées sur Windows**.

## 1. Logiciels

| Outil | Rôle (en une phrase) | Prio. | 💻 | 🖥️ | Installation vérifiée | Source officielle | Coût | Risques / remarques |
|---|---|---|---|---|---|---|---|---|
| Windows Terminal + PowerShell | La fenêtre où tu tapes des commandes | E | ✅ | ✅ | Déjà inclus dans Windows 11 (`Microsoft.WindowsTerminal` sinon) | https://learn.microsoft.com/windows/terminal/install | Gratuit | Aucun. La politique d'exécution peut bloquer des scripts (`npm.ps1`) : voir Dépannage |
| winget (App Installer) | Installer des logiciels officiels en une commande | E | ✅ | ✅ | Inclus dans Windows 11 (App Installer) | https://learn.microsoft.com/windows/package-manager/winget/ | Gratuit | Toujours utiliser `--id` + `-e` pour viser le bon paquet |
| Git pour Windows | Enregistrer l'historique de ton code et l'envoyer sur GitHub | E | ✅ | ✅ | `winget install --id Git.Git -e --source winget` (v2.55.0.5 dans winget) | https://gitforwindows.org/ | Gratuit (GPL-2.0) | Bien choisir les options de l'installeur (fin de ligne, éditeur, branche `main`) |
| Git Credential Manager | Se connecter à GitHub par le navigateur, sans mot de passe dans le terminal | E | ✅ | ✅ | Inclus dans Git pour Windows | https://github.com/GitCredentialManager/git-credential-manager | Gratuit | Ne jamais coller de jeton dans un fichier |
| Compte GitHub | Héberger ton code et ton site | E | ✅ | ✅ | Tu en as déjà un | https://github.com | Gratuit | Activer « Keep my email addresses private » |
| VS Code | L'éditeur de code | E | ✅ | ✅ | `winget install --id Microsoft.VisualStudioCode -e` (ou installeur « User setup ») | https://code.visualstudio.com/ | Gratuit | Installer seulement les extensions listées plus bas |
| Lua 5.4 (DEVCOM.Lua) | Exécuter tes scripts Lua en local, même version que Nanos World | E | ✅ | ✅ | `winget install --id DEVCOM.Lua -e` (5.4.6) | https://github.com/DevelopersCommunity/cmake-lua | Gratuit (MIT) | Paquet communautaire packagé pour winget (pas lua.org) ; installe aussi LuaRocks |
| Node.js LTS | Construire et lancer le site du cours en local | E | ✅ | U | `winget install --id OpenJS.NodeJS.LTS -e` (24.x) | https://nodejs.org/ | Gratuit (MIT) | Active LTS = v24 (oct. 2026) |
| Python 3.13 | Faire tourner tes programmes Python (cours de BTS, parcours D, salle d'entraînement) et faire du SQL avec le module `sqlite3` | E (parcours D) | ✅ | ✅ | `winget install -e --id Python.Python.3.13` (3.13.15) ; alternative recommandée par la doc de Python : `Python.PythonInstallManager` | https://www.python.org/ | Gratuit (licence PSF) | Ne mélange pas les deux méthodes d'installation ; si `python` ouvre le Microsoft Store, régler les alias d'exécution (voir INSTALLATION.md §19) |
| DB Browser for SQLite | Regarder une base SQLite avec une interface graphique | O | ✅ | ✅ | `winget install -e --id DBBrowserForSQLite.DBBrowserForSQLite` | https://sqlitebrowser.org/ | Gratuit | Optionnel : `python -m sqlite3` suffit pour le cours |
| GitHub CLI (`gh`) | Alternative pour se connecter à GitHub et gérer PR/issues | O | ✅ | ✅ | `winget install --id GitHub.cli -e` | https://cli.github.com/ | Gratuit | Pas nécessaire si Git Credential Manager fonctionne |
| Steam | Installer le jeu Nanos World (et son serveur) | E (si accès) | ❌ | ✅ | `winget install --id Valve.Steam -e` | https://store.steampowered.com/about/ | Gratuit | Compte Steam requis |
| Nanos World (client) | Le jeu, pour tester tes scripts et tes maps | E (si accès) | ❌ | ✅ | Clé Steam reçue après sélection (ou playtest public) | https://docs.nanos-world.com/docs/signing-up-alpha | Gratuit en test | Accès en *Closed Testing* : non garanti |
| Serveur dédié Nanos World | Faire tourner tes packages Lua | U | ✅ (possible d'après la doc) | ✅ | SteamCMD : `app_update 1936830` (connexion anonyme) ou outil Steam « nanos world Dedicated Server » | https://docs.nanos-world.com/docs/core-concepts/server-manual/server-installation | Gratuit | Ports 7777/7778 ; pare-feu Windows ; nécessite Visual C++ Redistributable |
| Visual C++ Redistributable x64 | Bibliothèque dont le serveur Nanos World a besoin sous Windows | U | ✅ | ✅ | `winget install --id Microsoft.VCRedist.2015+.x64 -e` | https://learn.microsoft.com/cpp/windows/latest-supported-vc-redist | Gratuit | Souvent déjà présent |
| Epic Games Launcher | Installer Unreal Engine | E (mapping) | ❌ | ✅ | `winget install --id EpicGames.EpicGamesLauncher -e` | https://www.unrealengine.com/download | Gratuit | Compte Epic requis |
| Unreal Engine 5.7 | Créer les maps et assets pour Nanos World | E (mapping) | ❌ **jamais** | ✅ | Depuis le launcher, onglet Unreal Engine → Library → `+` → 5.7 | https://docs.nanos-world.com/docs/assets-modding/creating-assets/setting-up-ue | Gratuit (licence Epic) | Très gourmand : 32 Go de RAM recommandés par Epic, tu en as 16 → réglages « petite machine » |
| Windows SDK | Nécessaire pour « cooker » des assets avec UE 5.x | E (mapping) | ❌ | ✅ | Via Visual Studio Installer ou le site Microsoft (voir INSTALLATION.md) | https://learn.microsoft.com/windows/apps/windows-sdk/downloads | Gratuit | Plusieurs Go |
| Blender | Modéliser de petits objets 3D | O | ❌ | ✅ | `winget install --id BlenderFoundation.Blender -e` (5.2.x) | https://www.blender.org/ | Gratuit (GPL) | Optionnel, sans dépendance dans le cours |
| Discord | Communauté Nanos World (aide, accès prioritaire) | U | ✅ | ✅ | `winget install --id Discord.Discord -e` | https://discord.nanos-world.com | Gratuit | Distraction possible : couper les notifications pendant les séances |
| Claude Code | Assistant de code dans le terminal ou VS Code | O | ✅ | ✅ | `irm https://claude.ai/install.ps1 \| iex` ou `winget install Anthropic.ClaudeCode` | https://code.claude.com/docs/en/setup | **Abonnement payant requis** (Pro, Max, Team, Enterprise ou Console) | À utiliser comme tuteur, pas pour faire tes exercices à ta place |

**Volontairement absent** : Unreal Engine et le client du jeu sur le portable (GPU intégré, 512 Go), LAMP/PHP (le site est statique), Python (prévu au parcours D, pas avant).

## 2. Extensions VS Code (petit jeu, 10 au total)

Toutes vérifiées sur le Visual Studio Marketplace (identifiant exact ci-dessous). Fichier prêt à l'emploi : `.vscode/extensions.json`.

| Extension | Identifiant | Éditeur | Prio. | À quoi elle sert | Comment vérifier qu'elle marche |
|---|---|---|---|---|---|
| Lua | `sumneko.lua` | sumneko | E | Autocomplétion, erreurs en direct, survol de documentation pour Lua | Dans un `.lua`, tape `prin` : `print` est proposé ; une faute de syntaxe est soulignée en rouge |
| Python | `ms-python.python` | Microsoft | E (dès le Python) | Coloration, exécution et débogage de fichiers `.py` (n'inclut pas Python lui-même : voir INSTALLATION.md §19) | Dans un `.py`, le bouton ▶ « Run Python File » apparaît en haut à droite (intitulé anglais) |
| nanos world Lua | `go-horse-studios.nanos-world` | Go Horse Studios (éditeur du jeu) | E (dès E) / U avant | Autocomplétion de l'API Nanos World (classes, événements) | Dans un dossier de package, tape `Console.` : `Log` est proposé |
| French Language Pack | `MS-CEINTL.vscode-language-pack-fr` | Microsoft | U | Interface de VS Code en français | Menus en français après redémarrage |
| Code Spell Checker | `streetsidesoftware.code-spell-checker` | Street Side Software | U | Souligne les fautes dans les commentaires et le Markdown | Écris « bonjoure » dans un commentaire : souligné en bleu |
| French – Code Spell Checker | `streetsidesoftware.code-spell-checker-french` | Street Side Software | U | Dictionnaire français pour l'extension précédente | Les mots français corrects ne sont plus soulignés |
| Error Lens | `usernamehw.errorlens` | usernamehw | U | Affiche le message d'erreur directement au bout de la ligne | Une erreur Lua apparaît en texte coloré à droite de la ligne |
| Git Graph | `mhutchie.git-graph` | mhutchie | U | Historique Git sous forme de graphe, comparaison de versions | Bouton « Git Graph » dans la barre Contrôle de code source |
| Astro | `astro-build.astro-vscode` | Astro | O | Coloration et aide pour les fichiers `.astro` du site | Les fichiers `.astro` sont colorés |
| Claude Code for VS Code | `anthropic.claude-code` | Anthropic | O | Panneau Claude Code intégré à VS Code (VS Code ≥ 1.94) | Icône Claude dans la barre latérale |
| Markdown | *intégré à VS Code* | Microsoft | E | Aperçu du Markdown (`Ctrl+Maj+V`) | L'aperçu s'ouvre |

**Piège à éviter** : il existe une extension communautaire `Derpius.nanosworld`. Ce n'est **pas** celle recommandée par la documentation officielle ; installe `go-horse-studios.nanos-world`.

**Mise en forme / lint** : pour Lua, le formateur intégré à `sumneko.lua` suffit (pas de Prettier/ESLint au parcours A-B ; ils arriveront au parcours D avec JavaScript si besoin).

## 3. Claude Code : ce qui est utile ici

| Fonction | Verdict | Pourquoi |
|---|---|---|
| Fichier `CLAUDE.md` à la racine | ✅ Utile (créé) | Chaque nouvelle session reprend ton profil, les règles et les commandes de build |
| Permissions dans `.claude/settings.json` | ✅ Utile (créé) | Lecture libre ; confirmation demandée pour installer, supprimer, réseau, `git push` |
| Extension VS Code `anthropic.claude-code` | ✅ Utile si tu as un abonnement | Plus confortable que le terminal pour un débutant |
| Reprise de session (`claude --continue`, `/resume`) | ✅ Utile | Reprendre une longue tâche après interruption |
| Commandes slash personnalisées | ➖ Plus tard | Utile quand tu auras des routines (ex. « vérifie mes exercices ») |
| Sous-agents, hooks, skills, plugins | ❌ Inutile pour l'instant | Complexité sans bénéfice pour un débutant |
| Serveurs MCP | ❌ Pas maintenant | Aucun n'est nécessaire ; n'installe que des MCP officiels, après vérification de l'éditeur et des permissions |

## 4. Outils pour ne pas décrocher (3 seulement)

| Outil | Rôle | Coût | Source |
|---|---|---|---|
| **Mode concentration + minuteur du site** (15/25/45 min) | Masque le menu et lance un minuteur de séance | Gratuit, intégré | Ce site |
| **Sessions de concentration de Windows 11** (application Horloge) | Active « Ne pas déranger » et un minuteur pendant la séance | Gratuit, intégré à Windows 11 | https://support.microsoft.com/windows/how-to-use-focus-in-windows-11-cbcc9ddb-8164-43fa-8919-b9a2af072382 |
| **Anki** (révision espacée) | Cartes mémoire pour le vocabulaire (Lua, Git, SQL) | Gratuit sur Windows | https://apps.ankiweb.net |

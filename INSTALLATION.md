# Installer mon environnement (portable 💻 et PC fixe 🖥️)

> **Statut** : toutes les commandes ci-dessous viennent de sources officielles vérifiées le **6 octobre 2026** (liste dans `SOURCES.md`).
> ⚠️ **Elles n'ont pas été testées sur Windows** : je travaille dans un conteneur Linux, pas sur tes machines. Si une étape ne correspond pas à ce que tu vois, note-le dans ton journal de bord et regarde la section « Erreurs fréquentes » de l'outil, puis la page Dépannage du site.
>
> Règles de sécurité qui valent pour tout ce document :
> - Tu n'installes **que depuis les sources officielles** indiquées.
> - Tu ne tapes **jamais ton mot de passe GitHub** dans le terminal et tu n'écris **jamais de jeton** (token) dans un fichier.
> - Le portable reste **léger** : pas d'Unreal, pas de client du jeu.

---

## Sommaire

0. [Avant de commencer : ordre conseillé](#0-avant-de-commencer--ordre-conseillé)
1. [Windows Terminal et PowerShell](#1-windows-terminal-et-powershell) 💻🖥️
2. [winget, l'installeur en ligne de commande](#2-winget-linstalleur-en-ligne-de-commande) 💻🖥️
3. [VS Code](#3-vs-code) 💻🖥️
4. [Git pour Windows](#4-git-pour-windows) 💻🖥️
5. [Ton identité Git et l'adresse e-mail « noreply »](#5-ton-identité-git-et-ladresse-e-mail--noreply-) 💻🖥️
6. [Se connecter à GitHub sans mot de passe dans le terminal](#6-se-connecter-à-github-sans-mot-de-passe-dans-le-terminal) 💻🖥️
7. [Extensions VS Code et réglages](#7-extensions-vs-code-et-réglages) 💻🖥️
8. [Lua 5.4 en local](#8-lua-54-en-local) 💻🖥️
9. [Node.js LTS](#9-nodejs-lts) 💻 (🖥️ utile)
10. [Ton dépôt d'apprentissage et la synchronisation des deux machines](#10-ton-dépôt-dapprentissage-et-la-synchronisation-des-deux-machines) 💻🖥️
11. [Lancer et publier le site du cours](#11-lancer-et-publier-le-site-du-cours) 💻
12. [Claude Code (optionnel)](#12-claude-code-optionnel) 💻🖥️
13. [Steam et Nanos World](#13-steam-et-nanos-world) 🖥️
14. [Serveur dédié Nanos World](#14-serveur-dédié-nanos-world) 🖥️ (💻 possible)
15. [Unreal Engine 5.7 avec 16 Go de RAM](#15-unreal-engine-57-avec-16-go-de-ram) 🖥️ uniquement
16. [Blender (optionnel)](#16-blender-optionnel) 🖥️
17. [Discord (recommandé)](#17-discord-recommandé) 💻🖥️
18. [Récapitulatif par machine](#18-récapitulatif-par-machine)
19. [Python 3.13 et SQLite (cours de Python, parcours D)](#19-python-313-et-sqlite-cours-de-python-parcours-d) 💻🖥️

---

## 0. Avant de commencer : ordre conseillé

| Ordre | Outil | Quand | Portable 💻 | PC fixe 🖥️ |
|---|---|---|---|---|
| 1 | Windows Terminal / PowerShell | **Tout de suite** | ✅ | ✅ |
| 2 | winget | **Tout de suite** | ✅ | ✅ |
| 3 | VS Code | **Tout de suite** | ✅ | ✅ |
| 4 | Git pour Windows | **Tout de suite** | ✅ | ✅ |
| 5 | Identité Git + e-mail noreply | **Tout de suite** | ✅ | ✅ |
| 6 | Connexion GitHub | **Tout de suite** | ✅ | ✅ |
| 7 | Extensions VS Code | **Tout de suite** | ✅ | ✅ |
| 8 | Lua 5.4 | Avant le module A5 | ✅ | ✅ |
| 9 | Node.js LTS | Avant de lancer le site en local | ✅ | utile |
| 9 bis | Python 3.13 (section 19) | **Dès que ton cours de Python commence** (module D1) | ✅ | ✅ |
| 10 | Dépôt + synchronisation | Module A4 | ✅ | ✅ |
| 12 | Claude Code | Optionnel, quand tu veux | optionnel | optionnel |
| 13-15 | Steam, Nanos World, serveur, Unreal | **Quand ton accès Nanos World est ouvert** (parcours E/F) | serveur seulement | ✅ |
| 16-17 | Blender, Discord | Optionnel | Discord | ✅ |

**Pourquoi VS Code avant Git ?** Parce que l'installeur de Git te demande quel éditeur utiliser : si VS Code est déjà là, tu peux le choisir directement.

**Durée totale** : environ 1 h 30 pour le portable (étapes 1 à 11), 45 min pour le PC fixe (étapes 1 à 10), sans compter Unreal (téléchargement long).

---

## 1. Windows Terminal et PowerShell

- **À quoi ça sert** : une fenêtre où tu donnes des ordres à l'ordinateur en tapant du texte (au lieu de cliquer).
- **Priorité** : essentiel · **Coût** : gratuit · **Source** : https://learn.microsoft.com/windows/terminal/install
- **Installation** : rien à faire, Windows Terminal est inclus dans Windows 11. S'il manquait : `winget install --id Microsoft.WindowsTerminal -e` (non testée sur Windows).

### 1.1 Ouvrir le terminal
1. Appuie sur la touche **Windows**, tape `terminal`, puis appuie sur **Entrée**.
2. Une fenêtre s'ouvre avec un onglet **Windows PowerShell** (ou **PowerShell**).
3. Autre méthode : clic droit sur le bouton **Démarrer** → **Terminal**.

### 1.2 Lire ce qui s'affiche
Tu vois une ligne comme :

```text
PS C:\Users\TonNom>
```

- `PS` : tu es dans **PowerShell** (si tu ne vois pas `PS`, tu es dans l'ancienne « invite de commandes » CMD : ouvre un nouvel onglet PowerShell avec la flèche `˅` en haut).
- `C:\Users\TonNom` : le **dossier courant**, c'est-à-dire l'endroit où tu te trouves.
- `>` : le terminal attend ta commande.

Tu tapes une commande, tu appuies sur **Entrée**, la réponse s'affiche en dessous, puis une nouvelle invite `PS ...>` réapparaît : c'est le signe que la commande est **terminée**.

### 1.3 Les cinq commandes de base
| Commande | Ce qu'elle fait | Exemple |
|---|---|---|
| `pwd` | Affiche le dossier courant | `pwd` |
| `dir` (ou `ls`) | Liste le contenu du dossier | `dir` |
| `cd` | Change de dossier | `cd Documents` · `cd ..` (remonter d'un niveau) · `cd ~` (revenir à ton dossier personnel) |
| `mkdir` | Crée un dossier | `mkdir Dev` |
| `cls` | Efface l'écran | `cls` |

### 1.4 Astuces qui font gagner du temps
- **Tab** complète automatiquement un nom de dossier : tape `cd Doc` puis **Tab**.
- **Flèche du haut** : rappelle la commande précédente.
- **Copier-coller** : sélectionne le texte puis `Ctrl+C` / `Ctrl+V` (ou clic droit).
- **Ctrl+C** pendant qu'une commande tourne : l'arrête.

### 1.5 Vérifier que ça marche
```powershell
pwd
```
Résultat attendu : le chemin de ton dossier personnel, par exemple `C:\Users\TonNom`.

### 1.6 Erreurs fréquentes
| Message | Cause | Solution |
|---|---|---|
| `... n'est pas reconnu en tant que nom d'applet de commande...` (ou `... is not recognized as the name of a cmdlet...`) | Faute de frappe, ou programme pas installé / pas encore dans le PATH | Vérifie l'orthographe ; si tu viens d'installer le programme, **ferme et rouvre le terminal** |
| `Impossible de trouver le chemin d'accès...` (`Cannot find path...`) | Le dossier n'existe pas à cet endroit | `dir` pour voir les dossiers présents, puis réessaie |
| `... cannot be loaded because running scripts is disabled on this system` | La **politique d'exécution** de PowerShell bloque les scripts (cas fréquent avec `npm`) | Voir 9.4 |

### 1.7 Désinstaller / risques
Rien à désinstaller (composant de Windows). Risque : une commande tapée est exécutée telle quelle ; **ne colle jamais une commande trouvée au hasard** sur Internet sans comprendre ce qu'elle fait.

---

## 2. winget, l'installeur en ligne de commande

- **À quoi ça sert** : installer des logiciels **officiels** en une commande, au lieu de chercher le bon site de téléchargement.
- **Priorité** : essentiel · **Coût** : gratuit · **Source** : https://learn.microsoft.com/windows/package-manager/winget/
- D'après Microsoft, winget est disponible sur Windows 11 dans le composant **App Installer** (Programme d'installation d'application).

### 2.1 Vérifier qu'il est présent (non testée sur Windows)
```powershell
winget --version
```
Résultat attendu : un numéro de version, par exemple `v1.x.xxxx`.

### 2.2 Comment lire une commande winget
```powershell
winget install --id Git.Git -e --source winget
```
- `install` : installer.
- `--id Git.Git` : l'**identifiant exact** du paquet (vérifié dans le dépôt officiel `microsoft/winget-pkgs`).
- `-e` (ou `--exact`) : correspondance exacte, pour ne pas installer un paquet au nom proche.
- `--source winget` : chercher uniquement dans le catalogue officiel winget.

La première fois, winget peut te demander d'**accepter les conditions des sources** : tape `Y` puis **Entrée**. Windows peut aussi afficher une fenêtre **Contrôle de compte d'utilisateur** (« Voulez-vous autoriser cette application à apporter des modifications ? ») : vérifie que l'éditeur est le bon, puis clique sur **Oui**.

### 2.3 Erreurs fréquentes
| Problème | Solution |
|---|---|
| `winget` n'est pas reconnu | Installe ou mets à jour **App Installer** depuis le Microsoft Store : https://apps.microsoft.com/detail/9nblggh4nns1 |
| `No package found matching input criteria.` | Vérifie l'identifiant (majuscules comprises avec `-e`) |
| Le programme installé n'est pas reconnu juste après | Ferme et rouvre le terminal (le PATH est relu à l'ouverture) |

### 2.4 Désinstaller un logiciel installé avec winget
```powershell
winget uninstall --id Identifiant.DuPaquet -e
```
Ou par l'interface : **Paramètres** → **Applications** → **Applications installées** → `...` → **Désinstaller**.

---

## 3. VS Code

- **À quoi ça sert** : l'éditeur dans lequel tu écris ton code, avec coloration, aide et terminal intégré.
- **Priorité** : essentiel · **Coût** : gratuit · **Source** : https://code.visualstudio.com/
- Tu as peut-être déjà VS Code sur une machine : commence par vérifier (3.1).

### 3.1 Vérifier s'il est déjà installé
```powershell
code --version
```
- Trois lignes (version, identifiant, `x64`) : VS Code est installé, passe à 3.4.
- `code ... n'est pas reconnu` : installe-le (3.2 ou 3.3).

### 3.2 Installation avec winget (non testée sur Windows)
```powershell
winget install --id Microsoft.VisualStudioCode -e --source winget
```

### 3.3 Installation manuelle (alternative)
1. Va sur https://code.visualstudio.com/ et télécharge la version **Windows** « **User setup** » (installation pour ton compte, sans droits administrateur, recommandée par la doc officielle).
2. Lance le fichier téléchargé, accepte la licence, garde le dossier proposé.
3. À l'écran des **tâches supplémentaires**, coche :
   - **Ajouter l'action « Ouvrir avec Code » au menu contextuel des fichiers** et **des répertoires** (pratique) ;
   - **Ajouter à PATH** (cochée par défaut : indispensable pour la commande `code`).
4. Termine l'installation puis **ferme et rouvre le terminal**.

### 3.4 Vérifier que ça marche
```powershell
code --version
```
Puis ouvre un dossier dans VS Code depuis le terminal :
```powershell
cd ~
code .
```
VS Code s'ouvre sur ton dossier personnel. Il peut te demander **« Faites-vous confiance aux auteurs des fichiers de ce dossier ? »** : pour **tes** dossiers, réponds oui.

### 3.5 Le terminal intégré
Menu **Terminal** → **Nouveau terminal** (en anglais : **Terminal → New Terminal**). Un panneau PowerShell s'ouvre en bas de VS Code, déjà placé dans le dossier ouvert. C'est là que tu taperas la plupart de tes commandes.

### 3.6 Settings Sync : la même configuration sur les deux machines
D'après la documentation officielle de VS Code :
1. Clique sur la **roue dentée** (en bas à gauche) → **Backup and Sync Settings...** (l’intitulé est traduit si tu as installé le pack de langue français).
2. Clique sur **Sign in** et choisis **GitHub** (ou un compte Microsoft).
3. Connecte-toi dans le navigateur qui s'ouvre, puis reviens dans VS Code.
4. Fais la même chose sur l'autre machine avec **le même compte** : tes réglages, raccourcis et extensions arrivent automatiquement.

Si VS Code signale un **conflit** à la première synchronisation, choisis de garder la version de la machine que tu as configurée en premier.

### 3.7 Erreurs fréquentes
| Problème | Solution |
|---|---|
| `code` n'est pas reconnu après installation | Ferme et rouvre le terminal ; sinon réinstalle en vérifiant que **Ajouter à PATH** est coché |
| Les mises à jour ne s'installent pas | Ne lance pas VS Code « en tant qu'administrateur » avec l'installation User setup |

### 3.8 Désinstaller
```powershell
winget uninstall --id Microsoft.VisualStudioCode -e
```
Tes réglages restent dans `%APPDATA%\Code` et tes extensions dans `%USERPROFILE%\.vscode` : supprime ces dossiers seulement si tu veux tout effacer.

---

## 4. Git pour Windows

- **À quoi ça sert** : enregistrer l'historique de ton code (chaque version) et l'échanger avec GitHub.
- **Priorité** : essentiel · **Coût** : gratuit (GPL-2.0) · **Source** : https://gitforwindows.org/
- Il installe aussi **Git Credential Manager** (connexion à GitHub par le navigateur) et **Git Bash**.

### 4.1 Vérifier s'il est déjà installé
```powershell
git --version
```
Si tu vois `git version 2.xx.x.windows.x`, Git est là : passe à 4.4.

### 4.2 Installation avec winget (non testée sur Windows)
```powershell
winget install --id Git.Git -e --source winget
```
L'installation par winget est **silencieuse** : elle garde les options par défaut. Tu corriges ensuite deux réglages avec les commandes de 4.4 (éditeur et nom de branche).

### 4.3 Installation manuelle avec l'installeur (alternative, plus pédagogique)
Télécharge l'installeur sur https://gitforwindows.org/ puis lance-le. Les écrans sont en anglais ; voici les choix conseillés (intitulés exacts de l'installeur officiel) :

| Écran | Choix conseillé | Pourquoi |
|---|---|---|
| *Select Components* | Laisse les cases par défaut ; « Add a Git Bash Profile to Windows Terminal » peut être coché | Défauts sûrs |
| **Choosing the default editor used by Git** | **Use Visual Studio Code as Git's default editor** | Vim (par défaut) est difficile pour un débutant |
| **Adjusting the name of the initial branch in new repositories** | **Override the default branch name for new repositories** → `main` | GitHub utilise `main` |
| **Adjusting your PATH environment** | **Git from the command line and also from 3rd-party software** (recommandé) | Pour utiliser `git` dans PowerShell et VS Code |
| *Choosing the SSH executable* | **Use bundled OpenSSH** | Défaut |
| *Choosing HTTPS transport backend* | Garde le choix par défaut | Défaut |
| **Configuring the line ending conversions** | **Checkout Windows-style, commit Unix-style line endings** | Évite les conflits de fins de ligne |
| *Configuring the terminal emulator to use with Git Bash* | **Use MinTTY** (défaut) | Défaut |
| *Choose the default behavior of `git pull`* | Garde le choix par défaut | Défaut |
| **Choose a credential helper** | **Git Credential Manager** | Connexion à GitHub par le navigateur |
| *Configuring extra options* | **Enable file system caching** (défaut) | Défaut |
| *Configuring experimental options* | Ne coche rien | Stabilité |

### 4.4 Réglages à faire après l'installation (non testées sur Windows)
Ouvre un **nouveau** terminal, puis :
```powershell
git config --global core.editor "code --wait"
git config --global init.defaultBranch main
git config --global core.autocrlf true
```
- `core.editor "code --wait"` : Git ouvrira VS Code quand il a besoin d'un texte (message de commit long).
- `init.defaultBranch main` : tes nouveaux dépôts commenceront sur la branche `main`.
- `core.autocrlf true` : conversion automatique des fins de ligne Windows ↔ Unix (réglage recommandé par GitHub pour Windows).

### 4.5 Vérifier que ça marche
```powershell
git --version
git config --global --list
```
Résultat attendu : la version, puis une liste qui contient `core.editor=code --wait`, `init.defaultbranch=main`, `core.autocrlf=true`.

### 4.6 Erreurs fréquentes
| Problème | Solution |
|---|---|
| `git` n'est pas reconnu | Ferme et rouvre le terminal. Sinon, réinstalle en choisissant « Git from the command line and also from 3rd-party software » |
| Un éditeur étrange (Vim) s'ouvre pendant un commit | Tape `Échap`, puis `:q!` et **Entrée** pour en sortir ; puis applique 4.4 |
| `warning: in the working copy of '...', LF will be replaced by CRLF` | Simple avertissement de fin de ligne, pas une erreur |

### 4.7 Désinstaller
```powershell
winget uninstall --id Git.Git -e
```

---

## 5. Ton identité Git et l'adresse e-mail « noreply »

Chaque **commit** (enregistrement) porte un nom et une adresse e-mail, **visibles publiquement** sur GitHub. Pour ne pas exposer ta vraie adresse, GitHub fournit une adresse **noreply**.

### 5.1 Trouver ton adresse noreply sur GitHub
1. Connecte-toi sur https://github.com.
2. Clique sur ta **photo de profil** (en haut à droite) → **Settings**.
3. Dans le menu de gauche, section **Access**, clique sur **Emails**.
4. Coche **Keep my email addresses private** (« garder mes adresses e-mail privées »).
5. Coche aussi **Block command line pushes that expose my email** (GitHub refusera un `push` qui contiendrait ta vraie adresse).
6. Sous la case « Keep my email addresses private », GitHub affiche ton adresse noreply. D'après la documentation officielle, pour un compte créé après le 18 juillet 2017 elle a la forme :
   ```text
   ID+PSEUDO@users.noreply.github.com
   ```
   (`ID` est un nombre, `PSEUDO` ton nom d'utilisateur). **Copie-la exactement.**

### 5.2 Configurer Git (sur chaque machine, non testé sur Windows)
```powershell
git config --global user.name "TonPseudo"
git config --global user.email "ID+PSEUDO@users.noreply.github.com"
```
Remplace par **ton** pseudo et **ton** adresse noreply copiée à l'étape précédente.

### 5.3 Vérifier
```powershell
git config --global user.name
git config --global user.email
```
Résultat attendu : ton pseudo, puis ton adresse noreply.

### 5.4 Erreurs fréquentes
| Message | Cause | Solution |
|---|---|---|
| `Author identity unknown` / `Please tell me who you are.` | Identité pas configurée | Fais 5.2 |
| `GH007: Your push would publish a private email address.` | Un commit contient ta vraie adresse et la protection 5.1 (étape 5) est active | Configure l'adresse noreply (5.2), puis corrige le dernier commit avec `git commit --amend --reset-author --no-edit` avant de refaire `git push` |

---

## 6. Se connecter à GitHub sans mot de passe dans le terminal

**Méthode recommandée : Git Credential Manager (GCM)**, inclus dans Git pour Windows. La documentation de GitHub recommande GCM ou GitHub CLI pour les connexions HTTPS.

### 6.1 Comment ça se passe (non testé sur Windows)
1. La **première fois** que tu fais un `git clone` d'un dépôt privé, un `git push` ou un `git pull` vers GitHub, une fenêtre **Connect to GitHub** s'ouvre.
2. Choisis **Sign in with your browser** (« se connecter avec le navigateur »).
3. Ton navigateur s'ouvre sur github.com : connecte-toi (avec la double authentification si tu l'as activée), puis clique sur **Authorize** (autoriser) pour Git Credential Manager.
4. Reviens au terminal : la commande continue. Windows garde la connexion dans le **Gestionnaire d'identification** ; tu n'auras plus à te connecter sur cette machine.

À aucun moment tu ne tapes ton mot de passe dans le terminal, et aucun jeton n'est écrit dans un fichier.

### 6.2 Si la connexion est refusée ou bloquée
D'après la documentation de GitHub : ouvre le **Panneau de configuration** → **Comptes d'utilisateurs** → **Gestionnaire d'identification** → **Informations d'identification Windows**, trouve l'entrée **git:https://github.com**, supprime-la, puis refais ta commande : la fenêtre de connexion réapparaît.

### 6.3 Alternative : GitHub CLI (optionnel)
```powershell
winget install --id GitHub.cli -e --source winget
gh auth login
```
Réponds : **GitHub.com** → protocole **HTTPS** → **Y** (authentifier Git avec tes identifiants GitHub) → **Login with a web browser**, puis suis les instructions (un code à 8 caractères s'affiche, à saisir dans le navigateur).

### 6.4 SSH (optionnel, plus tard)
SSH remplace la connexion par navigateur par une **paire de clés** : une clé privée qui reste sur ta machine et une clé publique que tu déposes sur GitHub. C'est fiable mais plus long à configurer : inutile au début. La procédure officielle est ici : https://docs.github.com/authentication/connecting-to-github-with-ssh

---

## 7. Extensions VS Code et réglages

Les identifiants ont été vérifiés sur le Visual Studio Marketplace. Installe-les depuis VS Code : icône **Extensions** (quatre carrés, ou `Ctrl+Maj+X`), recherche l'identifiant, vérifie l'**éditeur** affiché sous le nom, puis **Install**.

Tu peux aussi les installer en ligne de commande (non testé sur Windows) :
```powershell
code --install-extension sumneko.lua
code --install-extension ms-python.python
code --install-extension go-horse-studios.nanos-world
code --install-extension MS-CEINTL.vscode-language-pack-fr
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension streetsidesoftware.code-spell-checker-french
code --install-extension usernamehw.errorlens
code --install-extension mhutchie.git-graph
```

| Extension | Identifiant | Prio. | Vérifier qu'elle marche | Si elle ne marche pas |
|---|---|---|---|---|
| Lua (sumneko) | `sumneko.lua` | Essentielle | Dans un fichier `.lua`, tape `prin` : `print` est proposé | Vérifie que le fichier finit par `.lua` ; redémarre VS Code |
| Python (Microsoft) | `ms-python.python` | Essentielle dès que tu fais du Python | Dans un fichier `.py`, un bouton ▶ « Run Python File » apparaît en haut à droite (intitulé anglais, non vu en français) | L'extension n'inclut **pas** Python lui-même : installe-le d'abord (section 19) puis choisis l'interpréteur avec `Ctrl+Maj+P` → **Python: Select Interpreter** |
| nanos world Lua | `go-horse-studios.nanos-world` | Essentielle au parcours E | Dans un package, tape `Console.` : `Log` est proposé | Elle télécharge l'API au démarrage : il faut Internet |
| French Language Pack | `MS-CEINTL.vscode-language-pack-fr` | Utile | Après redémarrage, les menus sont en français | `Ctrl+Maj+P` → **Configure Display Language** → `fr` |
| Code Spell Checker + French | `streetsidesoftware.code-spell-checker` + `streetsidesoftware.code-spell-checker-french` | Utile | Une faute dans un commentaire est soulignée | Ajoute `"cSpell.language": "fr,en"` dans les réglages |
| Error Lens | `usernamehw.errorlens` | Utile | Le message d'erreur s'affiche au bout de la ligne fautive | Il faut que l'extension Lua détecte l'erreur |
| Git Graph | `mhutchie.git-graph` | Utile | Commande `Git Graph: View Git Graph` (`Ctrl+Maj+P`) | Ouvre un dossier qui est un dépôt Git |

⚠️ N'installe pas l'extension communautaire `Derpius.nanosworld` : la doc officielle recommande `go-horse-studios.nanos-world`.

### 7.1 Réglages recommandés
Le dépôt du cours contient `.vscode/settings.json` (réglages du projet) et `.vscode/extensions.json` (VS Code te propose d'installer les extensions recommandées à l'ouverture du dossier). Pour tes réglages personnels : `Ctrl+Maj+P` → **Preferences: Open User Settings (JSON)**, puis par exemple :

```json
{
  "workbench.colorTheme": "Default Dark Modern",
  "editor.fontSize": 16,
  "editor.wordWrap": "on",
  "editor.renderWhitespace": "boundary",
  "files.autoSave": "afterDelay",
  "files.eol": "\n",
  "terminal.integrated.fontSize": 15,
  "cSpell.language": "fr,en"
}
```
- `editor.fontSize` : taille du texte (augmente si tu fatigues).
- `files.autoSave` : sauvegarde automatique (évite d'exécuter une ancienne version).
- `files.eol` : fins de ligne Unix, cohérentes avec Git.

---

## 8. Lua 5.4 en local

- **À quoi ça sert** : exécuter tes scripts Lua sur ta machine, **dans la même version que Nanos World (Lua 5.4)**.
- **Priorité** : essentiel (parcours A5 à D) · **Coût** : gratuit (MIT)
- **Options comparées** :

| Option | Version | Verdict |
|---|---|---|
| **`DEVCOM.Lua` via winget** | 5.4.6 | ✅ **Choisie** : une commande, version 5.4 comme Nanos World, installe aussi LuaRocks |
| LuaBinaries (SourceForge) | 5.4.x | Possible, mais installation manuelle (dézipper, modifier le PATH) |
| Lua for Windows | 5.1 | ❌ Trop ancienne (Nanos World utilise 5.4) |

Source du paquet : https://github.com/DevelopersCommunity/cmake-lua (projet communautaire qui compile Lua officiel et le publie sur winget ; ce n'est pas lua.org lui-même).

### 8.1 Installation (non testée sur Windows)
```powershell
winget install --id DEVCOM.Lua -e --source winget
```
Puis **ferme et rouvre le terminal**.

### 8.2 Vérifier
```powershell
lua -v
```
Résultat attendu (Lua 5.4.6) :
```text
Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio
```

### 8.3 Premier test
```powershell
lua -e "print('Bonjour depuis Lua ' .. _VERSION)"
```
Résultat attendu : `Bonjour depuis Lua Lua 5.4`.

### 8.4 Erreurs fréquentes
| Problème | Solution |
|---|---|
| `lua` n'est pas reconnu | Ferme et rouvre le terminal. Vérifie l'installation avec `winget list --id DEVCOM.Lua`. Si le paquet est listé mais `lua` reste introuvable, cherche l'exécutable : `Get-ChildItem -Path "C:\Program Files" -Filter lua.exe -Recurse -ErrorAction SilentlyContinue` et note le dossier trouvé dans ton journal (on l'ajoutera au PATH ensemble, voir Dépannage) |
| `lua: cannot open fichier.lua` | Tu n'es pas dans le bon dossier : `dir` pour vérifier que le fichier est là |

### 8.5 Désinstaller
```powershell
winget uninstall --id DEVCOM.Lua -e
```

---

## 9. Node.js LTS

- **À quoi ça sert** : faire tourner les outils qui **construisent le site du cours** (Astro) sur ta machine.
- **Priorité** : essentiel sur le portable, utile sur le PC fixe · **Coût** : gratuit · **Source** : https://nodejs.org/
- Version : la ligne **LTS active est Node.js 24** (vérifié sur nodejs.org le 6 octobre 2026).

### 9.1 Installation (non testée sur Windows)
```powershell
winget install --id OpenJS.NodeJS.LTS -e --source winget
```
Puis ferme et rouvre le terminal.

### 9.2 Vérifier
```powershell
node --version
npm --version
```
Résultat attendu : `v24.x.x` puis un numéro de version de npm.

### 9.3 Erreurs fréquentes
| Message | Solution |
|---|---|
| `node` n'est pas reconnu | Ferme et rouvre le terminal |
| `npm.ps1 cannot be loaded because running scripts is disabled on this system` | Voir 9.4 |
| `EBADENGINE` ou erreurs de version pendant `npm install` | Vérifie que `node --version` affiche bien v24 (ou au moins v22) |

### 9.4 La politique d'exécution PowerShell
Par défaut, sur un Windows « client », la politique d'exécution de PowerShell est **Restricted** : aucun script `.ps1` ne peut tourner, y compris `npm.ps1`. La documentation de Microsoft donne cette commande pour autoriser les scripts locaux et les scripts signés téléchargés, **pour ton compte uniquement** :
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Réponds `O` (Oui) si PowerShell demande confirmation. Vérifie avec :
```powershell
Get-ExecutionPolicy -List
```
La ligne `CurrentUser` doit afficher `RemoteSigned`. Risque : faible (seuls tes scripts locaux et les scripts signés sont autorisés).

### 9.5 Désinstaller
```powershell
winget uninstall --id OpenJS.NodeJS.LTS -e
```

---

## 10. Ton dépôt d'apprentissage et la synchronisation des deux machines

**Principe** : ton travail (exercices, notes, fichier de progression) vit dans **un dépôt GitHub**. Sur une machine tu fais `git push` (envoyer), sur l'autre `git pull` (récupérer). C'est aussi ton premier entraînement Git.

### 10.1 Créer le dépôt sur GitHub (une seule fois)
1. Sur https://github.com, clique sur **+** (en haut à droite) → **New repository**.
2. **Repository name** : `mon-apprentissage`.
3. Visibilité : **Private** (tes brouillons) ou **Public** (pour montrer ta progression). Tu pourras changer plus tard.
4. Coche **Add a README file**.
5. Clique sur **Create repository**.
6. Clique sur le bouton vert **Code**, onglet **HTTPS**, et copie l'adresse (forme `https://github.com/TonPseudo/mon-apprentissage.git`).

### 10.2 Le cloner sur le portable 💻 (non testé sur Windows)
```powershell
cd ~
mkdir Dev
cd Dev
git clone https://github.com/TonPseudo/mon-apprentissage.git
cd mon-apprentissage
code .
```
Si le dépôt est privé, la fenêtre de connexion GitHub de l'étape 6 s'ouvre.

### 10.3 Premier commit et premier push
1. Dans VS Code, crée un fichier `journal.md` contenant : `# Mon journal` puis une ligne `- Jour 1 : j'ai installé mes outils sur le portable.`
2. Dans le terminal intégré :
```powershell
git status
git add journal.md
git commit -m "Ajoute mon journal de bord"
git push
```
- `git status` : montre `journal.md` en rouge sous **Untracked files** (fichier non suivi).
- `git add` : le prépare pour le prochain commit.
- `git commit -m "..."` : crée une version avec un message clair.
- `git push` : l'envoie sur GitHub.
3. Recharge la page du dépôt sur GitHub : `journal.md` est là. **Première mini-victoire !**

### 10.4 Le récupérer sur le PC fixe 🖥️
Sur le PC fixe (après les étapes 1 à 7) :
```powershell
cd ~
mkdir Dev
cd Dev
git clone https://github.com/TonPseudo/mon-apprentissage.git
cd mon-apprentissage
```
`journal.md` est présent. Ajoute une ligne `- Jour 1 : PC fixe prêt.`, puis :
```powershell
git add journal.md
git commit -m "Note l'installation du PC fixe"
git push
```

### 10.5 Le test de synchronisation (aller-retour)
Retourne sur le portable :
```powershell
cd ~\Dev\mon-apprentissage
git pull
```
La ligne écrite sur le PC fixe apparaît dans `journal.md`. **Tes deux machines sont synchronisées.**

**La règle d'or** : *en t'asseyant devant une machine → `git pull` ; avant de te lever → `git add`, `git commit`, `git push`.*

### 10.6 Erreurs fréquentes de synchronisation
| Ce que tu vois | Ce qui s'est passé | Solution |
|---|---|---|
| `! [rejected] main -> main (fetch first)` et `Updates were rejected because the remote contains work that you do not have locally` | Tu as oublié de faire `git pull` avant de travailler | `git pull`, puis à nouveau `git push` |
| `CONFLICT (content): Merge conflict in journal.md` | La même ligne a été modifiée sur les deux machines | Ouvre le fichier dans VS Code : garde la bonne version (boutons **Accept Current / Incoming / Both**), enregistre, puis `git add journal.md`, `git commit -m "Résout le conflit du journal"` et `git push` |
| `Untracked files:` dans `git status`, et le fichier n'arrive pas sur l'autre machine | Le fichier n'a jamais été ajouté | `git add nom-du-fichier`, `git commit`, `git push` |
| `Your branch is ahead of 'origin/main' by 1 commit.` | Tu as commité mais pas poussé | `git push` |
| `fatal: not a git repository` | Tu n'es pas dans le dossier du dépôt | `cd ~\Dev\mon-apprentissage` |

---

## 11. Lancer et publier le site du cours

### 11.1 Le lancer en local 💻 (non testé sur Windows)
```powershell
cd ~\Dev
git clone https://github.com/Xerad4067/CoursClaude.git
cd CoursClaude
npm install
npm run dev
```
Ouvre l'adresse affichée (par exemple `http://localhost:4321/CoursClaude/`) dans ton navigateur. `Ctrl+C` dans le terminal arrête le site.

Pour la **version complète avec la recherche** :
```powershell
npm run build
npm run preview
```

### 11.2 Le publier sur GitHub Pages (une seule fois)
D'après la documentation d'Astro et de GitHub :
1. Le dépôt doit être **public** (GitHub Pages est gratuit pour les dépôts publics avec GitHub Free).
2. Sur GitHub, ouvre le dépôt → onglet **Settings** → section **Pages**.
3. Dans **Source**, choisis **GitHub Actions**.
4. À chaque `push` sur la branche `main`, le fichier `.github/workflows/deploy.yml` reconstruit et publie le site à l'adresse `https://xerad4067.github.io/CoursClaude/`.

### 11.3 Exécuter les tests des exercices Lua
```powershell
lua exercices/tester.lua
```
Résultat attendu : une ligne `OK` par exercice et un bilan final sans échec.

---

## 12. Claude Code (optionnel)

- **À quoi ça sert** : un assistant de programmation qui lit ton projet, explique, propose et modifie du code avec ta permission.
- **Priorité** : optionnel · **Coût** : **abonnement payant requis** (Pro, Max, Team, Enterprise) ou compte Console ; le plan gratuit de claude.ai n'inclut pas Claude Code · **Source** : https://code.claude.com/docs/en/setup
- **Prérequis** (doc officielle) : Windows 10 1809+ ou Windows 11, 4 Go de RAM, connexion Internet. Git pour Windows est recommandé (il fournit Git Bash).

### 12.1 Installation (non testée sur Windows)
Méthode native recommandée, dans **PowerShell** (pas besoin d'être administrateur) :
```powershell
irm https://claude.ai/install.ps1 | iex
```
Ou avec winget (pas de mise à jour automatique : `winget upgrade Anthropic.ClaudeCode` de temps en temps) :
```powershell
winget install Anthropic.ClaudeCode
```

### 12.2 Vérifier
Ouvre un **nouveau** terminal :
```powershell
claude --version
claude doctor
```
Puis, dans le dossier du projet : `claude`. Au premier lancement, la connexion se fait **dans le navigateur**.

### 12.3 Bien l'utiliser pour ce cours
- Le fichier `CLAUDE.md` à la racine du dépôt lui donne le contexte (ton profil, les règles, les commandes).
- Le fichier `.claude/settings.json` définit des permissions raisonnables (il demande avant `git push`, les installations et les suppressions).
- **Reprendre une session** : `claude -c` (dernière conversation du dossier) ou `claude --resume` (choisir dans une liste).
- Extension VS Code officielle : `anthropic.claude-code` (VS Code 1.94 ou plus récent).
- Règle pédagogique : demande-lui des **indices et des explications**, pas la solution (prompts modèles dans le module A5).

### 12.4 Désinstaller
Installation native (PowerShell) :
```powershell
Remove-Item -Path "$env:USERPROFILE\.local\bin\claude.exe" -Force
Remove-Item -Path "$env:USERPROFILE\.local\share\claude" -Recurse -Force
```
Installation winget : `winget uninstall Anthropic.ClaudeCode`.

---

## 13. Steam et Nanos World

🖥️ **PC fixe uniquement.** ⏳ **Quand ton accès est ouvert.**

### 13.1 L'accès (vérifié dans la doc officielle le 06/10/2026)
- Nanos World est en **Closed Testing** : il faut candidater via le formulaire https://tester.nanos-world.com (réponses **en anglais**, écrites par toi : les réponses générées par une IA sont rejetées).
- Être actif sur le Discord officiel augmente les chances d'être sélectionné. On peut recandidater après un mois.
- Une fois sélectionné, ta **clé Steam** apparaît dans ton compte sur nanos-world.com (rubrique *redeem*). Il peut s'agir d'une clé **Playtest** ou **Beta** : les deux donnent le même jeu, mais un joueur ne peut rejoindre qu'un serveur lancé avec la même application.
- Des **playtests publics** ont lieu sans candidature, via la page Steam. Le blog officiel annonce un **playtest public d'Halloween du 30 octobre au 1er novembre 2026**.

### 13.2 Installer Steam (non testé sur Windows)
```powershell
winget install --id Valve.Steam -e --source winget
```
Puis lance Steam et connecte-toi.

### 13.3 Installer le jeu
- Avec une clé : Steam → **Jeux** → **Activer un produit sur Steam...** → colle la clé.
- Pour un playtest public : page Steam du jeu https://store.steampowered.com/app/1841660/nanos_world/ → bouton de demande d'accès au playtest.
- Branche : la doc conseille aux testeurs la branche `bleeding-edge` (clic droit sur le jeu → **Propriétés** → **Bêtas**).

---

## 14. Serveur dédié Nanos World

### 14.1 Le portable peut-il faire tourner le serveur ? (réponse honnête)
D'après la doc officielle, les **prérequis minimums** du serveur sont : Windows ou Linux, processeur `2 × 1,0 GHz`, **50 Mo de RAM** (plus avec beaucoup de joueurs ou d'entités), **30 Mo de stockage** (+ assets et packages), réseau ≥ 1 Mo/s, ports **7777 TCP/UDP** et **7778 UDP**, et sous Windows le **Microsoft Visual C++ Redistributable**.
👉 **Oui, ton portable dépasse largement ces prérequis.** Il peut lancer le serveur pour tester tes **scripts côté serveur** (les messages `Console.Log` s'affichent dans la console du serveur). En revanche, pour **voir** le résultat en jeu, il faut le **client sur le PC fixe**, qui peut se connecter au serveur du portable sur ton réseau local. **Non testé en conditions réelles.**

### 14.2 Installer (non testé sur Windows)
Prérequis Windows :
```powershell
winget install --id Microsoft.VCRedist.2015+.x64 -e --source winget
```
Quatre options officielles :
1. 🖥️ L'exécutable déjà présent dans le dossier du jeu : `nanos-world/Server/NanosWorldServer.exe` (recommandé par la doc sur le PC fixe).
2. L'outil **nanos world™ Dedicated Server** dans la bibliothèque Steam (section Outils).
3. 💻 **SteamCMD** (sans le jeu) : télécharge SteamCMD depuis la page officielle de Valve https://developer.valvesoftware.com/wiki/SteamCMD#Downloading_SteamCMD, dézippe-le dans `C:\steamcmd`, puis dans un terminal placé dans ce dossier :
   ```powershell
   .\steamcmd.exe +force_install_dir C:/nanos-world-server +login anonymous "+app_update 1936830 -beta public" validate +quit
   ```
   (`1936830` est l'identifiant de l'application serveur ; la connexion **anonyme** suffit d'après la doc.)
4. Docker (maintenu par la communauté) : inutile ici.

### 14.3 Lancer et vérifier
```powershell
cd C:\nanos-world-server
.\NanosWorldServer.exe
```
Au premier lancement, le serveur crée `Config.toml`. Windows peut afficher une alerte du **pare-feu** : autorise l'accès sur les **réseaux privés** uniquement. Le serveur tourne en **Playtest** par défaut (paramètre `--steam_app` pour changer).

### 14.4 Créer un premier package (doc officielle, Quick Start)
```powershell
.\NanosWorldServer.exe --cli add package mon-premier-package
```
Le dossier `Packages/mon-premier-package/` contient `Server/`, `Client/`, `Shared/` et `Package.toml`. Ajoute son nom dans `Config.toml` (section `[game]`, liste `packages`). Tout cela sera détaillé au **parcours E**.

---

## 15. Unreal Engine 5.7 avec 16 Go de RAM

🖥️ **PC fixe uniquement. N'installe jamais Unreal sur le portable.**

- **À quoi ça sert** : créer des maps et des objets pour Nanos World.
- **Version exigée** : la doc Nanos World indique **Unreal Engine 5.7.X** (page *Setting Up Unreal Engine*, vérifiée le 06/10/2026). **Revérifie cette page avant d'installer** : la version change avec les mises à jour du jeu.
- **Coût** : gratuit (licence Epic) · **Sources** : https://docs.nanos-world.com/docs/assets-modding/creating-assets/setting-up-ue et https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-specifications-for-unreal-engine

### 15.1 Avertissement mémoire
Epic recommande **32 Go de RAM** pour Unreal Engine 5.7 ; ton PC fixe en a **16**. Ça fonctionne pour de **petites maps**, à condition d'être économe :
- Ferme le navigateur, Discord, Steam et le jeu avant d'ouvrir Unreal.
- Dans l'éditeur, baisse la qualité d'affichage (menu des réglages de scalabilité de l'éditeur, *Engine Scalability Settings*, sur **Medium** ou **Low**) : vérifie l'intitulé exact à l'écran, il peut varier selon la version.
- Laisse Windows gérer automatiquement le **fichier d'échange** (mémoire virtuelle) : **Paramètres système avancés** → **Performances** → **Paramètres** → **Avancé** → **Mémoire virtuelle** → case **Gérer automatiquement la taille du fichier d'échange pour tous les lecteurs** cochée, sur un **SSD** avec de la place libre.
- **Petites maps** (une maison, un parc, une grotte) plutôt qu'un grand monde ouvert.
- **Sauvegarde souvent** (`Ctrl+S`) : en cas de manque de mémoire, l'éditeur peut planter.

### 15.2 Espace disque
Le launcher affiche la **taille exacte** avant l'installation : elle se compte en **dizaines de Go**. Prévois en plus de la place pour le cache de shaders et tes projets. Installe Unreal sur un **SSD**.

### 15.3 Installation (non testée sur Windows)
1. Installe le **Epic Games Launcher** :
   ```powershell
   winget install --id EpicGames.EpicGamesLauncher -e --source winget
   ```
   (ou depuis https://www.unrealengine.com/en-US/download), puis connecte-toi avec un compte Epic.
2. Ouvre l'onglet **Unreal Engine** → **Library** (Bibliothèque).
3. Clique sur **+** à côté de *Engine Versions* et choisis la version **5.7.X** (celle indiquée par la doc Nanos World).
4. Clique sur **Install**, choisis un dossier sur ton SSD, puis **Install**.
5. Lance Unreal une première fois pour terminer l'installation.

### 15.4 Prérequis pour « cooker » des assets : Windows SDK
D'après la doc Nanos World, il faut le **Windows SDK** :
- si tu as Visual Studio : **Visual Studio Installer** → **Composants individuels** → `Windows 11 SDK (10.0.26100.0)` ;
- sinon : https://learn.microsoft.com/en-us/windows/apps/windows-sdk/downloads → **Download the installer**.

### 15.5 La suite (parcours F)
Nanos World fournit l'**ADK** (Assets Development Kit), un projet Unreal réglé comme le jeu : https://github.com/nanos-world/assets-development-kit. Son installation et le pipeline complet (créer, cooker, exporter, tester en jeu) seront détaillés au **parcours F**.

### 15.6 Désinstaller
Epic Games Launcher → **Unreal Engine** → **Library** → flèche sous la version → **Remove**.

---

## 16. Blender (optionnel)

🖥️ PC fixe · **À quoi ça sert** : modéliser de petits objets 3D · **Coût** : gratuit (GPL)
```powershell
winget install --id BlenderFoundation.Blender -e --source winget
```
Vérifier : lance **Blender** depuis le menu Démarrer. Désinstaller : `winget uninstall --id BlenderFoundation.Blender -e`. Aucune partie du cours n'en dépend.

---

## 17. Discord (recommandé)

**À quoi ça sert** : rejoindre la communauté Nanos World (aide, annonces de playtests, accès prioritaire) : https://discord.nanos-world.com
```powershell
winget install --id Discord.Discord -e --source winget
```
Astuce anti-distraction : coupe les notifications pendant tes séances (clic droit sur l'icône de Discord → **Ne pas déranger**).

---

## 18. Récapitulatif par machine

### Portable HP 💻 (machine de code)
- [ ] Terminal ouvert, `pwd` fonctionne
- [ ] `winget --version`
- [ ] VS Code : `code --version`
- [ ] Git : `git --version`, éditeur, branche `main`, fins de ligne
- [ ] Identité : `git config --global user.email` affiche l'adresse noreply
- [ ] Connexion GitHub par le navigateur réussie (premier `git push`)
- [ ] Extensions VS Code installées, Settings Sync activé
- [ ] Lua : `lua -v` affiche `Lua 5.4.6`
- [ ] Node.js : `node --version` affiche `v24.x.x`
- [ ] Python : `python --version` affiche `Python 3.13.x` (dès que ton cours de Python commence)
- [ ] Dépôt `mon-apprentissage` cloné, premier `push`
- [ ] Site du cours lancé avec `npm run dev`
- [ ] (Optionnel) Serveur dédié Nanos World

### PC fixe 🖥️ (machine principale)
- [ ] Les mêmes étapes que le portable jusqu'au dépôt (Node.js utile mais facultatif)
- [ ] `git pull` récupère le travail fait sur le portable (test de synchronisation)
- [ ] (Quand l'accès est ouvert) Steam + Nanos World
- [ ] (Parcours F) Epic Games Launcher + Unreal Engine 5.7 + Windows SDK
- [ ] (Optionnel) Blender, Discord

---

## 19. Python 3.13 et SQLite (cours de Python, parcours D)

- **À quoi ça sert** : faire tourner tes programmes Python (ton cours de BTS, les modules D1 à D7 et la salle d'entraînement Python). Le module `sqlite3` fourni avec Python te permet aussi de faire du SQL **sans rien installer d'autre**.
- **Priorité** : essentiel dès que tu fais du Python · **Coût** : gratuit (licence PSF) · **Source** : https://www.python.org/
- Dans le navigateur, sans rien installer : le **Labo Python** du site (page Boîte à outils) permet d'essayer du Python n'importe où, mais il ne remplace pas une vraie installation.

### 19.1 Choisir la méthode (honnêteté)
La documentation officielle de Python pour Windows (dépôt `python/cpython`, fichier `Doc/using/windows.rst`, lu le 06/10/2026) recommande aujourd'hui le **Python Install Manager** (outil officiel qui installe et met à jour les versions de Python). L'installeur classique de python.org existe toujours et c'est celui que propose le paquet winget ci-dessous.

| Méthode | Commande ou lien | Quand la choisir |
|---|---|---|
| **Installeur python.org via winget** (choisie par le cours : une commande, `python` fonctionne après réouverture du terminal) | `winget install -e --id Python.Python.3.13` | Cas général |
| Python Install Manager (recommandé par la doc de Python) | `winget install -e --id Python.PythonInstallManager`, ou depuis le Microsoft Store, ou le fichier proposé sur python.org/downloads | Si tu préfères l'outil officiel et ses mises à jour |

**Ne mélange pas les deux** sur la même machine : la documentation de Python signale que d'anciennes installations ou un PATH modifié peuvent empêcher les commandes `python` et `py` de fonctionner. Choisis-en une, et si ton école utilise une version précise (3.12, 3.13…), prends la même, ça évite des différences.

Identifiants vérifiés dans le dépôt officiel des manifestes `microsoft/winget-pkgs` le 06/10/2026 : `Python.Python.3.13` (version 3.13.15, commandes `py`, `python`, `pythonw`, `pyw`) et `Python.PythonInstallManager` (version 26.3.240.0).

### 19.2 Installation (non testée sur Windows)
```powershell
winget install -e --id Python.Python.3.13
```
Puis **ferme et rouvre le terminal** (le manifeste winget demande l'ajout de Python au PATH ; un terminal déjà ouvert ne le sait pas).

### 19.3 Vérifier
```powershell
python --version
py --version
```
Résultat attendu : `Python 3.13.x` (le dernier chiffre peut différer). Puis un vrai test :
```powershell
python -c "print('Bonjour depuis Python')"
```
Résultat attendu : `Bonjour depuis Python`.

### 19.4 Erreurs fréquentes
| Problème | Solution |
|---|---|
| `python` n'est pas reconnu | Ferme et rouvre le terminal. Essaie `py --version`. Si rien ne marche, vérifie avec `winget list --id Python.Python.3.13` |
| Taper `python` ouvre le **Microsoft Store** | Windows a un « alias d'exécution d'application » : Démarrer → « Gérer les alias d'exécution d'application » (en anglais : « Manage app execution aliases », intitulé cité par la doc de Python, non vu en français), puis règle l'alias `python.exe` sur la version installée ou désactive celui du Store |
| Deux versions de Python s'embrouillent | Utilise `py --list` (ou `py list` avec le Python Install Manager) pour voir ce qui est installé, et ne garde qu'une méthode d'installation |
| `ModuleNotFoundError` sur un module de ton cours | Le module n'est pas installé : demande à ton prof lequel installer, puis `python -m pip install <nom>` (commande vérifiée dans la doc Python ; n'installe rien que tu ne connais pas) |

### 19.5 Extension VS Code (voir section 7)
L'extension **Python** de Microsoft est conseillée pour VS Code (coloration, exécution, débogage). Elle fait partie des extensions recommandées du dépôt (`.vscode/extensions.json`) : voir la section 7 pour son installation et sa vérification.

### 19.6 SQL avec SQLite : rien à installer
Python 3.12 et plus inclut une **interface en ligne de commande** pour SQLite :
```powershell
python -m sqlite3 boutique.db
```
Tu arrives sur une invite où tu tapes du SQL (le module D6 t'explique tout, pas à pas). Pour quitter : `.quit` (voir la page du cours). En option, un outil graphique : `winget install -e --id DBBrowserForSQLite.DBBrowserForSQLite` (identifiant vérifié ; non testé sur Windows).

### 19.7 Désinstaller
```powershell
winget uninstall -e --id Python.Python.3.13
```

# Fiche de référence vérifiée : mapping pour Nanos World (parcours F)

> Destinataires : les auteurs du parcours F (« Mapping : petites maisons, parcs et grottes »).
> Date de vérification : **6 octobre 2026**.
> Source principale : dépôt `nanos-world/docs` cloné dans `/home/user/nanos-world/docs`, commit `46a50bb` du 1er oct. 2026 (c'est lui qui génère docs.nanos-world.com). Le site et `dev.epicgames.com` sont **inaccessibles** depuis le conteneur (proxy 403) : rien n'a été lu sur le site ni sur la doc d'Epic.
> Règle appliquée : tout ce qui n'est pas écrit dans un fichier lu est marqué **NON DOCUMENTÉ** (la doc Nanos ne le dit pas) ou rangé dans la section 6 (**NON VÉRIFIÉ**, connaissance générale d'Unreal).

## Légende et conventions de citation

| Étiquette | Sens |
|---|---|
| **[DOC]** | Écrit dans une page de `docs/docs/` (chemin cité, relatif à `docs/docs/`). |
| **[BLOG]** | Annonce datée dans `docs/blog/` (chemin `blog/AAAA-MM-JJ-mois.mdx`). Utile mais pas une page de référence : peut être dépassée. |
| **[EXT-SRV]** | Fichier officiel du dépôt `nanos-world/nanos-world-server` (branche `main`), que les pages de la doc **incluent par un lien** (`toml reference`) : `_map.toml`, `Assets.toml`, `Config.toml`, `DefaultAssetPack.toml`. Récupérés le 06/10/2026 sur `raw.githubusercontent.com`. Hors dépôt docs. |
| **[EXT-API]** | Fichiers JSON du dépôt `nanos-world/api` (branche `main`), sous-module `src/api` du dépôt docs, **vide dans le clone local**. Ce sont eux qui génèrent les listes de méthodes des pages `scripting-reference/`. Récupérés le 06/10/2026. Le commit exact figé par la doc est inconnu : possible écart. |
| **[EXT-ADK]** | Fichiers du dépôt `nanos-world/assets-development-kit`, branche `master` : `README.md`, `NanosWorldADK.uproject`, `Config/DefaultEngine.ini`. Récupérés le 06/10/2026. |
| **[ANCIEN]** | Page ou passage signalé comme ancien, ou contredit par une source plus récente (voir section 0.2). |
| **NON DOCUMENTÉ** | La doc lue ne dit rien. Les auteurs ne doivent rien affirmer. |
| **NON VÉRIFIÉ** | Connaissance générale d'Unreal, **pas** dans les fichiers lus. À marquer « non vérifié » dans le cours. |

Rien de ce qui suit n'a été **testé** (pas de Windows, pas d'Unreal, pas de jeu dans le conteneur).

---

## 0. À retenir (synthèse pour les auteurs)

### 0.1 Les dix faits les plus importants

1. **Version d'Unreal : 5.7.X** (« currently nanos world is on `5.7.X` ») [DOC `assets-modding/creating-assets/setting-up-ue.mdx`]. Le patch exact n'est pas imposé : le modèle `Assets.toml` indique `unreal_version = "5.7.0"` [EXT-SRV `Assets.toml`], un exemple de la doc `5.7.3` [BLOG `blog/2026-03-04-february.mdx`], la console serveur d'exemple `Unreal Version: 5.7.4` [DOC `getting-started/quick-start.mdx`] et le blog du 15/04/2026 liste « Unreal Engine 5.7.4 » [BLOG `blog/2026-04-15-march.mdx`]. À relire dans la console du serveur au démarrage.
2. **La seule page « créer une map » est ancienne** : bandeau « This page is old and this tutorial may be outdated! The images here reference to Unreal Engine 4 » [DOC `assets-modding/creating-assets/maps-and-levels/importing-maps.mdx`]. Elle contient aussi des éléments périmés (section 0.2).
3. **Une map jouable = trois choses** : (a) un **Asset Pack cooké** contenant le `.umap` et son `Assets.toml` ; (b) un **package de type `map`** (`Package.toml` avec `map_asset`) ; (c) la **ligne `map = "..."` du `Config.toml`** ou le choix de la map dans l'écran « New Game » [DOC `core-concepts/packages/packages-guide.mdx`, `core-concepts/server-manual/server-configuration.mdx`, `getting-started/essential-concepts.mdx`].
4. **Le serveur ignore tout d'Unreal** : « nanos world server is not aware of Unreal or it's Assets » [DOC `core-concepts/packages/packages-guide.mdx`]. Conséquence pratique : le serveur ne peut **pas** confirmer que la map se charge ; seul le **client du jeu** la charge (erreur typique : « Disconnected. Failed to Load Map! » [DOC `assets-modding/creating-assets/importing-assets.mdx`]). Sans accès au jeu, la validation s'arrête à « le serveur démarre sans erreur de `Package.toml` ».
5. **Le cooking exige le Windows SDK** (`Windows 11 SDK (10.0.26100.0)`) [DOC `setting-up-ue.mdx`]. Le menu cité est **Platforms > Cook Content > Cook Content** [DOC `importing-assets.mdx`] ; la sortie est dans `Saved/Cooked/Windows/NanosWorldADK/` du projet ADK.
6. **Ne jamais toucher au dossier `NanosWorld/` de l'ADK** (ni modifier, ni supprimer, ni créer, ni copier) [DOC `assets-modding/creating-assets/adk-assets-development-kit.mdx`].
7. **Ne jamais renommer ni supprimer un fichier du dossier cooké** après copie : références cassées, matériaux gris, plantages [DOC `importing-assets.mdx`].
8. **Règles propres aux maps** (page ancienne mais seule source) : pas de meshes dynamiques avec physique placés dans le niveau ; tag d'acteur `Sun` sur les acteurs de lumière/ciel ; neutraliser les « GameMode Overrides » des World Settings [DOC `importing-maps.mdx`].
9. **Rien dans la doc sur les grottes, les intérieurs, Lumen/Lightmass côté éditeur, la configuration minimale d'Unreal, ni le Landscape pas à pas** (recherches `cave` et `lightmass` : 0 résultat ; `interior` : 2 fichiers hors sujet ; `landscape` : 3 fichiers, mentions de principe seulement).
10. **Il existe une voie sans Unreal** : le pack par défaut `nanos-world` contient des maisons, murs, fenêtres, escaliers, meubles, arbres, rochers, bancs, lampadaires (liste en 5.1), spawnables par Lua sur les cartes intégrées `default-blank-map` / `default-empty-map` [DOC `core-concepts/server-manual/server-configuration.mdx`, `assets-modding/default-asset-pack/default-assets-list.mdx`, EXT-SRV `DefaultAssetPack.toml`]. À proposer comme **plan B** et comme complément.

### 0.2 Pages anciennes, périmées ou contradictoires (à ne pas recopier)

| # | Où | Problème | Source qui corrige |
|---|---|---|---|
| 1 | `importing-maps.mdx` | Bandeau « old / Unreal Engine 4 » : captures et noms de menus possiblement changés. | Bandeau lui-même. |
| 2 | `importing-maps.mdx`, règle 2 | Cite `World.SpawnDefaultSun()`. Il n'y a **pas de classe `World`** dans l'API ; le blog dit que `Sky` « replace our existing DefaultSun (on World class) » [BLOG `blog/2022-12-07-november.mdx`]. | `Sky.Spawn()` [DOC `scripting-reference/static-classes/sky.mdx`, `adk-assets-development-kit.mdx`, EXT-API `StaticClasses/Sky.json`]. |
| 3 | `importing-maps.mdx` : `[assets.maps] MyAwesomeMap = "MyAwesomeMap"` | Ancien format (avant `unreal_folders`) : le chemin n'a pas le dossier racine. | Nouveau format : `MyMap = "MyAssetPack/Maps/MyAwesomeMap"` [EXT-SRV `Assets.toml`, DOC `importing-assets.mdx`, BLOG `blog/2026-03-04-february.mdx` « Asset Packs Multiple Folders »]. |
| 4 | `importing-maps.mdx` : « This way we can load it through Config.toml » et « start the New Game with the Sandbox package » | Avant mars 2023 la map se chargeait via l'Asset Pack. Aujourd'hui il faut un **package `map`**. | [BLOG `blog/2023-04-05-march.mdx`], [DOC `packages-guide.mdx`]. |
| 5 | `static-meshes.mdx` : `SM_MoneyStack = "SM_MoneyStack"` | Même ancien format de chemin. | Idem 3. |
| 6 | `scripting-reference/classes/staticmesh.mdx` : « Automatically all StaticMeshActors present in the Level will be loaded as a StaticMesh entity in the client side » | Depuis janvier 2023, c'est **optionnel** (`load_level_entities`, désactivé par défaut dans le modèle). | [DOC `packages-guide.mdx`], [BLOG `blog/2023-02-01-january.mdx`], [EXT-SRV `_map.toml`]. |
| 7 | `whitelisted-ue-plugins.mdx` : Ultra Dynamic Sky `v8.3A` | Le blog parle de `v9.0B` (août 2025) puis `v9.1` (sept. 2025). Page de plugins **non fiable pour la version**. | [BLOG `blog/2025-09-03-august.mdx`, `blog/2025-10-08-september.mdx`]. |
| 8 | `water.mdx` : l'activation du Water Plugin dans l'ADK « requires you have installed Visual Studio and all usual .NET dependencies » | Le `.uproject` actuel de l'ADK **active déjà** `Water` [EXT-ADK `NanosWorldADK.uproject`] et `setting-up-ue.mdx` ne cite que le Windows SDK. Si Visual Studio est vraiment nécessaire : NON DOCUMENTÉ. | — |
| 9 | `quick-start.mdx` : journal d'exemple `Version: 1.9.0` | Contredit `compatibility-versions.mdx` (paliers jusqu'à `1.144`) ; `_map.toml` propose `compatibility_version = "1.25"`. Le numéro de version actuel du jeu n'est écrit nulle part. | À lire dans la console du serveur. |
| 10 | `adk-assets-development-kit.mdx` liste Placeholders ADK et Lua Code Generator | Le blog annonce une simplification de l'ADK « to reduce the redundant tools » [BLOG `blog/2025-08-06-july.mdx`]. Présence de ces outils dans l'ADK actuel : NON VÉRIFIÉ. | Ouvrir l'ADK pour confirmer. |
| 11 | `skeletal-meshes/characters-meshes.mdx` | Parle de « UE4 Marketplace » et de la « Vault » du Launcher (hors sujet pour les maps, ancien). | — |
| 12 | Formats de vignettes | **ADK Thumbnail Generator** : `.jpg` ; **Forge Thumbnail Generator** : `.png` ; **vignette de map** : `.webp` du même nom que la map ; **Sandbox** lit des `.jpg` dans `Thumbnails/`. Ne pas confondre. | [DOC `adk-...mdx`, `forge/tools/thumbnail-generator.mdx`, `importing-maps.mdx`, `importing-assets.mdx`]. |

---

## 1. Le pipeline OFFICIEL complet tel que documenté

### 1.1 Prérequis

| Élément | Ce que dit la doc | Source |
|---|---|---|
| Version d'Unreal | **5.7.X** | `assets-modding/creating-assets/setting-up-ue.mdx` |
| Installation sous Windows | Via **Epic Games Launcher** (page de téléchargement `unrealengine.com/en-US/download`). Étapes : ouvrir le Launcher > onglet **Unreal Engine** > onglet **Library** > bouton **`+`** > choisir la version > **Install** > choisir un dossier > **Install**. Puis **lancer Unreal une fois** pour finir l'installation. | `setting-up-ue.mdx` (sections « On Windows » et « Next Steps ») |
| SDK obligatoire pour cooker | « it's required to install some SDKs to be able to cook assets » : **`Windows 11 SDK (10.0.26100.0)`**. Deux voies : (recommandée si Visual Studio est installé) Visual Studio Installer > onglet **Individual components** ; sinon installeur depuis le site Microsoft (`Download the Installer >`). | `setting-up-ue.mdx` |
| Visual Studio | Cité seulement comme **moyen pratique** d'installer le SDK. Obligatoire ou non pour le reste : NON DOCUMENTÉ (voir 0.2 n° 8 pour le Water Plugin). | `setting-up-ue.mdx`, `maps-and-levels/water.mdx` |
| Linux | Binaires autonomes d'Epic (`unrealengine.com/en-US/linux`). Hors sujet pour le PC fixe Windows 11. | `setting-up-ue.mdx` |
| Espace disque / RAM / GPU pour l'éditeur | **NON DOCUMENTÉ** (voir section 7). | — |
| Compte Epic | Implicite (Launcher). Non précisé par la page. | — |
| Jeu / serveur Nanos World | Nécessaire pour **tester**, pas pour cooker. Serveur installable par SteamCMD avec `login anonymous` et `app_update 1936830 validate` ; le client exige l'accès au jeu (Closed Testing). | `core-concepts/server-manual/server-installation.mdx`, `signing-up-alpha.mdx` |

### 1.2 Étapes numérotées (de l'installation au test en jeu)

**Phase A : l'ADK**

1. Télécharger la dernière version de l'ADK sur GitHub (`github.com/nanos-world/assets-development-kit/`) et l'**extraire** sur l'ordinateur [DOC `adk-assets-development-kit.mdx`]. Les « releases » de ce dépôt sont citées pour Forge [DOC `forge/setup.mdx`]. Alternative : l'ADK est aussi publié comme **outil Steam** (« you still need to download Unreal Engine separately »), avec Forge inclus [BLOG `blog/2026-03-04-february.mdx`, `blog/2023-02-01-january.mdx`].
2. Ouvrir `NanosWorldADK.uproject` avec Unreal ; la première ouverture compile les shaders et peut être longue [DOC `adk-assets-development-kit.mdx`].
3. Repérer les deux dossiers de `Content/` : `NanosWorld/` (**ne pas toucher**) et `MyAssetPack/` (exemple à renommer) [DOC `importing-assets.mdx`].
4. Mise à jour de l'ADK : copier la nouvelle version **par-dessus** en écrasant tous les fichiers ; **sauvegarder `Config/`** avant (réappliquer ses réglages à la main) [DOC `adk-...mdx`].

**Phase B : créer le niveau (map)**

5. Choisir **Game Content** (recommandé si on hésite) : tout dossier créé dans `Content/` peut être cooké. Choisir un **nom unique** (deux packs avec `Content/Weapons/` entrent en conflit). Alternative **Plugin Content** : Edit > Plugins > `+ Add`, activer « Show Plugin Content » [DOC `importing-assets.mdx`].
6. Créer un dossier dans `Content/` (« this step is very important ») [DOC `importing-maps.mdx`].
7. Clic droit dans le Content > **Level** ; nommer, enregistrer, ouvrir. La vue est noire (niveau vide) [DOC `importing-maps.mdx`].
8. Ajouter un sol : glisser un **Plane** depuis *Place Actors > Basic*, puis **copier ce mesh du moteur dans son propre dossier** (Ctrl+C / Ctrl+V depuis le dossier du moteur) et le remplacer ; échelle `X=10, Y=10, Z=10`, position `0, 0, 0` [DOC `importing-maps.mdx`]. Les contenus moteur autorisés sans copie : `/Engine/Functions`, `/Engine/BasicShapes`, `/Engine/ArtTools`, `/Engine/EngineMaterials` ; pour tout autre, copier dans son dossier [DOC `importing-assets.mdx`].
9. Ajouter **Directional Light** (soleil et ombres) et **Sky Light** ; déplacement dans la vue : **clic droit + WASD**, touche **F** pour centrer l'objet sélectionné [DOC `importing-maps.mdx`] (équivalent sur clavier AZERTY : NON VÉRIFIÉ). Mettre la Directional Light en **Movable** pour des ombres temps réel [DOC `importing-maps.mdx`]. Option : `NanosWorld/Blueprints/World/BP_SunSky` (ciel + soleil préconfigurés) [DOC `adk-...mdx`].
10. Matériaux : clic droit > nouveau Material (`M_Plane`), nœud `Constant3Vector` branché sur **Base Color**, puis glisser le matériau sur le mesh [DOC `importing-maps.mdx`]. Convention de noms de la doc : `SM_`, `M_`, `MI_`, `T_`, `SK_`, `PHYS_`, `A_`, `P_` (voir `importing-assets.mdx`, « Name your assets properly »).
11. Appliquer les **3 règles de map** (section 2, R1 à R3).
12. Prendre une capture de la map, l'enregistrer en `.webp` **au même nom que la map** (ex. `MyAwesomeMap.webp`) [DOC `importing-maps.mdx`].

**Phase C : cooker**

13. (Facultatif mais conseillé) Project Settings : activer **`Cook only maps`** et renseigner **`List of maps to include in a packaged build`** ; au besoin **`Additional Asset Directories to Cook`** [DOC `importing-assets.mdx`, « Cook only what is needed »]. Par défaut Unreal cooke **tout** le projet.
14. Menu **Platforms > Cook Content > Cook Content** ; long la première fois [DOC `importing-assets.mdx`]. (Avec Forge : voir 1.3.)
15. Aller dans `assets-development-kit/Saved/Cooked/Windows/NanosWorldADK/` (**pas** dans le dossier `Content` du projet) ; en Game Content, les dossiers cookés sont dans `Content/`, en Plugin Content dans `Plugins/` [DOC `importing-assets.mdx`]. Les fichiers cookés ont les extensions `.uasset`, `.uexp`, `.ubulk` (et `.umap` pour une map).

**Phase D : l'Asset Pack**

16. Créer `nanos-world-server/Assets/mon-pack/` : nom en **kebab-case** obligatoire [DOC `importing-assets.mdx`]. (Dans l'installation Steam, le serveur est dans `nanos-world/Server/` ; Vault et CLI y écrivent `Packages/` et `Assets/` [DOC `vault-and-store/vault.mdx`, `getting-started/quick-start.mdx`].)
17. Copier **tous** les dossiers cookés utiles dans ce dossier (pas le dossier `NanosWorld/` : « you shouldn't create an Asset Pack for the NanosWorld/ folder »). Si « cook only maps » a produit plusieurs dossiers dans `Saved/Cooked/`, **tous** sont nécessaires [DOC `importing-assets.mdx`, dépannage n° 4].
18. Créer `Assets.toml` à la racine du pack (modèle : `core-concepts/assets.mdx` ou `Assets.toml` du serveur) et régler `unreal_folders`, `unreal_version`, `is_plugin_content` + `[assets.maps]` (exemple dérivé ci-dessous) [DOC `importing-assets.mdx`, `core-concepts/assets.mdx`, EXT-SRV `Assets.toml`].
19. (Facultatif) vignette `.webp` copiée **dans le même dossier que le `.umap`** ; logo du pack `Assets.jpg` 300x150 à côté de `Assets.toml` [DOC `importing-maps.mdx`, `core-concepts/assets.mdx`].

Exemple d'`Assets.toml` pour une map (**dérivé** du modèle EXT-SRV et de `importing-assets.mdx` ; **non testé**) :

```toml
[meta]
    title =   "Mon Village"
    author =  "Moi"
    version = "0.1.0"

[unreal]
    # noms exacts des dossiers racine cookés (dans Content/)
    unreal_folders = [ "MonVillage" ]
    unreal_version = "5.7.0"      # à aligner sur le jeu (voir 0.1 n° 1)
    is_plugin_content = false

[assets]
    [assets.maps]
        # clé = chemin DANS le dossier cooké, sans extension
        Village = "MonVillage/Maps/Village"
```

**Phase E : le package de type `map`**

20. Créer le package : `./NanosWorldServer.exe --cli add package mon-village-map` puis répondre type **`map`** [DOC `getting-started/quick-start.mdx`, `core-concepts/server-manual/command-line-interface.mdx`] ; ou depuis le jeu : Vault > `+ create new package` (le choix de l'asset de map se fait dans une liste, [BLOG `blog/2023-06-07-may.mdx`]) [DOC `vault-and-store/vault.mdx`] ; ou à la main. Nom de dossier : minuscules, chiffres, `-`, 64 caractères max [DOC `packages-guide.mdx`].
21. Écrire le `Package.toml` (champs exacts ci-dessous) [DOC `packages-guide.mdx`, EXT-SRV `_map.toml`].
22. (Facultatif) `Server/Index.lua` du package map : conseillé pour les positions de Props, armes, véhicules ; les points d'apparition vont dans `Package.toml` [DOC `packages-guide.mdx`, astuce du bloc `map`].

Champs de la section `[map]` (liste exacte du modèle `_map.toml` ; commentaires traduits) :

| Champ | Rôle | Source |
|---|---|---|
| `[meta]` `title`, `author`, `version` | Nom, auteurs, version SemVer `X.Y.Z` | `packages-guide.mdx`, EXT-SRV `_map.toml` |
| `auto_cleanup` (`true`) | Détruit les entités créées par le package à son déchargement | idem |
| `load_level_entities` (`false`) | Charge les StaticMesh du niveau comme entités côté client ; « costs performance » | idem |
| `compatibility_version` | Version du jeu `major.minor` à la création (modèle : `"1.25"`, dernier palier listé : `1.144`) | `packages-guide.mdx`, `compatibility-versions.mdx` |
| `packages_requirements` | Packages à charger avant (type `script` ou `c-module` seulement) | `packages-guide.mdx`, `package-loading-and-lua-environment.mdx` |
| `assets_requirements` | Asset Packs à charger avec le package | idem |
| `compatible_game_modes` | Game-modes conseillés (affichage dans « New Game ») | `packages-guide.mdx`, [BLOG `blog/2022-08-03-july.mdx`] |
| `map_asset` | `"[PACK]::[CLÉ]"` (modèle : `"nanos-world::BlankMap"`) | `packages-guide.mdx`, EXT-SRV `_map.toml` |
| `spawn_points` | Liste de `{ location = "Vector(x, y, z)", rotation = "Rotator(p, y, r)" }` (**chaînes de caractères**) | `packages-guide.mdx`, EXT-SRV `_map.toml` |
| `enable_water_buoyancy` (`false`) | À activer seulement si la map utilise le Water Plugin | `packages-guide.mdx`, `water.mdx` |
| `[custom_data]` | Données libres lues par `Server.GetMapConfig()` | `packages-guide.mdx`, EXT-SRV `_map.toml` |

Exemple dérivé (**non testé**), cohérent avec `getting-started/essential-concepts.mdx` :

```toml
[meta]
    title = "Mon Village"
    author = "Moi"
    version = "0.1.0"

[map]
    map_asset = "mon-pack::Village"
    assets_requirements = [ "mon-pack" ]
    compatibility_version = "1.144"   # à confirmer avec la version du jeu
    spawn_points = [
        { location = "Vector(0, 0, 100)", rotation = "Rotator(0, 0, 0)" },
    ]
```

**Phase F : charger et tester**

23. `Config.toml`, section `[game]` : `map = "mon-village-map"` (nom du **package** map). Valeur par défaut : `default-blank-map`. Autres options : paramètre `--map`, ou la console serveur `map <map_package>` (recharge tout et reconnecte les joueurs), ou `Server.ChangeMap(map_path)` [DOC `server-manual/server-configuration.mdx`, EXT-API `StaticClasses/Server.json`]. `assets = [...]` force le chargement d'Asset Packs supplémentaires [DOC idem].
24. Démarrer le serveur (`./NanosWorldServer.exe`), puis dans le jeu : **Find Servers > Quick Connect > `127.0.0.1:7777`** ; sans game-mode, on est un **pion volant** qui peut visiter la map [DOC `getting-started/quick-start.mdx`]. Le jeu et le serveur doivent tourner sur la même application Steam (Playtest par défaut) [DOC `troubleshooting.mdx`, `signing-up-alpha.mdx`].
25. Avec un game-mode (ex. `sandbox`) : écran **New Game**, où les maps (packages `map`) se choisissent [BLOG `blog/2023-04-05-march.mdx`] ; pour les assets d'un pack, ajouter le pack à la liste `assets` ; Sandbox les liste à `Props > All Props` [DOC `static-meshes.mdx`]. Installation d'un package : `--cli install package sandbox` [DOC `server-manual/server-configuration.mdx`].
26. Itérer : `package reload <nom>` et `map <package>` [DOC `server-configuration.mdx`] ; modifier des fichiers d'un Asset Pack serveur allumé déclenche un **rechargement automatique** (les joueurs doivent se reconnecter) [BLOG `blog/2025-06-11-june.mdx`].
27. Diagnostic : logs serveur dans `.logs/` (`NanosWorldCore.log`), logs client dans `%LocalAppData%\NanosWorld\Saved\Logs\` [DOC `troubleshooting.mdx`]. Corrections génériques : recooker avec un ADK à jour ; supprimer `Saved/`, `Intermediate/` et `DerivedDataCache/` du projet pour un recook complet ; vérifier l'installation d'Unreal dans le Launcher [DOC `importing-assets.mdx`, « Troubleshooting »].
28. (Facultatif) Publier sur la Vault : `--cli upload assets <nom>` exige un **`token`** : ne **jamais** le mettre dans le dépôt [DOC `command-line-interface.mdx`, `vault-and-store/store.mdx`].

### 1.3 Variante « Forge » (cooking automatisé)

Forge est un plugin Unreal **expérimental**, communautaire (auteur : NegativeName), endossé par Nanos, « actively developed ... occasional bugs may occur » ; inclus dans l'ADK de GitHub et dans l'ADK Steam [DOC `assets-modding/forge/setup.mdx`, BLOG `blog/2026-03-04-february.mdx`]. Fenêtre : **Window > Nanos World Forge**. Le **Cook Handler** copie le contenu cooké vers `ServerPath/Assets/` (repli : `YourProject/ForgeCooked/`) et écrit un `Assets.toml` par pack. Réglages : `Nanos World Server Path`, `Enable Cook Handler`, `Write Assets Toml` [DOC `forge/setup.mdx`].

**NON DOCUMENTÉ** : ce que fait exactement le Cook Handler pour `unreal_folders`, pour `[assets.maps]`, pour la casse/kebab-case du dossier cible ; si le déclenchement passe toujours par Platforms > Cook Content ; la création du **package map** (il reste à faire à la main, étapes 20 à 22). Recommandation : faire le **premier export à la main** (étapes 14 à 19) pour comprendre, comme le dit la doc (« we recommend doing it manually the first time ») [DOC `importing-assets.mdx`].

### 1.4 Variante « sans Unreal » (Lua seul)

La carte vide `default-blank-map` (`nanos-world::BlankMap`, « literally Empty and all black, good for dynamic scripting created maps ! ») [BLOG `blog/2022-05-04-april.mdx`], `default-empty-map`, `default-ocean-map`, `default-testing-map` sont intégrées et utilisables sans rien télécharger [DOC `server-configuration.mdx`, `essential-concepts.mdx`]. Un package `script` peut y faire apparaître des `StaticMesh`/`Prop` du pack `nanos-world` (`"nanos-world::SM_..."`). Exemples vérifiés dans la doc : `SM_Cube`, `SM_Plane`, `SM_None`, `SM_WoodenTable`, `SM_WoodenChair`, `SM_Crate_07` [DOC `getting-started/quick-start.mdx`, `tutorials-and-examples/doors.mdx`, `prop-rain.mdx`].

---

## 2. Règles et limites officielles pour les maps

| # | Règle / limite | Source | Remarque |
|---|---|---|---|
| R1 | **Pas de meshes dynamiques (avec physique) placés dans le niveau** : non synchronisés. Les créer en `Prop` par script. | `importing-maps.mdx` ([ANCIEN] mais cohérent avec `core-concepts/scripting/networking-and-replication.mdx`) | Les objets mobiles = Lua. |
| R2 | **Tag d'acteur `Sun`** sur tous les acteurs lumière/ciel/soleil (`DirectionalLight`, `SkyLight`, `DomeMesh`, `SkyAtmosphere`, `SunSky`). Permet aux scripteurs de les remplacer par le soleil officiel. | `importing-maps.mdx` (nom `World.SpawnDefaultSun()` périmé, voir 0.2 n° 2) | `Sky.DestroyAllSky()` détruit aussi « Directional Lights, Sky Lights, Exponential Height Fogs, Volumetric Clouds, Sky Atmosphere, Ultra Dynamic Sky Actors and all Actors with the Sun Actor Tag » [EXT-API `StaticClasses/Sky.json`]. Un game-mode peut donc supprimer le ciel/brouillard de la map. |
| R3 | Mettre à **None** toutes les références « GameModes Override » des **World Settings**. | `importing-maps.mdx` | |
| R4 | Tout asset doit vivre dans **vos** dossiers (`Content/MonDossier/` ou plugin) ; noms de dossiers **uniques**. | `importing-assets.mdx` | |
| R5 | Contenu du moteur : éviter ; seuls `/Engine/Functions`, `/Engine/BasicShapes`, `/Engine/ArtTools`, `/Engine/EngineMaterials` sont sûrs ; sinon **copier** dans son dossier. | `importing-assets.mdx`, `importing-maps.mdx` | Les deux pages se recoupent : copier est le choix le plus sûr. |
| R6 | Dossier `NanosWorld/` de l'ADK : **intouchable** ; références à garder telles quelles ; refuser l'enregistrement si Unreal le propose. | `adk-assets-development-kit.mdx` | |
| R7 | Après cooking : **ne rien renommer ni supprimer** dans le pack cooké. | `importing-assets.mdx` | |
| R8 | Dossier du pack en **kebab-case** ; dossier de package : minuscules/chiffres/`-`, 64 car. max. | `importing-assets.mdx`, `packages-guide.mdx` | |
| R9 | Textures : « max 2048x2048 » recommandé (≈ 5 Mo pièce, aussi en RAM) ; exemple de réduction 2048 → 512 = 380 Ko ; ne pas réduire les textures de grands meshes. | `importing-assets.mdx`, `static-meshes/static-meshes.mdx` | |
| R10 | LODs : réglage `Lod Settings > Number of LODs` = **3** recommandé. | `static-meshes.mdx` | |
| R11 | **Collisions** : certains meshes n'ont pas de collision ; la créer (onglet Collision > « Add Box Collision » ; « Remove Collision » ; `Show > Simple Collision` pour voir). | `static-meshes.mdx` | Meshes concaves (grottes) : NON DOCUMENTÉ. |
| R12 | Matériaux physiques **`PM_*`** de l'ADK à référencer (sons de pas/impact). **Ne pas les modifier ni les renommer.** | `adk-...mdx`, `static-meshes.mdx`, `default-asset-pack/default-materials.mdx` | Types de surface disponibles : voir `default-materials.mdx` (Concrete, Grass, Gravel, Ground, Rock, Sand, Water, WoodLight...). |
| R13 | Plugins Unreal : liste blanche ; **même version que Nanos** sinon plantage. Non listé = pas garanti (refus explicite : NON DOCUMENTÉ). Natifs utiles : **Water**, **PCG**, **Geometry Scripting**, HDRI Backdrop, Sun Position Calculator. | `assets-modding/whitelisted-ue-plugins.mdx` | PCG activé dans le jeu [BLOG `blog/2023-12-20-november.mdx`]. |
| R14 | Performances des matériaux (par défaut du pack) : **Opaque** = le plus efficace ; **Masked** = courant ; **Translucent** = plus lourd, « a lot of overdraw ». | `default-asset-pack/default-materials.mdx` | |
| R15 | Lumières : trois types de classes `Light` (Spot, Point, Rect), **toutes dynamiques, « very expensive »** ; paramètre `max_draw_distance` « good for performance ». | `scripting-reference/classes/light.mdx`, EXT-API `Classes/Light.json` | **Éclairage statique précalculé pris en charge depuis février 2024** [BLOG `blog/2024-02-28-february.mdx`] ; le réglage `r.AllowStaticLighting=True` est dans l'ADK [EXT-ADK `Config/DefaultEngine.ini`]. Procédure de calcul : NON DOCUMENTÉ. |
| R16 | Eau : Water Plugin d'Unreal, flottabilité automatique des Props/Pickables/Vehicles/Character ; **`enable_water_buoyancy = true`** dans `Package.toml` sinon pas de flottabilité (gain de performance). | `maps-and-levels/water.mdx`, `packages-guide.mdx`, [BLOG `blog/2026-05-06-april.mdx`] | |
| R17 | `load_level_entities` : n'activer que si le package lit les meshes du niveau ; « costs performance ». | `packages-guide.mdx` | |
| R18 | **NavMesh** : « the map will need to have a NavMesh configured » pour les PNJ ; génération **dynamique** ; les acteurs dont le réglage « Can Even Affect Navigation » (sic, orthographe du blog) est actif font recalculer le navmesh (cause d'une chute de FPS sur la map de test). | `core-concepts/scripting/artificial-intelligence.mdx`, [BLOG `blog/2025-04-09-april.mdx`] | Comment créer le NavMesh : NON DOCUMENTÉ (lien Epic seulement). |
| R19 | Traces : seuls les objets qui **bloquent le canal Visibility** sont retournés avec `TraceMode.TraceOnlyVisibility`. | [BLOG `blog/2025-06-11-june.mdx`], [DOC `scripting-reference/static-classes/trace.mdx`] | Utile pour les outils Sandbox (Spawn Menu, Physics Gun). |
| R20 | Level Streaming et World Partition **pris en charge** ; coordonnées double précision (grands niveaux). | [BLOG `blog/2023-02-01-january.mdx`], EXT-API `StaticClasses/Level.json` | Pas nécessaires pour de petites maps. |
| R21 | Les assets doivent être **recookés** à chaque nouvelle version d'Unreal du jeu ; `unreal_version` sert à éviter les plantages d'anciens assets. Le passage au patch 5.4.4 : « no cooked asset should break in this update ». | [BLOG `blog/2022-05-04-april.mdx`, `blog/2022-04-06-march.mdx`, `blog/2025-04-09-april.mdx`], `importing-assets.mdx` | Le jeu a refusé 5.6.1 à cause de problèmes de cook [BLOG `blog/2025-09-03-august.mdx`] : n'utiliser **que** la version exigée. |
| R22 | Git : pousser des assets cookés dans Git sans **LFS** casse le pack ; la doc qualifie la méthode « not a great solution ». | `importing-assets.mdx` (dépannage n° 5) | À répercuter dans le parcours (A4 : synchro Git). |
| R23 | **Limites chiffrées** (taille de map, nombre de triangles, de lumières, de meshes, de matériaux, de Props) : **NON DOCUMENTÉ**. | — | Ne donner aucun chiffre « officiel » autre que R9, R10. |
| R24 | Conseil des développeurs sur l'herbe : ombres dynamiques sur les meshes d'herbe = « usually a bad decision » ; ils sont passés aux **Contact Shadows**. | [BLOG `blog/2025-04-09-april.mdx`] | Anecdote de la map de test, pas une règle. |

---

## 3. Les outils Forge et ADK : fiches courtes

Toutes les fiches viennent de `assets-modding/forge/` (**Forge est « experimental »**). Les vidéos `.webm` des pages ne sont pas lisibles ici : les gestes exacts de l'interface sont donc **NON VÉRIFIÉS**. Les limites techniques de chaque outil ne sont **pas** documentées sauf mention.

| Outil | À quoi ça sert | Comment l'utiliser (doc) | Limites | Utile pour maisons / parcs |
|---|---|---|---|---|
| **Placeholders** (`forge/tools/placeholders.mdx`) | Placer des acteurs dans la map et les **exporter en code Lua** (points d'apparition, portes, props...). Contrairement aux placeholders de l'ADK, **non limité** à des classes imposées. | Ajouter un **Placeholder Component** (propriétés : `Group Name` ex. « Props », « Doors », « PlayerStarts » ; `Fields` liés à des propriétés/fonctions de l'acteur par **Field Bindings**). Lancer le **Placeholder Exporter**. Exemple de la doc : acteur `BP_PropPlaceholder` (hérite de `AStaticMeshActor`) exporté en `local Placeholders = { Props = { { location = Vector(...), rotation = Rotator(...), static_mesh = "my-asset-pack::Cube" }, ... } }`. Placeholder intégré : **`PlaceholderPlayerStart`** (exporte emplacement et rotation). | Où va le code exporté, comment le convertir en `spawn_points` (chaînes TOML) : NON DOCUMENTÉ ; les Lua Profiles « might not work as expected with Placeholders for now » (`forge/advanced/lua-profile.mdx`). | **Très utile** : poser meubles et points d'apparition à l'œil dans Unreal, puis les spawner en Lua. |
| **Object2Lua** (`object2lua.mdx`) | Convertir des **blueprints / Data Assets** Unreal en tables Lua. | Ouvrir depuis le « Forge hub » ; sélectionner un asset blueprint dans le Content Browser ; **Generate**. Réglages : `Full Gameplay Tags`, `Only Exposed Properties`, `Only Changed Properties`, format (`Global Profile`, `Spaces Per Indent`, `Pretty Print`, `Return Object`, `Use Shared Table`, `Shared Table Name`, `Smart Inline`, `Max Items for Inline`, `Max Length for Inline`). Primary Data Asset (préfixe conseillé `PDA_`) puis Data Asset (clic droit > Miscellaneous). | Avancé ; pas pour débutants. | Faible (données de jeu : métiers, équipes). |
| **Foliage2Lua** (`foliage2lua.mdx`) | Convertir un **acteur Foliage** du niveau en table Lua. | Ouvrir ; sélectionner un acteur foliage ; **Generate Lua**. Sortie : liste `{ StaticMesh = "pack::mesh", Instances = { { Location = Vector, Rotation = Rotator, Scale = Vector }, ... } }`. | Comment réutiliser la sortie : NON DOCUMENTÉ. **Déduction non testée** : les clés `Location`/`Rotation`/`Scale` sont celles de la table `instances` de `InstancedStaticMesh` [EXT-API `Classes/InstancedStaticMesh.json`], donc la sortie semble passable à `InstancedStaticMesh(..., instances)`. | Parcs : végétation répartie par script sans cooker les arbres. |
| **Quick Instancer** (`quick-instancer.mdx`) | Convertir des **Static Mesh actors** sélectionnés en **Instanced Static Mesh actor** (meilleures performances pour beaucoup de meshes identiques). | Ouvrir ; sélectionner des acteurs du niveau ; **Batch**. Réglages : `Replace Selected Actors`, `Center Pivot`, `Start Cull Distance`, `End Cull Distance`, `Use HISM`, `Use Single Actor`. | Valeurs conseillées : NON DOCUMENTÉ. Flag matériau « Used with Instanced Static Meshes » : exigé pour la classe Lua `InstancedStaticMesh` ; pour les acteurs de niveau, NON DOCUMENTÉ. | Parcs : clôtures, arbres, pavés répétés. |
| **Material Picker** (`material-picker.mdx`) | Identifier un matériau en **cliquant** dessus dans la vue. | Cliquer l'icône pipette puis une surface ; ensuite parcourir vers l'asset ou ouvrir l'éditeur de matériau. | — | Maisons : retrouver le matériau d'un mur à plusieurs matériaux. |
| **Static Mesh to Foliage** (`static-mesh-to-foliage.mdx`) | Convertir des static mesh actors en **types de foliage** « that can be painted on landscapes using the native foliage system ». | Ouvrir ; sélectionner des static mesh actors ; **Convert to Foliage**. | Le mode Foliage lui-même n'est pas décrit. | Parcs : peindre arbres/fleurs sur un terrain. |
| **Thumbnail Generator** (Forge, `thumbnail-generator.mdx`) | Vignettes **PNG** (avec **transparence** possible, traitement en masse) de Static/Skeletal Meshes. | Choisir une classe de profil (Static Mesh Profile / Skeletal Mesh Profile) > **Add** > renseigner les meshes > cadrer la caméra > régler > **Generate Thumbnail(s)**. Réglages : `View Location`, `View Rotation`, `Render Target Size`, `Show Only Output Actor`, `Post Process Material`. Transparence : `PPM_TranslucentThumbnail` + `Show Only Output Actor` (+ « Show Plugin Content » si invisible). | Sandbox attend des **`.jpg`** dans `Thumbnails/` (utiliser plutôt le générateur ADK). | Facultatif. |
| **Lua Profile** (`forge/advanced/lua-profile.mdx`) | Définir comment Forge **formate** le Lua (Vector en constructeur, Transform en table...). | Data Assets « Lua Struct Format Profile », « Lua Object Format Profile », « Lua Global Profile » ; profils intégrés : `LinearColorProfile`, `RotatorProfile`, `Vector2Profile`, `VectorProfile`, `TransformProfile`. | « still experimental and may change ». | À ignorer au début. |
| **ADK : Placeholder Blueprints** (`NanosWorld/Blueprints/Placeholders/`) | Poser des positions d'apparition de **Vehicles, Weapons, Characters, Props** ; **non cookés** avec la map. | Placer les blueprints dans le niveau. | Voir 0.2 n° 10. | Mobilier / points d'apparition. |
| **ADK : Lua Code Generator** (`NanosWorld/Blueprints/Utility/WBP_LuaCodeGenerator`) | Editor Utility Widget : parcourt la map **ouverte** et produit le code de spawn (position + rotation exacts) de chaque placeholder ADK. | Clic droit > **Run Editor Utility Widget**. | Format de sortie : NON DOCUMENTÉ. | Idem. |
| **ADK : Assets.toml Generator** (`WBP_AssetsTomlGenerator`) | Écrit la configuration `Assets.toml` d'un dossier (option : **bounds** des Static Meshes [BLOG `blog/2023-07-12-june.mdx`]). | Saisir le dossier à scanner dans la zone de texte. | Ne cite pas `unreal_folders`. | Évite de taper les clés à la main. |
| **ADK : BP_SunSky** (`NanosWorld/Blueprints/World/BP_SunSky`) | Soleil + ciel préconfigurés ; donne un **aperçu approximatif** de la lumière en jeu. | Glisser dans la vue. | Un `Sky.Spawn()` en jeu le **remplace** (réglages perdus). | Maisons, parcs, grottes (éclairage de base). |
| **ADK : Thumbnail Generator** (`NanosWorld/Blueprints/Utility/ThumbnailGenerator`) | Images `.jpg` des Static/Skeletal Meshes. | Ouvrir le niveau **ThumbnailGenerator**, **Play**, dossier de recherche et dossier de sortie, **Generate** (conseillé : le faire **deux fois**). | Peut être lent. | Facultatif. |

---

## 4. Points d'apparition, triggers, lumières, ciel, post-process, dimensions et interaction Lua / map

### 4.1 Où s'exécute quoi (important pour la map)

`Level`, `Sky`, `PostProcess`, `Navigation` et `Trace` sont des classes statiques **côté client uniquement** (« authority: client ») [EXT-API `StaticClasses/*.json`] ; les exemples de la doc les appellent dans `Client/Index.lua` [DOC `scripting-reference/static-classes/sky.mdx`, `trace.mdx`]. Le serveur « doesn't run the physics of the world » : les traces ne marchent que côté client [DOC `core-concepts/scripting/traces-and-raycasting.mdx`]. Entités créées sur le **serveur** = synchronisées à tous ; sur le **client** = locales [DOC `networking-and-replication.mdx`, `authority-concepts.mdx`].

### 4.2 Points d'apparition (spawn points)

| Information | Source |
|---|---|
| Se déclarent dans `spawn_points` du `Package.toml` map (chaînes `"Vector(...)"`, `"Rotator(...)"`). Recommandé : points d'apparition des joueurs dans `Package.toml`, positions de Props/armes/véhicules dans `Server/Index.lua` du package map. | `packages-guide.mdx`, EXT-SRV `_map.toml` |
| Lecture en Lua (serveur) : `Server.GetMapSpawnPoints()` (liste de tables `{ location, rotation }`) ; ajout dynamique : `Server.AddMapSpawnPoint(location, rotation)`. | EXT-API `StaticClasses/Server.json`, `core-concepts/scripting/player-lifecycle.mdx` |
| **Rien n'est automatique** : c'est le **game-mode** qui choisit un point (exemple : `spawn_points[math.random(#spawn_points)]`) et crée le `Character` ; sans game-mode on est un pion volant. Si la liste est vide, la doc propose le repli `Vector(0, 0, 100)`. | `player-lifecycle.mdx`, `getting-started/your-first-game-mode.mdx`, `quick-start.mdx` |
| Pas de « PlayerStart » Unreal cooké utilisé automatiquement : NON DOCUMENTÉ ; le seul équivalent cité est le placeholder Forge **`PlaceholderPlayerStart`** (export de position/rotation). | `forge/tools/placeholders.mdx` |
| Unités : Unreal utilise des **centimètres** ; `X` avant, `Y` droite, `Z` haut ; `Rotator(Pitch, Yaw, Roll)`. | `getting-started/essential-concepts.mdx` |

### 4.3 Triggers (zones)

Classe `Trigger` (authority « both ») : « utility class to trigger events when any Entity enters an Area ». Constructeur : `Trigger(location, rotation, extent, trigger_type = TriggerType.Sphere, is_visible = false, color = Color.RED, overlap_only_classes = {})` ; `extent` = rayon (sphère) ou `Vector` (boîte) ; formes : `Sphere` (0), `Box` (1) [EXT-API `Classes/Trigger.json`, `Enums.json`]. Événements : `BeginOverlap(self, entity)` et `EndOverlap(self, entity)` (côté « authority ») ; méthodes : `SetExtent`, `SetColor`, `SetOverlapOnlyClasses({ "Character", "CharacterSimple" })`, `ForceOverlapChecking`. `is_visible = true` sert au débogage. Exemple de la doc : sphère `Trigger(Vector(-200, 100, 500), Rotator(), Vector(100), TriggerType.Sphere, true, Color(1, 0, 0))` [DOC `scripting-reference/classes/trigger.mdx`]. Tutoriels officiels : **porte automatique** (`doors.mdx` : `StaticMesh` charnière `nanos-world::SM_None` + porte `SM_Plane`, `Trigger`, `RotateTo`, compteur de personnages, `actor:IsA(Character)`) et **pluie de Props** (`prop-rain.mdx`). Triggers optimisés en sept. 2025 (classes filtrées, acteurs proches seulement) [BLOG `blog/2025-10-08-september.mdx`]. **NON DOCUMENTÉ** : `extent` d'une boîte = demi-taille ou taille entière ; limite du nombre de triggers ; Trigger Volume placé dans Unreal.

### 4.4 Lumières

| Sujet | Information | Source |
|---|---|---|
| Classe `Light` | `Light(location, rotation = Rotator(0,0,0), color = Color(1,1,1), light_type = LightType.Point, intensity = 30, attenuation_radius = 250, cone_angle = 44, inner_cone_angle_percent = 0, max_draw_distance = 10000, use_inverse_squared_falloff = true, cast_shadows = true, visible = true, source_radius = 2, spawn_mode = SpawnMode.Immediate)` ; types `Point`, `Spot`, `Rect` ; `rotation` utile pour Spot et Rect ; méthodes `SetColor`, `SetIntensity`, `SetAttenuationRadius`, `SetCastShadows`, `SetTextureLightProfile` + getters ; **50 profils IES** (enum `LightProfile`). | EXT-API `Classes/Light.json`, `scripting-reference/classes/light.mdx` |
| Coût | Toutes dynamiques, « very expensive », ne pas en créer « 1000 ». | `light.mdx` |
| Lumières posées dans Unreal | Seule consigne documentée : Directional Light **Movable** ; tag `Sun` (R2). Les lumières point/spot d'Unreal placées dans le niveau : NON DOCUMENTÉ. Éclairage statique précalculé : pris en charge (R15). | `importing-maps.mdx`, [BLOG `blog/2024-02-28-february.mdx`] |
| Lumen | Le jeu l'utilise (blog 2022 : coût mesuré de 25 % à 50 % des FPS sur le jeu à l'époque ; réglable dans les options) ; Nanite et certaines fonctions de Lumen exigent DirectX 12. Réglages de projet de l'ADK : voir section 7 ; aucune consigne pour les auteurs de maps. | [BLOG `blog/2022-05-04-april.mdx`, `blog/2022-12-07-november.mdx`, `blog/2025-12-03-november.mdx`] |

### 4.5 Ciel (Sky), post-process, brouillard

- **Sky** intègre **Ultra Dynamic Sky** (UDS) ; `Sky.Spawn(spawn_weather = false, find_existing = true)` « replaces all Sky/Sun actors with the Ultra Dynamic Sky Actor » ; `find_existing = true` tente de **réutiliser** les acteurs Sky/Weather déjà présents dans la map. Méthodes principales : `SetTimeOfDay(hours, minutes, transition_time)`, `SetAnimateTimeOfDay`, `SetSunAngle`, `SetSunLightIntensity`, `SetMoon*`, `SetSkyMode(SkyMode)`, `SetCloudCoverage` (0 à 10), `SetFog` (0 à 100), `SetNightBrightness`, `ChangeWeather(WeatherType, transition_time)`, `GetWeather`, `IsSpawned`, `Reconstruct`, `DestroyAllSky` [EXT-API `StaticClasses/Sky.json`, DOC `static-classes/sky.mdx`]. `SkyMode` : `VolumetricClouds`, `StaticClouds` (« much lower performance cost »), `DynamicClouds2D`, `NoClouds`, `VolumetricAurora` [EXT-API `Enums.json`]. Les 13 `WeatherType` vont de `ClearSkies` à `SnowLight`. **Il faut appeler `Sky.Spawn()` d'abord** pour pouvoir utiliser les autres fonctions de `Sky`.
- Une map peut embarquer UDS **seulement avec la même version que le jeu** (R13) ; pour un débutant, préférer `BP_SunSky` (ADK) ou les acteurs de base + tag `Sun`.
- **PostProcess** (client) : `SetBloom`, `SetChromaticAberration`, `SetImageEffects` (vignette, grain), `SetExposure`, `SetFilm`, `SetGlobalSaturation/Gain/Gamma/Contrast/Offset`, `SetLookupTable`, `SetMaterial`, `RemoveMaterial` [EXT-API `StaticClasses/PostProcess.json`]. Un **Post Process Volume** posé dans Unreal : NON DOCUMENTÉ. Utile pour l'ambiance d'une grotte (assombrir, saturer) **par script**.
- Brouillard Unreal (`ExponentialHeightFog`) : cité seulement par `Sky.DestroyAllSky()` ; réglage à la création : NON DOCUMENTÉ.

### 4.6 Dimensions

Mondes séparés **côté client** (jusqu'à 65 535 dimensions, numérotées ; tout le monde est en `1` par défaut) : `actor:SetDimension(n)`, `player:SetDimension(n)` (serveur) ; changer un joueur de dimension détruit pour lui les entités des autres dimensions et fait apparaître celles de la nouvelle ; événement `DimensionChange` ; `Server.SetDefaultPlayerDimension/EntityDimension` ; `Events.BroadcastRemoteDimension` [DOC `core-concepts/scripting/dimensions.mdx`, EXT-API `Classes/BaseActor.json`]. **NON DOCUMENTÉ : ce qui arrive à la géométrie du niveau (le `.umap`) quand un joueur change de dimension.** Ne **pas** promettre « intérieurs de maisons dans une autre dimension » comme technique de map.

### 4.7 Level, Blueprint et entités du niveau

- `Level` (client) : `LoadStreamLevel`, `UnloadStreamLevel`, `SetStreamLevelVisibility`, `GetStreamLevels`, **`CallLevelBlueprintEvent(event_name, ...)`** (« Calls a Level Blueprint custom event (which can be added when creating levels through Unreal Engine) ») ; événements `StreamLevelLoad/Unload/Show/Hide/BeginPause/EndPause` [EXT-API `StaticClasses/Level.json`]. Nécessite de savoir créer un Level Blueprint : hors débutant.
- `Blueprint` : fait apparaître n'importe quel **acteur Blueprint** d'un Asset Pack (`[assets.blueprints]`) ; `CallBlueprintEvent`, `SetBlueprintPropertyValue`... [EXT-API `Classes/Blueprint.json`].
- **Entités du niveau** : les `StaticMeshActor` du niveau deviennent des `StaticMesh` côté client **si `load_level_entities = true`** ; `StaticMesh:IsFromLevel()` ; on peut alors les peindre, déplacer, détruire côté client [DOC `packages-guide.mdx`, `staticmesh.mdx` ; BLOG `blog/2022-04-06-march.mdx`, `blog/2023-02-01-january.mdx`].
- Tags : `actor:AddActorTag(tag)`, `RemoveActorTag`, `GetActorTags` (client) [EXT-API `Classes/BaseActor.json`].

### 4.8 Classes d'objets utiles pour décorer par script

| Classe | Côté | Points clés | Source |
|---|---|---|---|
| `StaticMesh` | les deux | `StaticMesh(location, rotation, static_mesh_asset, collision_type = Auto, spawn_mode)` ; « can't move and is more optimized » (mais la porte de `doors.mdx` en fait pivoter via `RotateTo` : contradiction à tester) | EXT-API, `staticmesh.mdx` |
| `Prop` | les deux | Physique, ramassable ; `Prop(location, rotation, asset, collision_type, gravity_enabled, grab_mode, ccd_mode, spawn_mode)` ; petits Props (< rayon 40) : CCD auto | `prop.mdx`, EXT-API |
| `InstancedStaticMesh` | les deux | Instances efficaces ; `instances` = table `{ Location, Rotation?, Scale? }` ; `AddInstances` (préférer à plusieurs `AddInstance`) ; masquer = échelle 0 ; matériaux « Used with Instanced Static Meshes » | `instancedstaticmesh.mdx`, EXT-API |
| `CollisionType` | enum | `Normal`, `StaticOnly`, `NoCollision`, `IgnoreOnlyPawn`, `Auto` | EXT-API `Enums.json` |
| `Decal` | client | Matériau projeté ; `M_Default_Translucent_Lit_Decal` | `decal.mdx`, `default-materials.mdx` |
| `Particle` | les deux | Niagara et Cascade ; `nanos-world::P_Fire` existe (torche) | `particle.mdx`, EXT-SRV `DefaultAssetPack.toml` |
| `Sound` | client | 2D/3D, `inner_radius`, `falloff_distance`, atténuations (Linear, Logarithmic, Inverse, Log Reverse, Natural) ; `SetLowPassFilter` (ambiances intérieur/grotte) | `sound.mdx`, EXT-API |
| `Text3D`, `Billboard` | les deux / client | Panneaux, enseignes (Text3D « experimental ») | `text3d.mdx`, `billboard.mdx` |
| `Navigation` | client | `GetRandomReachablePointInRadius`, `GetRandomPointInNavigableRadius`, `FindPathToLocation` | `navigation.mdx`, EXT-API |

Classes de base lues : `Entity` (Spawn/Destroy, `SetValue`...), `Actor` (location, scale, collision, visibilité, `SetRenderCullDistance`, `SetCastShadow`, attaches, `SetLifeSpan`...), `Paintable` (`SetMaterial`, paramètres Color/Scalar/Texture/Vector, `SetPhysicalMaterial`), `Pickable`, `Damageable`, `Pawn`, `Vehicle` (`scripting-reference/classes/base-classes/*.mdx`, EXT-API).

---

## 5. Intérieurs, parcs, grottes : ce que la doc permet, et ce qu'elle ne dit pas

### 5.1 Pièces du pack par défaut (voie Lua, **sans Unreal**) [EXT-SRV `DefaultAssetPack.toml`, référencé par `default-assets-list.mdx`]

Utilisables par `"nanos-world::<clé>"` ; leur taille, leur collision et leur rendu : NON DOCUMENTÉ (à mesurer en jeu avec `GetBounds()`, client).

| Besoin | Clés présentes dans le fichier |
|---|---|
| Maisons entières | `SM_House_01` à `SM_House_05`, `SM_Bamboo_House_03`, `SM_Bamboo_BoatHouse`, `SM_Metal_Shack_04/05/06`, `SM_Metal_Shack_GuardTower`, `SM_Metal_Shack_Outhouse` |
| Pièces modulaires | `SM_PlasterWall_01/02/03/08`, `SM_Bamboo_Wall_01`, `SM_Bamboo_Roof45_Right`, `SM_Window_05`, `SM_Wood_Stairs_02`, `SM_Wood_Platform_10`, `SM_WoodenSlab_1_3x3`, `SM_TimberPlank`, `SM_TimberRailing`, `SM_TimberStructure_09`, `SM_Cantilever`, `SM_Ladder_02` |
| Intérieur | `SM_Bed`, `SM_BedFrame`, `SM_BunkBed`, `SM_WoodenTable`, `SM_WoodenChair`, `SM_Stool`, `SM_CoffeeTable`, `SM_Carpet_01/02`, `SM_OilLamp`, `SM_Lamp`, `SM_Crate_01/02/03/04`, `SM_Pot_01/02`, `SM_Basket_01/02` |
| Parc / extérieur | `SM_Bench`, `SM_BeachFence_02`, `SM_ClothesLine`, `SM_Dock_01/02`, `SM_StreetLamp`, `SM_LightPole_A`, `SM_MailBox_01`, `SM_TrashCan_01`, panneaux `SM_StreetSigns_*` |
| Nature | `SM_Tree_Acacia_01/02`, `SM_Tree_Almond_01/02/03`, `SM_Tree_Palm_01/02/03`, `SM_Bush_01`, `SM_Buttercup`, `SM_HeatherClumps`, `SM_Scabious`, `SM_Rock_03` à `SM_Rock_07` |
| Formes de base | `SM_Cube`, `SM_Plane`, `SM_Cylinder`, `SM_Cone`, `SM_Sphere`, `SM_Wedge_A/B`, `SM_Pipe`, `SM_Tube`... |
| Effets | `nanos-world::P_Fire` (particule), lumière via classe `Light` |

Ces clés ne sont **pas** des acteurs placés dans l'éditeur Unreal : le dossier de contenu `NanosWorldMaps/...` n'est pas décrit dans l'ADK (NON DOCUMENTÉ : présence dans le projet ADK).

### 5.2 Intérieurs (maisons)

- **Documenté** : import de meshes (FBX), matériaux, collisions simples, LODs, matériaux physiques (bruits de pas), lumières, portes par script (Trigger + `RotateTo`), meubles par Lua, placeholders pour poser meubles/points d'apparition.
- **NON DOCUMENTÉ** : éclairage intérieur dans Unreal (fuites de lumière, éclairage statique/Lumen), occlusion, dimensions de référence (porte, plafond : la taille du `Character` par défaut n'est pas donnée ; on peut la **mesurer** avec `Pawn:GetCapsuleSize()` [EXT-API `Classes/BasePawn.json`]), portes dans le niveau (R1 : objet mobile = script), intérieurs par dimension (4.6).

### 5.3 Parcs

- **Documenté** : `Landscape` cité comme composant habituel d'un niveau (« usually filled with a Landscape component to make the terrain ») [DOC `importing-maps.mdx`] ; foliage via **Forge** (Static Mesh to Foliage, Foliage2Lua, Quick Instancer) ; **eau** (Water Plugin, buoyancy) ; arbres, rochers, bancs, lampadaires du pack par défaut ; `InstancedStaticMesh` pour répéter ; **PCG** autorisé (R13).
- **NON DOCUMENTÉ** : création/sculpture d'un Landscape, tailles recommandées, matériaux de terrain, collision du Landscape en jeu, mode Foliage, coût en jeu de l'herbe (seule anecdote : R24), chemins.

### 5.4 Grottes

**La doc ne dit rien sur les grottes** (aucune occurrence de `cave` dans `docs/` ni `blog/`). Aucun asset de grotte dans `DefaultAssetPack.toml` (recherches `cave`, `tunnel`, `mine`, `stalac`, `underground` : rien ; seul `SM_Rock_03..07` existe). Ce qui est **documenté et réutilisable** pour une grotte : import FBX + collisions (R11), `PM_Rock` pour les bruits de pas [DOC `default-materials.mdx`], `Light` (R15), `Particle` `P_Fire`, `Sound` avec `SetLowPassFilter`, `PostProcess` par script, `SkyMode.NoClouds`, tag `Sun` (le soleil de la map peut être supprimé par un script). **Les méthodes de construction de la grotte sont des connaissances générales NON VÉRIFIÉES** : voir 6.2.

---

## 6. Connaissances générales d'Unreal NON VÉRIFIÉES dans ce dépôt

> **Tout ce qui suit vient de la connaissance générale du rédacteur, pas des fichiers lus.** Les auteurs doivent le **vérifier sur la doc d'Epic** (`dev.epicgames.com`, inaccessible depuis le conteneur) avant de l'affirmer, et le marquer « non vérifié » en attendant. Les liens Epic de la colonne 3 sont ceux **cités par la doc Nanos** (existence du lien non testée).

### 6.1 Notions standard

| Notion | Pourquoi dans le parcours | Où vérifier (liens cités par la doc Nanos) | Statut |
|---|---|---|---|
| Acteurs, composants, Outliner, panneau Details, panneau Place Actors | Poser et régler des objets | `.../levels-in-unreal-engine` ; la doc Nanos ne cite que « Place Actors -> Basic » | à vérifier |
| Niveaux, World Settings, sous-niveaux | Créer la map | `.../managing-multiple-levels-in-unreal-engine` | à vérifier |
| Content Browser / Content Drawer, glisser-déposer FBX, copier un asset sans le déplacer à la main (redirecteurs, « Fix Up Redirectors ») | Organiser le pack ; R7 | — | à vérifier |
| Navigation dans la vue : clic droit + WASD, `F` (documentés, page ancienne) ; molette = vitesse de caméra, Alt + clic = orbite, `W/E/R` = déplacer/tourner/échelle, `End` = poser au sol, Alt + glisser = dupliquer, `Ctrl+S` | Gagner du temps | — | à vérifier (seuls clic droit + ZQSD et `F` viennent de la doc) |
| Matériaux, PBR, nœuds, Material Instance | Couleurs, variations | `.../unreal-engine-materials`, `.../physically-based-materials-in-unreal-engine`, `.../material-inputs-in-unreal-engine`, `.../material-blend-modes-in-unreal-engine` | à vérifier |
| Lumières : Directional, Sky Light, Point, Spot, Rect ; mobilité Static / Stationary / Movable | Éclairer maisons et grottes | — | à vérifier (seule consigne de la doc : Directional en Movable) |
| Lumen, Nanite, Virtual Shadow Maps, MegaLights (5.7), Substrate | Rendu et coût mémoire | blog Nanos 2022 et 2025 (non officiel pour Epic) ; réglages de l'ADK : section 7 | à vérifier |
| Lightmass, « build lighting », UV de lightmap, éclairage statique | Intérieurs sans Lumen | — | à vérifier |
| Static Mesh Editor : collision simple / complexe, pivot, sockets, LODs | Collisions de grotte | `.../static-meshes`, `.../setting-up-collisions-with-static-meshes-in-unreal-engine`, `.../creating-and-using-lods-in-unreal-engine` | à vérifier |
| Modeling Mode (outils de géométrie) | Murs, pièces, booléens | blog 2022 : « built-in modeling and mesh editing tools » seulement | à vérifier |
| Landscape (sculpter, peindre, calques, résolution), trou/visibilité de Landscape | Parcs, entrée de grotte | — | à vérifier |
| Foliage Mode (peindre), PCG | Parcs | `.../PCG` (tutoriel communautaire cité) | à vérifier |
| Volumes : Nav Mesh Bounds, Post Process, Blocking | NavMesh, ambiance | `.../basic-navigation-in-unreal-engine` | à vérifier |
| Brouillard et atmosphère (`ExponentialHeightFog`, `SkyAtmosphere`, nuages volumétriques) | Ambiance | `.../sun-and-sky-actor-in-unreal-engine` | à vérifier |
| Water Plugin (rivières, lacs) | Étang de parc | `.../water-system-in-unreal-engine` | à vérifier |
| Snapping, grille, pièces modulaires (dimensions de kit) | Maisons rapides | — | à vérifier |
| Unité = **1 cm** | Dimensions | documenté : `essential-concepts.mdx` | DOC ; tailles humaines typiques : à vérifier |
| Lancer le niveau dans l'éditeur (Play) | Contrôle rapide | l'ADK dit « hit Play » pour son niveau ThumbnailGenerator | à vérifier pour une map de joueur |
| Export FBX depuis Blender (axes, échelle, « Combine Meshes ») | Petits objets | `.../static-meshes` (la doc Nanos montre l'échelle ×10 à l'import) | à vérifier |

### 6.2 Réglages « petite machine » (16 Go de RAM) : tous NON VÉRIFIÉS

| Piste | Détail | Statut |
|---|---|---|
| Fermer navigateur, Discord, Steam, jeu avant Unreal | Libère la RAM | à vérifier (bon sens, pas une exigence Epic) |
| Réglages de qualité de l'éditeur (Engine Scalability), viewport en temps réel limité, « moins de CPU en arrière-plan » | Économiser RAM/GPU | à vérifier |
| Désactiver Lumen / ray tracing **pour l'éditeur seulement** ; mais l'ADK les active (`r.RayTracing=True`, DX12 SM6, Substrate) [EXT-ADK] | Gain mémoire | à vérifier ; **risque** : l'impact sur la compatibilité du cook est NON DOCUMENTÉ ; la doc demande de **sauvegarder `Config/`** avant une mise à jour de l'ADK |
| Fichier d'échange Windows (page file) assez grand, projet sur SSD, chemin court sans espaces | Éviter les plantages | à vérifier |
| Petites maps, peu de textures 4K, LODs, sauvegardes fréquentes | Rester dans la RAM | R9, R10 sont documentés ; le reste à vérifier |
| Cache de shaders (`DerivedDataCache/`) : volumineux, supprimable pour un recook propre (documenté) | Disque | taille NON DOCUMENTÉE |

### 6.3 Méthodes de grotte (NON VÉRIFIÉES, aucune confirmation par Nanos)

1. **Couloir modulaire** : assembler des meshes de roche ou de murs (cubes, `SM_Rock_*` si présents dans l'éditeur : NON DOCUMENTÉ) pour former galerie + salle. Le plus sûr, l'aspect « naturel » n'est pas garanti.
2. **Mesh unique modélisé dans Blender** puis importé en FBX (pipeline FBX > Static Mesh > collision : DOC `static-meshes.mdx`). Risque : collision d'un mesh **concave** (collision simple « Add Box Collision » insuffisante ; collision complexe ou décomposition : comportement en jeu NON DOCUMENTÉ ; les traces connaissent `TraceMode.TraceComplex` [DOC `trace.mdx`]).
3. **Landscape + entrée** (trou ou rochers autour) : dépend du mode Landscape (non documenté).
4. **Outils de génération** autorisés par la liste blanche : *Geometry Scripting*, *PCG* (R13) ; non documentés pour les grottes.
5. **Modeling Mode** (booléens/extrusion) : outils cités seulement par le blog 2022.
6. Éclairage de grotte : sombre, quelques `Light` (ou lumières Unreal), brouillard léger, sons ; rappel : un script peut **supprimer** soleil, ciel et brouillard marqués `Sun` (R2).

Conclusion honnête : **le parcours F ne peut pas garantir une grotte naturelle** ; il peut garantir une **galerie rocheuse modulaire jouable** si les collisions sont testées en jeu (sinon : « non testé »).

---

## 7. Matériel : PC fixe (Core i5-14400F, RTX 5060 Ti 16 Go, 16 Go de RAM, Windows 11) face à la doc

| Élément | Ce que dit la doc Nanos | Comparaison avec le PC fixe |
|---|---|---|
| Configuration minimale d'**Unreal / de l'ADK** | **NON DOCUMENTÉ** (aucune page). | Impossible de conclure. Le dépôt du cours cite « Epic recommande 32 Go » : **non vérifié** (page non ouverte, `ETAT_AVANCEMENT_COURS.md`). |
| Configuration minimale du **jeu (client)** | **NON DOCUMENTÉ**. Seuls des conseils de dépannage : mettre à jour les pilotes, basculer DX12/DX11 (`-dx11` / `-dx12`), désactiver ray tracing, overlays, overclocking. | — |
| Configuration minimale du **serveur** | OS Windows ou Linux ; processeur **2 × 1,0 GHz** ; mémoire **50 Mo** (croît avec joueurs/entités) ; stockage **30 Mo** + assets ; réseau ≥ 1 Mo/s ; ports `7777` TCP/UDP et `7778` UDP ; Windows : *Microsoft Visual C++ Redistributable* (`server-manual/server-installation.mdx`). | Largement satisfait ; **le serveur ne demande pas Unreal ni GPU** : il peut tourner sur le portable pour valider les `Package.toml`. |
| Système | `Windows 11 SDK (10.0.26100.0)` ; version minimale de Windows : NON DOCUMENTÉ. | Windows 11 : cohérent. |
| Processeur Intel 13e/14e gén. | « Intel 13th & 14th Gen CPU Instability » (exemples cités : i7/i9) : mettre le **BIOS** à jour (microcode « Intel Default Settings ») ; plantage possible pendant la compilation de shaders (`troubleshooting.mdx`, n° 7). | Le nom `i5-14400F` indique la 14e génération (déduction, à vérifier) ; la doc ne cite pas les i5. Précaution peu coûteuse : BIOS à jour. |
| GPU | RHI par défaut **DX12** depuis 2022 (« Nanite, Lumen and Virtual Shadow Maps run more efficiently in DX12 ») ; l'ADK cible DX12 SM6 [BLOG `blog/2022-05-04-april.mdx`, EXT-ADK]. Aucune carte nommée. | La RTX 5060 Ti n'est pas citée : support non vérifiable ici. Pilotes à jour (doc). |
| RAM de l'éditeur | NON DOCUMENTÉ. | 16 Go : inconnu ; voir 6.2. |
| Disque | NON DOCUMENTÉ (taille d'Unreal, de l'ADK, des caches). Seuls chiffres : 5 Mo par texture 2048², 380 Ko en 512² ; exemple extrême d'un pack de ±130 000 fichiers (±50 Go) [BLOG `blog/2024-10-20-october.mdx`]. | À mesurer le jour de l'installation (le Launcher affiche la taille). |
| Deux machines | Cookés + Git : utiliser Git LFS, sinon « not a great solution » (R22). | Ne pas synchroniser les assets cookés par un dépôt ordinaire. |

---

## 8. Lexique anglais / français (40 termes)

Les termes marqués (D) apparaissent dans les pages lues ; la traduction est celle du rédacteur.

| # | Anglais | Français |
|---|---|---|
| 1 | Asset (D) | ressource / asset (fichier de contenu) |
| 2 | Asset Pack (D) | pack d'assets (dossier sous `Assets/` avec `Assets.toml`) |
| 3 | ADK, Assets Development Kit (D) | kit de développement d'assets (projet Unreal fourni) |
| 4 | Cook / Cooking (D) | « cuisson » : conversion des assets en fichiers lisibles par le jeu |
| 5 | Level / Map (D) | niveau / carte |
| 6 | Content Browser / Content Drawer (D) | navigateur de contenu / tiroir de contenu |
| 7 | Actor (D) | acteur (objet placé dans un niveau) |
| 8 | Static Mesh (D) | maillage statique (objet 3D fixe) |
| 9 | Skeletal Mesh (D) | maillage squelettique (personnages, véhicules) |
| 10 | Material (D) | matériau (couleur, rendu de surface) |
| 11 | Material Instance (D) | instance de matériau (variante réglable) |
| 12 | Texture (D) | texture (image plaquée) |
| 13 | Physical Material (D) | matériau physique (frottement, sons de pas) |
| 14 | Collision (D) | collision (ce qui bloque) |
| 15 | LOD, Level of Detail (D) | niveau de détail (version simplifiée de loin) |
| 16 | Landscape (D) | terrain / paysage |
| 17 | Foliage (D) | végétation |
| 18 | Instanced Static Mesh (D) | maillage statique instancié (copies identiques efficaces) |
| 19 | Trigger (D) | déclencheur (zone) |
| 20 | Spawn point (D) | point d'apparition |
| 21 | Placeholder (D) | marqueur (emplacement réservé exporté en Lua) |
| 22 | Directional / Point / Spot / Rect light (D) | lumière directionnelle / ponctuelle / projecteur / rectangulaire |
| 23 | Sky Light (D) | lumière de ciel |
| 24 | Sun (tag) (D) | soleil (étiquette d'acteur) |
| 25 | Post Process (D) | post-traitement (effets d'image) |
| 26 | NavMesh, Navigation Mesh (D) | maillage de navigation (chemins des PNJ) |
| 27 | Blueprint (D) | blueprint (script visuel / classe Unreal) |
| 28 | Plugin (D) | extension |
| 29 | Viewport (D) | fenêtre de vue 3D |
| 30 | World Settings (D) | réglages du monde |
| 31 | GameMode override (D) | surcharge du mode de jeu Unreal |
| 32 | Dimension (D) | dimension (monde séparé côté client Nanos) |
| 33 | Stream Level / Level Streaming (D) | niveau en streaming |
| 34 | World Partition (D) | partition du monde |
| 35 | Pivot (D) | pivot (point d'ancrage d'un objet) |
| 36 | Rotator (Pitch, Yaw, Roll) (D) | rotation (tangage, lacet, roulis) |
| 37 | Vector (X, Y, Z) (D) | vecteur / position (X avant, Y droite, Z haut) |
| 38 | Unreal unit (1 uu = 1 cm) (D) | unité Unreal (1 unité = 1 cm) |
| 39 | Prop (D) | objet physique / accessoire |
| 40 | Authority (D) | autorité (côté qui a créé l'entité) |

---

## 9. Plan conseillé : parcours F en 8 modules (≈ 28 h)

Hypothèses : débutant complet, **PC fixe uniquement**, **aucun accès au jeu au départ**, Unreal 5.7.X. Étapes de 15 à 20 min (identifiants `F1-e1`...). **[V]** = étape décrite dans la doc ; **[NV]** = non vérifiée ; **[T]** = nécessite le client du jeu.

**Règle d'honnêteté du parcours** : sans le client, on ne peut valider que l'export (dossier cooké, `Assets.toml`, `Package.toml`) et le démarrage du serveur (le serveur ne charge pas le `.umap`). Chaque module a donc un **plan B**.

| Module | Titre | Durée |
|---|---|---|
| F1 | Installer Unreal 5.7.X et l'ADK | 3 h |
| F2 | Prendre en main l'éditeur : premier niveau | 3,5 h |
| F3 | Premier export de bout en bout | 4 h |
| F4 | Une petite maison (extérieur) | 3,5 h |
| F5 | Intérieurs : pièces, lumières, portes | 3,5 h |
| F6 | Un petit parc | 3,5 h |
| F7 | Une galerie / grotte (expérimental) | 4 h |
| F8 | Optimiser, assembler le village de test | 3 h |

### F1 : Installer Unreal 5.7.X et l'ADK (3 h)

- **Objectifs** : installer Unreal, le Windows SDK, l'ADK ; comprendre le pipeline en 6 phases (1.2).
- **Étapes** : F1-e1 lire le schéma Map = pack cooké + package map + Config [V] ; e2 Launcher + Unreal 5.7.X [V] ; e3 Windows SDK 10.0.26100.0 [V] ; e4 lancer Unreal une fois [V] ; e5 télécharger/extraire l'ADK [V] ; e6 ouvrir `NanosWorldADK.uproject` (compilation des shaders) [V] ; e7 repérer `NanosWorld/` (intouchable) et `MyAssetPack/` [V] ; e8 réglages 16 Go (6.2) [NV] ; e9 lire la version du jeu dans la console serveur [V, T ou serveur seul].
- **Vérifié** : versions, étapes, avertissement `NanosWorld/`. **Non vérifié** : tailles, durée, RAM, besoin de Visual Studio (0.2 n° 8).
- **Mini-projet** : capture de l'ADK ouvert + fiche « mon environnement » (version d'Unreal, chemin de l'ADK).
- **Plan B** : aucun besoin du jeu. Si Unreal plante à l'ouverture : doc `importing-assets.mdx` (vérifier l'installation dans le Launcher).

### F2 : Prendre en main l'éditeur : premier niveau (3,5 h)

- **Objectifs** : créer un niveau dans **son** dossier, le remplir et l'éclairer.
- **Étapes** : e1 dossier unique dans `Content/` [V] ; e2 nouveau Level [V] ; e3 navigation (clic droit + WASD, `F`) [V], autres raccourcis [NV] ; e4 sol : Plane copié dans son dossier, échelle 10, position 0 [V] ; e5 Directional Light **Movable** + Sky Light [V] ; e6 `BP_SunSky` [V] ; e7 matériau `M_Sol` : `Constant3Vector` → Base Color [V] ; e8 meubler avec cubes/cylindres (copiés depuis `BasicShapes`) [V pour le principe] ; e9 règles R1 à R3 (tag `Sun`, GameMode None) [V, page ancienne] ; e10 capture `.webp`.
- **Vérifié** : séquence de `importing-maps.mdx` (**ancienne**, UE4). **Non vérifié** : noms de menus en 5.7, glisser-déposer depuis « Place Actors > Basic », mobilité des lumières hors Directional.
- **Mini-projet** : « plateau d'essai » : sol vert, quelques volumes, soleil.
- **Plan B** : aucun besoin du jeu.

### F3 : Premier export de bout en bout (4 h)

- **Objectifs** : cooker, fabriquer l'Asset Pack et le package map, charger la map.
- **Étapes** : e1 « Cook only maps » + liste de maps [V] ; e2 **Platforms > Cook Content > Cook Content** [V] ; e3 trouver `Saved/Cooked/Windows/NanosWorldADK/` [V] ; e4 créer `Assets/mon-pack/` (kebab-case) et copier les dossiers cookés [V] ; e5 écrire `Assets.toml` (`unreal_folders`, `unreal_version`, `[assets.maps]`) [V] ; e6 installer le serveur (SteamCMD, `login anonymous`, app `1936830`) [V] ; e7 `--cli add package ... map` ou `Package.toml` à la main [V] ; e8 régler `map_asset`, `assets_requirements`, `spawn_points` [V] ; e9 `Config.toml` `map = "..."`, démarrer le serveur [V] ; e10 **[T]** rejoindre `127.0.0.1:7777` et survoler la map en pion volant [V] ; e11 lire les journaux si échec [V] ; e12 (option) essayer **Forge Cook Handler** [V pour les réglages, résultat NON DOCUMENTÉ].
- **Vérifié** : toute la chaîne, dont les messages d'erreur. **Non vérifié** : tout ce qui concerne le comportement réel (aucun test possible ici).
- **Mini-projet** : le plateau d'essai de F2 **visible en jeu**.
- **Plan B (sans jeu)** : s'arrêter à e9 sans erreur au démarrage du serveur ; mettre « non testé en jeu » ; le portable peut héberger le serveur pour contrôler le `Package.toml`.
- **Piège à signaler** : suivre `importing-assets.mdx` (chemins avec dossier racine), pas l'exemple de `importing-maps.mdx` (0.2 n° 3).

### F4 : Une petite maison (extérieur) (3,5 h)

- **Objectifs** : modularité, collisions, matériaux, nommage.
- **Étapes** : e1 convention de noms `SM_`/`M_`/`MI_`/`T_` [V] ; e2 maison en volumes de base (murs, toit, ouverture de porte) [V pour le principe, gestes NV] ; e3 pièces répétées (copier-coller) [NV] ; e4 collisions : vérifier `Show > Simple Collision`, « Add Box Collision » [V] ; e5 matériaux et `PM_*` (bois, béton) [V] ; e6 LODs = 3 (si mesh importé) [V] ; e7 importer un petit FBX (« Combine Meshes », échelle) [V] ; e8 textures ≤ 2048, réduire [V] ; e9 **comparaison** : la même maison en Lua avec `SM_House_01`... [V pour les clés, rendu NON DOCUMENTÉ] ; e10 recook + test [V, T].
- **Vérifié** : R4 à R12. **Non vérifié** : Modeling Mode, snapping, kit modulaire (6.1).
- **Mini-projet** : « la maison témoin » (4 murs + toit + porte ouverte), jouable.
- **Plan B** : version Lua seule sur `default-blank-map` (pas d'Unreal).
- **Limite** : la doc ne donne pas les dimensions d'une porte ou d'un personnage ; les mesurer en jeu (`GetCapsuleSize`, `GetBounds`) ou les marquer « à vérifier ».

### F5 : Intérieurs : pièces, lumières, portes (3,5 h)

- **Objectifs** : une pièce meublée, éclairée, avec une porte qui s'ouvre.
- **Étapes** : e1 cloisons et plafond [V pour le principe] ; e2 meubles du pack par défaut en Lua (`SM_Bed`, `SM_WoodenTable`...) [V pour les clés] ; e3 lumière intérieure par script : `Light(...)` avec `max_draw_distance` [V] ; e4 **porte automatique** de `doors.mdx` (Trigger + `RotateTo`) [V] ; e5 zone d'entrée avec `Trigger` `Box` visible (`is_visible = true`) [V] ; e6 points d'apparition dans la maison via `spawn_points` [V] ; e7 (option) placeholders Forge pour poser les meubles à l'œil [V pour les réglages, export NON DOCUMENTÉ] ; e8 matériaux physiques (`PM_Wood`, `PM_Concrete`...) [V] ; e9 éclairage Unreal intérieur (statique/Lumen) [NV, **ne pas affirmer**] ; e10 test [T].
- **Vérifié** : classes Light, Trigger, StaticMesh, tutoriel de porte. **Non vérifié** : éclairage Unreal intérieur, occlusion, fuites de lumière.
- **Mini-projet** : « chambre » meublée avec porte automatique, 3 lumières.
- **Plan B** : tout se fait en Lua sur `default-blank-map` (aucun Unreal, mais le jeu reste nécessaire pour voir).
- **À ne pas promettre** : intérieurs par dimension (4.6).

### F6 : Un petit parc (3,5 h)

- **Objectifs** : terrain, chemins, végétation, mobilier, option eau.
- **Étapes** : e1 terrain : Landscape [NV, la doc ne le décrit pas] **ou** sol en plans [V] ; e2 chemins (plans texturés) [NV] ; e3 arbres/rochers du pack en Lua (`SM_Tree_*`, `SM_Rock_*`, `SM_Bush_01`) [V pour les clés] ; e4 mobilier (`SM_Bench`, `SM_StreetLamp`) [V] ; e5 répéter par script avec `InstancedStaticMesh` + `AddInstances` [V] ; e6 (option Forge) Static Mesh to Foliage, Foliage2Lua, Quick Instancer [V pour les réglages, usage NON DOCUMENTÉ] ; e7 étang avec Water Plugin + `enable_water_buoyancy = true` [V, mais installation de Visual Studio NON DOCUMENTÉE] ; e8 ciel : après `Sky.Spawn()`, `Sky.SetTimeOfDay`, `SetCloudCoverage` côté client [V] ; e9 test [T].
- **Vérifié** : eau, Instanced Static Mesh, Sky, pack par défaut. **Non vérifié** : Landscape, Foliage Mode, ombres de l'herbe (R24).
- **Mini-projet** : « parc » avec 3 bancs, 10 arbres, un lampadaire, un chemin.
- **Plan B** : parc 100 % Lua sur `default-blank-map`.

### F7 : Une galerie / grotte (expérimental) (4 h)

- **Objectifs** : un espace souterrain **jouable** (collisions testées) ; le rendu naturel n'est pas un objectif garanti.
- **Étapes** : e1 lire 5.4 (rien n'est documenté) ; e2 construire une galerie modulaire (6.3, méthode 1) [NV] ; e3 collisions : tester en jeu que le joueur ne traverse pas les parois [NV, T] ; e4 lumière sombre : quelques `Light` côté serveur [V] ; e5 ambiance : `Sound` avec `SetLowPassFilter`, `Particle` `P_Fire` [V] ; e6 ambiance image : `PostProcess` côté client [V] ; e7 `Sky.SetSkyMode(SkyMode.NoClouds)` et tag `Sun` [V] ; e8 essai optionnel d'un mesh Blender (méthode 2) [NV] ; e9 mesures de performance (FPS) [NV] ; e10 rapport « ce qui marche / ne marche pas ».
- **Vérifié** : outils de script (Light, Sound, PostProcess, Particle, Sky). **Non vérifié** : **toute** la construction (section 6.3), les collisions concaves.
- **Mini-projet** : « galerie de 3 salles » avec torche.
- **Plan B** : galerie en volumes de base (cubes) : jouable, peu naturelle ; dire clairement « non garanti ».

### F8 : Optimiser, assembler le village de test (3 h)

- **Objectifs** : réunir maison + parc + galerie dans une map, vérifier les performances, préparer le projet fil rouge.
- **Étapes** : e1 `Cook only maps` ; ne cooker que le nécessaire [V] ; e2 réduire textures/lumières/translucides (R9, R14, R15) [V] ; e3 `load_level_entities = false`, `enable_water_buoyancy` seulement si eau [V] ; e4 NavMesh : savoir qu'il est requis pour les PNJ [V], création [NV] ; e5 points d'apparition multiples (`spawn_points`) [V] ; e6 `Server/Index.lua` du package map : spawn des Props/meubles [V] ; e7 vignette `.webp` + `Assets.jpg` 300x150 [V] ; e8 recook propre : supprimer `Saved/`, `Intermediate/`, `DerivedDataCache/` en cas de souci [V] ; e9 liste de contrôle finale [T] ; e10 sauvegarde du projet **hors Git simple** (LFS) [V, R22] ; e11 (option) publication Vault : jeton jamais dans le dépôt [V].
- **Vérifié** : réglages de `Package.toml`, recook, vignettes. **Non vérifié** : seuils de performance (aucune limite chiffrée dans la doc).
- **Mini-projet** : **le village de test** (maison + parc + galerie), réutilisé par le projet fil rouge (parcours G).
- **Plan B** : si l'accès au jeu manque encore, livrer le dossier cooké + `Assets.toml` + `Package.toml` + journal serveur, étiquetés « non testé en jeu ».

---

## Annexe A : ce qui a été lu (couverture)

- **Lus en entier** : `assets-modding/creating-assets/{setting-up-ue, adk-assets-development-kit, importing-assets}.mdx`, `maps-and-levels/{importing-maps, water}.mdx`, `static-meshes/static-meshes.mdx`, `assets-modding/forge/**` (setup, 7 outils, lua-profile), `assets-modding/default-asset-pack/{default-assets-list, default-materials}.mdx`, `assets-modding/whitelisted-ue-plugins.mdx`, `core-concepts/assets.mdx`, `core-concepts/packages/{packages-guide, package-loading-and-lua-environment, compatibility-versions}.mdx`, `core-concepts/scripting/dimensions.mdx`, `vault-and-store/{vault, store}.mdx`, `getting-started/editor-setup.mdx` (c'est la page **VS Code**, rien sur l'éditeur Unreal), `scripting-reference/{classes, static-classes, classes/base-classes}/*.mdx` demandés.
- **Lus en survol (demandé)** : `skeletal-meshes/*` (3 pages), `animations/**` (4 pages), `default-particles`, `default-weapons`, `packages/c-module`, `packages/loading-screen` : rien de spécifique aux maps (hors `Config.toml` d'exemple de `c-module.mdx`).
- **Lus en plus** : `quick-start`, `your-first-game-mode`, `essential-concepts`, `tutorials-and-examples/{doors, prop-rain}`, `server-manual/{server-configuration, server-installation, command-line-interface}`, `core-concepts/{server-and-client-lifecycle, scripting/{authority-concepts, networking-and-replication, player-lifecycle, artificial-intelligence, traces-and-raycasting}}`, `troubleshooting`, `signing-up-alpha`, `welcome`, `roadmap`, `explore/*` (grep), `scripting-reference/glossary/*` (grep).
- **Blog** (55 articles, 2020 à sept. 2026) : recherche par mots-clés (map, level, ADK, forge, cook, foliage, landscape, lumen, nanite, navmesh, spawn point, collision, world partition, UE 5.x) et lecture des passages utiles de : 2022-02, 2022-03, 2022-04, 2022-05, 2022-08, 2022-12 (x2), 2023-02, 2023-04, 2023-06, 2023-07, 2023-12, 2024-02, 2024-10, 2025-04, 2025-06, 2025-08, 2025-09, 2025-10, 2025-12, 2026-02, 2026-03, 2026-04, 2026-05.
- **Recherches sans résultat utile** dans `docs/` et `blog/` : `lightmass` (0), `cave` (0), `interior` (2, hors sujet), `PlayerStart` (1, Forge), `landscape` (3).
- **Hors dépôt docs** : fichiers EXT-SRV, EXT-API, EXT-ADK (voir légende). `docs.nanos-world.com` et `dev.epicgames.com` : accès refusé (HTTP 403 du proxy).

## Annexe B : trous de la documentation (à ne pas combler par supposition)

1. Aucune procédure à jour pour créer une map (la page unique est de l'ère UE4).
2. Aucune configuration minimale ou recommandée pour Unreal, l'ADK ou le client ; aucune taille de disque.
3. Rien sur les grottes, les intérieurs, l'éclairage dans l'éditeur (statique, Lumen), les collisions concaves, le Landscape, le mode Foliage, la création du NavMesh.
4. Sortie et réutilisation exactes des outils Forge d'export (Placeholders, Foliage2Lua) ; comportement exact du Cook Handler ; conversion en `spawn_points`.
5. Comportement de la géométrie du niveau avec les dimensions.
6. Aucune limite chiffrée (taille de map, nombre de lumières, d'acteurs, de triangles).
7. Version exacte de patch d'Unreal acceptée par le jeu ; valeur courante de `compatibility_version` à écrire dans une nouvelle map.
8. Présence actuelle des outils ADK « redondants » (Placeholders, Lua Code Generator) après la simplification annoncée.
9. Nécessité réelle de Visual Studio / .NET pour le Water Plugin.

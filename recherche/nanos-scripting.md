# Fiche de référence vérifiée : scripts Nanos World (parcours E)

Document technique pour les auteurs du parcours E « Scripts Nanos World ». Rédigé le 2026-10-06.
Règle de rédaction : chaque élément ci-dessous vient d'une page ou d'un fichier effectivement lu. Quand la documentation ne dit rien, c'est écrit **NON DOCUMENTÉ**. Quand deux sources se contredisent, c'est signalé (section 11).

---

## 0. Sources, méthode et limites de cette fiche

### 0.1 Sources lues

| Sigle | Source | Version |
|---|---|---|
| **D** | `/home/user/nanos-world/docs/docs/` (pages `.mdx` du site docs.nanos-world.com) | commit `46a50bb` du 1er oct. 2026 (« updated feedback/bugs links »), vérifié |
| **A** | Dépôt `nanos-world/api` (fichiers JSON qui génèrent toutes les listes de fonctions, événements et paramètres du site) | commit `dd415c8b4e6ba212ae1fb926c48019be03d7ba1d`, celui que le dépôt de docs épingle comme sous-module `src/api` |
| **S** | Dépôt `nanos-world/nanos-world-server`, fichiers `_script.toml`, `_game_mode.toml`, `_map.toml`, `_loading_screen.toml`, `_c_module.toml`, `_meta.toml`, `Config.toml`, `DefaultAssetPack.toml` | branche `main`, lue le 2026-10-06, **non figée** (les pages D les affichent par un bloc `toml reference` pointant sur `main`) |

### 0.2 Point important pour les auteurs : les pages « scripting-reference » de D sont des squelettes

Dans le clone du site, le dossier `src/api` est un sous-module Git **non récupéré** (vide). Les pages `scripting-reference/classes/*.mdx`, `static-classes/*.mdx`, `structs/*.mdx`, `utility-libraries/*.mdx`, `standard-libraries/*.mdx` ne contiennent donc que des introductions, des exemples et des balises `<FunctionsDeclaration .../>` : **aucune signature, aucun événement, aucun paramètre** (vérifié : `scripting-reference/classes/player.mdx` ne contient que des balises). La liste réelle est générée à la construction du site à partir du dépôt `nanos-world/api` (la page `contributing-to-the-docs.mdx`, section « API Reference », le dit explicitement).

Pour ne pas laisser la fiche vide, les signatures ont été relues dans le dépôt **A**, au commit exact épinglé par le clone (téléchargement de lecture seule via `raw.githubusercontent.com`, fichiers conservés hors du dépôt du cours). Les pages D restent citées pour les explications et les exemples.

### 0.3 Convention de citation

* `[D chemin.mdx]` : page de la doc, chemin relatif à `docs/docs/` (par exemple `[D core-concepts/scripting/events-guide.mdx]`).
* `[A Classes/Player.json]` : fichier de l'API, qui alimente la page D de même nom (`scripting-reference/classes/player.mdx`).
* `[S Config.toml]` : fichier du dépôt serveur.
* En tête de chaque section d'API, la page D correspondante est donnée. Les tableaux d'événements et de méthodes en dérivent, sauf mention contraire.

### 0.4 Légende des côtés (authority)

Définie dans `[D core-concepts/scripting/authority-concepts.mdx]` et utilisée telle quelle dans les JSON.

| Étiquette dans la fiche | Valeur JSON | Signification documentée |
|---|---|---|
| **S** | `server` | méthode appelable, événement déclenché, classe instanciable **côté serveur seulement** |
| **C** | `client` | **côté client seulement** (une entité créée côté client n'existe que pour ce client) |
| **S+C** | `both` | les deux côtés |
| **Auth** | `authority` | seulement côté qui a **créé** l'entité |
| **NetAuth** | `network-authority` | serveur, et client si le joueur local est la « Network Authority » de l'entité |
| **S+C (NA d'abord)** | `both-net-authority-first` | événements : les deux côtés, mais appelé d'abord chez le client Network Authority |

Étiquette d'efficacité dans les JSON (`fast`, `moderate`, `slow`, `blocking`) : citée seulement quand elle compte (par exemple `blocking`).

### 0.5 Ce que la fiche ne couvre pas

Hors périmètre demandé et non lu en détail : `assets-modding/**` (sauf `default-asset-pack`, survolé), classes `Widget`, `Blueprint`, `SceneCapture`, `Cable`, `Decal`, `Gizmo`, `InstancedStaticMesh`, `VehicleWater`, `Widget3D`, statiques `Sky`, `PostProcess`, `Navigation`, `Discord`, `Steam` (leurs JSON ont été téléchargés mais ne servent pas au parcours E), pages d'hébergement `game-panels`, `server-linux-arm` (titres seulement), `server-docker` (lue, voir 1.9).

---

## 1. Fiche d'identité

### 1.1 Versions et environnement

| Élément | Valeur documentée | Source |
|---|---|---|
| Langage de script | **Lua 5.4**, avec la plupart des bibliothèques standard, plus l'API nanos world | `[D core-concepts/packages/package-loading-and-lua-environment.mdx]`, `[D scripting-reference/glossary/basic-types.mdx]` |
| Moteur | Unreal Engine 5.7.4, **uniquement dans un exemple de sortie console** (« Version: 1.9.0. Unreal Version: 5.7.4. Map: 'default-blank-map' ») | `[D getting-started/quick-start.mdx]` |
| Version du jeu / du serveur | **NON DOCUMENTÉ de façon fiable** : l'exemple de console ci-dessus affiche « Version: 1.9.0 », alors que le guide des versions de compatibilité cite les mises à jour 1.139 et 1.144 (voir section 11, point 2) | `[D core-concepts/packages/compatibility-versions.mdx]` |
| Coordonnées | `Vector` X (avant), Y (droite), Z (haut) ; unité = **centimètre** (`Vector(100,0,0)` = 1 m devant l'origine) | `[D getting-started/essential-concepts.mdx]` |
| Rotation | `Rotator(pitch, yaw, roll)` en **degrés** | `[A Structs/Rotator.json]` |
| Application Steam du serveur | app id `1936830` (SteamCMD, `login anonymous`) ; branche `public` ou `bleeding-edge` | `[D core-concepts/server-manual/server-installation.mdx]` |
| Steam App d'exécution | `--steam_app playtest` (défaut) ou `game` ; un joueur ne peut rejoindre qu'un serveur de la même Steam App | `[D core-concepts/server-manual/server-configuration.mdx]` |
| Système du serveur | Windows ou Linux (Ubuntu 24.04 recommandé, 22.04, Debian 13). Windows : « Microsoft Visual C++ Redistributable » requis. Linux : lancer `./NanosWorldServer.sh` | `[D core-concepts/server-manual/server-installation.mdx]` |
| Exigences minimales du serveur | 2 cœurs 1,0 GHz, **50 Mo de RAM**, 30 Mo de disque (+ assets et packages), réseau conseillé 1 Mo/s ; ports `7777` TCP/UDP et `7778` UDP | idem |
| État de l'accès au jeu | « Closed Testing » ; clés Steam « Playtest » ou « Beta » données aux testeurs ; des « public playtest events » sont aussi annoncés | `[D welcome.mdx]`, `[D signing-up-alpha.mdx]` |

Remarque pour le cours : les exigences du serveur sont minuscules, donc **le serveur peut a priori tourner sur le portable HP** (pas de GPU requis). Ce que la doc ne dit pas : si le serveur démarre et exécute les scripts sans aucun client connecté dans tous les cas. Elle dit en revanche que **la physique et l'IA sont calculées par les clients** (« AI will only work if there is a Player connected ») `[D core-concepts/scripting/artificial-intelligence.mdx]`, `[D core-concepts/scripting/networking-and-replication.mdx]`. Les événements `Player` exigent évidemment un client connecté.

### 1.2 Arborescence d'un serveur et d'un package

Sources : `[D core-concepts/packages/packages-guide.mdx]`, `[D getting-started/essential-concepts.mdx]`, `[D core-concepts/assets.mdx]`.

```
NanosWorldServer.exe        (Linux : NanosWorldServer.sh)
Config.toml                 (créé au premier démarrage)
.logs/                      (journaux serveur ; NanosWorldCore.log = dernière session)
Assets/                     (Asset Packs, chacun avec Assets.toml)
Packages/
├── .data/                  (données persistantes : <nom-du-package>.toml)
├── mon-package/
│   ├── Package.toml
│   ├── Server/   Index.lua + *.lua   (jamais envoyé aux clients)
│   ├── Client/   Index.lua + *.lua   (envoyé et exécuté chez les clients)
│   └── Shared/   Index.lua + *.lua   (exécuté des deux côtés)
└── mon-loading-screen/
    ├── Package.toml
    └── index.html ...
```

Règles documentées :

* « Only **Client** and **Shared** folders will be sent and loaded by the clients » ; `Server/` ne quitte jamais le serveur `[D core-concepts/packages/packages-guide.mdx]`, `[D core-concepts/scripting/security-remote-events.mdx]`.
* Seul le fichier **`Index.lua`** de chaque dossier (`Server/`, `Client/`, `Shared/`) est lancé automatiquement ; il importe les autres avec `Package.Require` `[D core-concepts/packages/package-loading-and-lua-environment.mdx]`.
* Seuls les packages de type `script`, `game-mode` et `map` ont cette structure `Server/Client/Shared` `[D getting-started/essential-concepts.mdx]`.
* **Nom du dossier d'un package = son identifiant** : minuscules, chiffres et `-` uniquement, 64 caractères max `[D core-concepts/packages/packages-guide.mdx]`.
* Un dossier à ignorer côté clients (par exemple `node_modules`) : y mettre un fichier `.ignore` `[D core-concepts/packages/packages-guide.mdx]`.
* Image du package dans le Vault : `Package.jpg` à côté de `Package.toml` (300x150 conseillé), inutile sinon `[D core-concepts/packages/packages-guide.mdx]`.
* Création guidée : `./NanosWorldServer.exe --cli add package mon-package` (demande titre, auteur, type) `[D getting-started/quick-start.mdx]`.

### 1.3 `Package.toml` : tous les champs documentés

Sources : tableau « Settings Detailed » de `[D core-concepts/packages/packages-guide.mdx]`, modèles `[S _meta.toml]`, `[S _script.toml]`, `[S _game_mode.toml]`, `[S _map.toml]`, `[S _loading_screen.toml]`, `[S _c_module.toml]`.

Section commune `[meta]` (tous les types) :

| Champ | Description documentée |
|---|---|
| `title` | nom lisible |
| `author` | contributeur(s) |
| `version` | SemVer `X.Y.Z` |

Types de package : `script`, `game-mode`, `map`, `loading-screen`, `c-module` (5 types).

| Champ | Types concernés | Description documentée | Valeur du modèle `[S]` |
|---|---|---|---|
| `force_no_map_package` | script, game-mode | force le non-chargement du package de map | `false` |
| `auto_cleanup` | script, game-mode, map | détruit toutes les entités créées par le package quand il se décharge | `true` |
| `load_level_entities` | script, game-mode, map | charge côté client les static meshes du niveau comme entités (coûteux) | `false` |
| `compatibility_version` | script, game-mode, map | version du jeu (`major.minor`) au moment de la création, pour garder le comportement avant changements cassants | `"1.25"` |
| `packages_requirements` | script, game-mode, map | packages qui doivent être chargés **avant** | `[]` |
| `assets_requirements` | script, game-mode, map | Asset Packs à charger avec ce package | `[]` |
| `compatible_game_modes` | script, map | game-modes recommandés | `[]` |
| `compatible_maps` | game-mode | maps recommandées (mises en avant au lancement d'une partie par le menu) | `[]` |
| `[custom_settings]` | game-mode | réglages personnalisés, voir ci-dessous | (exemple commenté) |
| `map_asset` | map | `"[ASSET_PACK]::[ASSET_KEY]"` | `"nanos-world::BlankMap"` |
| `spawn_points` | map | liste `{ location = "Vector(...)", rotation = "Rotator(...)" }` lisible par `Server.GetMapSpawnPoints()` | un exemple |
| `enable_water_buoyancy` | map | composants de flottaison si la map utilise le plugin Water | `false` |
| `[custom_data]` | map | données lisibles par `Server.GetMapConfig()` | `# something = 123` |
| `modules` (dans `[c_module]`) | c-module | liste de bibliothèques sans extension | `[]` |
| (section `[loading_screen]`) | loading-screen | « nothing here yet » | |

Exemple minimal valide, **copié du modèle** `[S _script.toml]` (valeurs d'exemple) :

```toml
# vault configurations
[meta]
    title =                 "My Awesome Package"
    author =                "Contributor Names"
    version =               "0.1.0"

# script configurations
[script]
    force_no_map_package =  false
    auto_cleanup =          true
    load_level_entities =   false
    compatibility_version = "1.25"
    packages_requirements = [

    ]
    assets_requirements = [

    ]
    compatible_game_modes = [

    ]
```

Exemple de `game_mode` avec dépendances, **copié de** `[D getting-started/your-first-game-mode.mdx]` :

```toml
[meta]
    title =                 "My Deathmatch"
    author =                "myself"
    version =               "0.0.1"

[game_mode]
    # ... keep the other settings generated by the CLI ...
    packages_requirements = [
        "default-weapons",
    ]
    compatible_maps = [
        "default-testing-map",
    ]
```

Remarque : `compatibility_version = "1.25"` dans le modèle est une valeur historique ; voir 9.1 pour ce que ce champ change vraiment.

#### `custom_settings` (game-mode) `[D core-concepts/packages/packages-guide.mdx]`

Chaque réglage est `clé = { ... }` avec :

| Propriété | Type | Description |
|---|---|---|
| `label` | string | nom affiché |
| `type` | string | `boolean`, `integer`, `floating`, `select`, `text` |
| `description` | string | aide |
| `default` | boolean, integer, floating ou string | doit correspondre au `type` |
| `options` | string[] | uniquement pour `select` |

Exemple copié de la doc :

```toml
[custom_settings]
	max_props = { label = "Max Props", type = "integer", description = "maximum amount of props players can spawn", default = 1000 }
	enable_pvp = { label = "Enable PVP", type = "boolean", description = "whether to enable PVP or not", default = true }
	welcome_message = { label = "Welcome Message", type = "text", description = "message shown to players when they join", default = "have fun!" }
	game_mode = { label = "Game Mode", type = "select", description = "which ruleset to use", default = "Classic", options = [ "Classic", "Hardcore", "Free for All" ] }
```

Lecture : `local settings = Server.GetCustomSettings()` puis `settings.max_props` (valeur brute). Surcharge en ligne de commande, prioritaire sur l'écran New Game et sur `Package.toml` : `--custom_settings "max_props = 500, enable_pvp = false, game_mode = 'Hardcore'"`.

### 1.4 `Config.toml` du serveur : champs utiles

Sources : `[D core-concepts/server-manual/server-configuration.mdx]`, modèle `[S Config.toml]`.

Faits importants : fichier **généré au premier démarrage** ; le serveur le **réécrit à chaque démarrage** après application des paramètres de ligne de commande et validation : commentaires, clés inconnues et valeurs hors plage sont perdus ou remis par défaut.

| Section | Champ | Type | Défaut documenté | Description |
|---|---|---|---|---|
| `[discover]` | `name` | string | `"nanos world server"` | nom dans la liste |
| | `description` | string | `""` | 200 caractères max |
| | `language` | string | `"global"` | code pays |
| | `ip` | string | `"0.0.0.0"` | adresse d'écoute |
| | `port` | int | `7777` | jeu (UDP) + HTTP intégré (TCP), 1024-65535 |
| | `query_port` | int | `7778` | UDP, différent de `port` |
| | `announce` | bool | `true` | annoncé dans la liste |
| | `dedicated_server` | bool | `true` | `false` = P2P via Steam Datagram Relay |
| `[general]` | `max_players` | int | `64` | 1-999 |
| | `password` | string | `""` | vide = pas de mot de passe |
| | `token` | string | `""` | jeton d'autorisation du Vault/CLI |
| | `banned_ids` | string list | `[]` | IDs de comptes nanos bannis |
| `[game]` | `map` | string | `"default-blank-map"` | package de map |
| | `game_mode` | string | `""` | un seul |
| | `packages` | string list | `[]` | packages `script` à charger |
| | `assets` | string list | `[]` | Asset Packs en plus |
| | `loading_screen` | string | `""` | package d'écran de chargement |
| `[custom_settings]` | (libre) | string, int, float, bool | | lus par `Server.GetCustomSettings()` |
| `[debug]` | `log_level` | int | `1` | 1 normal, 2 debug, 3 verbose |
| | `async_log` | bool | `true` | |
| | `profiling` | bool | `false` | journaux de performance |
| `[optimization]` | `max_tick_rate` | int | `30` | Hz, 15-120 ; 30 Hz = 33 ms par tick (« we recommend leaving it 30 ») |
| | `max_sync_rate` | int | `30` | 1-30 |
| | `max_send_rate` | int | `1024` (doc) / `512` (modèle S) | Ko/s par client, 128-16384 ; **contradiction, voir section 11** |
| | `max_file_transfer_rate` | int | `1024` (doc) / `512` (modèle S) | Ko/s par client |
| | `compression` | int | `1` | 0-9 |
| | `distance_optimization` | int | `4` | 0-9 |

Les 4 maps intégrées, utilisables sans téléchargement : `default-blank-map`, `default-empty-map`, `default-ocean-map`, `default-testing-map` `[D getting-started/essential-concepts.mdx]`.

Exemple copié de `[D getting-started/quick-start.mdx]` :

```toml
[game]
    # ...
    packages = [
        "my-awesome-package",
    ]
```

Alternative sans éditer le fichier : `--packages my-awesome-package`.

### 1.5 Commandes utiles du serveur

#### 1.5.1 CLI (`--cli`) `[D core-concepts/server-manual/command-line-interface.mdx]`

`--cli` doit être le **premier** argument. Mode interactif (`./NanosWorldServer.exe --cli`, puis `help`) ou direct (`./NanosWorldServer.exe --cli install package sandbox`). Plusieurs noms : séparés par des **espaces** (l'aide affiche des virgules, la doc précise que ce sont bien des espaces).

| Commande | Effet documenté |
|---|---|
| `add package [NOM]` | crée un package local, de façon interactive |
| `add assets [NOM]` | crée un Asset Pack local |
| `install package [NOMS...]` | installe depuis le Vault (avec ses dépendances) |
| `install assets [NOMS...]` | installe des Asset Packs |
| `update package` / `update assets` | met à jour |
| `upload package` / `upload assets` | envoie au Vault (nécessite un `token`) |
| `check` | cherche des mises à jour |
| `help`, `stop` | aide, quitter |

Exemple de la doc : `./NanosWorldServer.exe --cli install package default-weapons`.

#### 1.5.2 Console du serveur (commandes intégrées) `[D core-concepts/server-manual/server-configuration.mdx]`

| Commande | Paramètres | Description |
|---|---|---|
| `chat` | `<message>` | envoie un message |
| `clear` | | efface la console |
| `kick` | `<player_id> <reason>` | expulse un joueur « by it's ID » (nature de cet ID : NON DOCUMENTÉE ; la commande `players` liste les joueurs) |
| `map` | `<map_package>` | change de map, recharge tout |
| `restart` | | redémarre le serveur |
| `stop` | | arrête |
| `players` | | liste les joueurs |
| `password` | `<new_password>` | change le mot de passe |
| `profiling` | `<0-1>` | journaux de performance |
| `log_level` | `<1-3>` | |
| `package run` | `<package_name> <lua_code>` | exécute du Lua dans un package |
| `package reload all` | | recharge tous les packages et **redémarre la machine virtuelle Lua** |
| `package reload` | `<noms...>` | recharge |
| `package unload` / `package load` | `<noms...>` | décharge / charge |
| `package hotreload` | `<noms...>` | recharge les fichiers en **gardant la mémoire** (variables globales) |
| `max_send_rate`, `max_file_transfer_rate`, `distance_optimization` | valeurs | réglages à chaud |

Commandes personnalisées : `Console.RegisterCommand(...)` (section 3.7).

#### 1.5.3 Paramètres de ligne de commande utiles `[D core-concepts/server-manual/server-configuration.mdx]`

`--name`, `--description`, `--password`, `--ip`, `--port`, `--query_port`, `--announce 0|1`, `--map`, `--game_mode`, `--loading_screen`, `--packages "a,b"`, `--assets`, `--max_players`, `--dedicated_server 0|1`, `--log_level 1|2|3`, `--custom_settings "..."`, `--save` (écrit les paramètres passés dans `Config.toml`), `--profiling`, `--auto_download` (télécharge packages et assets manquants depuis le Vault), `--max_tick_rate`, `--thread_pool_count`, `--enable_unsafe_libs` (voir 1.8), `--steam_app game|playtest`, `--token`.

Exemple copié de la doc :

```shell
./NanosWorldServer.exe --name "nanos world Amazing Sandbox" --map "default-testing-map" --game_mode "sandbox" --packages "battlefield-kill-ui,ts-fireworks-tools" --port 7777 --query_port 7778 --max_players 32 --auto_download
```

### 1.6 Charger un package, ordre de chargement, cycle de vie

Sources : `[D core-concepts/packages/package-loading-and-lua-environment.mdx]`, `[D core-concepts/server-and-client-lifecycle.mdx]`, `[D getting-started/essential-concepts.mdx]`.

Pour qu'un package soit chargé : l'inscrire dans `Config.toml`, section `[game]` (`game_mode`, `packages`, `map`, `loading_screen` selon son type), ou le passer en ligne de commande. On peut aussi charger/décharger par script : `Server.LoadPackage()`, `Server.UnloadPackage()`, `Server.ReloadPackage()`, ou par la console (`package load|unload|reload`).

**Ordre de chargement au démarrage** (documenté) :

1. le package **game-mode** (`game_mode`) ;
2. les packages **script** (`packages`), dans l'ordre de la liste ;
3. le package **map** (`map`).

Pour chaque package, avant ses scripts, le serveur charge ses `assets_requirements` et `packages_requirements` (récursivement). Seuls les packages `script` (et `c-module`) peuvent être requis. Puis, dans l'ordre :

1. `Shared/Index.lua`
2. `Server/Index.lua` (serveur) ou `Client/Index.lua` (clients)
3. déclenchement de l'événement `Package "Load"`.

Les clients chargent les mêmes packages dans le même ordre, après avoir téléchargé `Client/` et `Shared/`.

Séquence du serveur (diagramme de `server-and-client-lifecycle.mdx`) : serveur HTTP, Vault, map, Asset Packs, machine Lua, packages (game-mode, scripts, map), sockets réseau, **événement `Server "Start"`**, puis boucle : messages réseau entrants, console, entités/timers/callbacks asynchrones, **événement `Server "Tick"`**, changements de map/package. À l'arrêt : `Server "Stop"`, puis tous les `Package "Unload"` et destruction des entités des packages.

Séquence du client : connexion, vérification et téléchargement des fichiers, map, Asset Packs, packages, entités du serveur, **`Client "SpawnLocalPlayer"`**, événements `Spawn` des entités, actions post-chargement (possession, ramassage, entrée en véhicule), compilation des shaders, puis **`Player "Ready"` déclenché côté serveur**.

**Exigence de robustesse documentée** : l'événement `Load` est redéclenché à chaque rechargement du package, alors que des joueurs sont déjà connectés. Écrire donc le package pour qu'il marche quand il est rechargé : en plus de `Player.Subscribe("Spawn", ...)`, parcourir `Player.GetAll()` dans `Package.Subscribe("Load", ...)` `[D core-concepts/scripting/debugging-and-logging.mdx]`.

### 1.7 API des packages et du serveur utile au chargement

Sources : `[A StaticClasses/Package.json]` (page `scripting-reference/static-classes/package.mdx`), `[A StaticClasses/Server.json]`.

| Appel | Côté | Retour | Documenté |
|---|---|---|---|
| `Package.Subscribe(event_name, callback)` | S+C | le callback | événements `"Load"`, `"Unload"`, `"FileReload"` |
| `Package.Unsubscribe(event_name, callback = nil)` | S+C | | sans callback : tout désabonner (dans ce package) |
| `Package.Require(file_path, force_load = false)` | S+C | valeur retournée par le fichier | charge un `.lua`, **résultat mis en cache**, 5 « searchers » (ci-dessous) |
| `Package.LoadFile(file_path)` | S+C | fonction à exécuter | compile sans exécuter ; permet un environnement bac à sable : `local f = Package.LoadFile("MyScript.lua"); f({ Console = Console })` |
| `Package.Export(variable_name, value)` | S+C | | rend une variable accessible aux **autres packages** |
| `Package.GetName()` | S+C | string | nom du **dossier** du package |
| `Package.GetTitle()`, `GetVersion()`, `GetCompatibilityVersion()` | S+C | string | |
| `Package.GetFiles(path_filter, extension_filter)`, `GetDirectories(path_filter)` | S+C | string[] | fichiers/dossiers du package (`slow`) |
| `Package.IsUnloading()` | S+C | boolean | |
| `Package.ReloadClientFile(file_path)` | S | | renvoie un fichier `Client/` ou `Shared/` aux clients (événement `FileReload` chez eux) ; « mostly intended for development » |
| `Package.GetPath()` | n'existe plus | | **dépréciée depuis 1.49** au profit de `GetName()` `[D core-concepts/packages/compatibility-versions.mdx]` ; absente de l'API actuelle |
| `Package.SetPersistentData`, `GetPersistentData`, `FlushPersistentData` | S+C | | section 4.1 |

Les 5 chemins de recherche de `Package.Require` (dans l'ordre, `[D core-concepts/packages/package-loading-and-lua-environment.mdx]`) : relatif au fichier courant ; relatif à `mon-package/Server/` ou `Client/` ; relatif à `mon-package/Shared/` ; relatif à `mon-package/` ; relatif à `Packages/`. Exemples copiés :

```lua
Package.Require("Weapons.lua")      -- my-package/Server/Weapons.lua
Package.Require("Utils/Math.lua")   -- my-package/Server/Utils/Math.lua
```

Un fichier n'est exécuté qu'une fois. `Require` seul ne marche pas pour **partager** entre packages : chaque package a son **propre environnement** (variables et fonctions globales invisibles aux autres). Partager avec `Package.Export` :

```lua
-- my-library/Server/Index.lua
MyLibrary = {}
function MyLibrary.Greet(player)
    Chat.SendMessage(player, "Hello " .. player:GetName())
end
Package.Export("MyLibrary", MyLibrary)
```

La variable exportée n'existe qu'**après** le chargement du package exportateur : l'inscrire dans `packages_requirements` de celui qui l'utilise. Un export n'est visible que du **même côté** (serveur ou client) `[D core-concepts/scripting/communicating-between-packages.mdx]`. Les classes créées avec `Inherit` sont, elles, enregistrées globalement.

Événements du package :

```lua
Package.Subscribe("Load", function() Console.Log("My Package loaded!") end)
Package.Subscribe("Unload", function() --[[ sauvegarder ici ]] end)
```

Détail de `Load` `[A StaticClasses/Package.json]` : au démarrage du serveur ou avec `package reload all`, l'événement est déclenché seulement **après** le chargement de TOUS les packages ; dans les autres cas (charge/recharge d'un package), immédiatement après son chargement. (La page `package-loading-and-lua-environment.mdx` dit « after all the Index.lua files of this Package ran » : même idée, version moins détaillée.)

### 1.8 Environnement Lua

Source : `[D core-concepts/packages/package-loading-and-lua-environment.mdx]`.

* Lua 5.4. Sont **désactivés par défaut côté serveur** : `os.execute`, `os.rename`, `os.remove`, `os.exit`, `os.getenv`, `os.tmpname`, `os.setlocale`, `dofile`, `loadfile` et **toute la bibliothèque `io`**. Activables avec `--enable_unsafe_libs` (« only do it if you trust all the Packages running on your server »). `Server.IsUnsafeLibsEnabled()` donne l'état.
* Pour lire/écrire des fichiers, la doc recommande la classe `File`; pour stocker des données, le stockage persistant ou `Database`.
* `print(...)` fonctionne et est redirigé vers `Console.Log` `[D core-concepts/scripting/debugging-and-logging.mdx]`.
* `require` : **NON DOCUMENTÉ** (utiliser `Package.Require`). `os.time`, `os.date`, `os.clock` : ni listés comme désactivés ni documentés comme disponibles.
* Bibliothèques standard documentées par la doc nanos : `math`, `string` (avec extensions nanos), `table` (section 3.12). Les autres fonctions de Lua 5.4 (par exemple `table.unpack`, `math.tointeger`) ne sont pas listées dans le site : **NON DOCUMENTÉ** ici (renvoyer au manuel Lua 5.4, que la doc cite).

### 1.9 Boucle de développement et journaux

Sources : `[D core-concepts/scripting/debugging-and-logging.mdx]`, `[D troubleshooting.mdx]`, `[D getting-started/editor-setup.mdx]`.

* Recharger sans redémarrer : `package reload mon-package` (détruit les entités du package si `auto_cleanup`), `package hotreload mon-package` (garde la mémoire), `package reload all` (redémarre la machine Lua).
* Journaux : serveur dans `.logs/` à côté de l'exécutable (`NanosWorldCore.log` = dernière session) ; client dans `%LocalAppData%\NanosWorld\Saved\Logs\`.
* Niveaux de log : `log_level` 2 ou 3 dans `[debug]`, ou `--log_level 2`, ou commande console `log_level 2` ; `Console.Debug` n'apparaît qu'à partir du niveau 2.
* Lire une erreur Lua : corriger **la première** ; la ligne `[1]` est l'endroit de l'erreur. Exemple documenté : `attempt to call a nil value (global 'Sound')` = classe **client seulement** utilisée côté serveur.
* Éditeur : extension VS Code « nanos world Lua » (go-horse-studios.nanos-world, dépend de l'extension Lua de sumneko) ; annotations générées depuis le même dépôt d'API ; utile pour l'autocomplétion, mais elle ne sait pas si un fichier tourne côté serveur ou client.
* Dépannage « mon package ne charge pas » : nom listé dans `[game]`, nom en minuscules/chiffres/`-`, erreurs de `Package.toml` (une erreur ou un réglage manquant bloque le package), dépendances présentes `[D troubleshooting.mdx]`.
* Docker : image communautaire `olivatooo/nanos-world-server` ; le `Config.toml` est dans le conteneur, passer les réglages par `command:` ; `./Packages` monté donc `Packages/.data` persiste `[D core-concepts/server-manual/server-docker.mdx]`.

---

## 2. Événements

### 2.1 Comment s'abonner (règles documentées)

Sources : `[D core-concepts/scripting/events-guide.mdx]`, `[D core-concepts/scripting/inheriting-classes.mdx]`, `[A Classes/BaseEntity.json]`.

| Forme | Effet | Premier argument du callback |
|---|---|---|
| `Classe.Subscribe("Event", callback)` | tous les entités de la classe | l'entité (`self`) |
| `entite:Subscribe("Event", callback)` | cette entité seulement ; désabonnement **automatique** à sa destruction | l'entité (`self`) |
| `Classe.Unsubscribe("Event")` | enlève **tous** les callbacks de ce package pour cet événement | |
| `Classe.Unsubscribe("Event", callback)` | enlève ce callback seulement | |
| `StaticClass.Subscribe("Event", callback)` | événements d'une classe statique (`Server`, `Client`, `Input`, `Chat`, `Package`, `Console`, `Viewport`, `Level`) | selon l'événement |

* `Subscribe` **retourne le callback** passé : permet de se désabonner d'une fonction anonyme : `local cb = Player.Subscribe("Spawn", function(p) end); Player.Unsubscribe("Spawn", cb)`.
* `Unsubscribe` ne retire que les abonnements créés **par le package courant**.
* **Événements annulables** : certains se déclenchent **avant** l'action ; retourner `false` l'annule. Ils s'appellent en général `Attempt...` (`AttemptEnterVehicle`) mais pas toujours (`Interact`, `PlayerSubmit`, `TakeDamage` retourne un multiplicateur). Les cas sont listés en 2.4 avec la mention « retour ».
* Héritage : un événement d'une classe parente se déclenche pour les classes filles. `Character` hérite d'événements de `Damageable` (`Death`, `TakeDamage`, `HealthChange`, `Respawn`), `Pawn` (`Possess`, `UnPossess`, `MoveComplete`), `Actor`, `Entity` `[A Classes/BaseDamageable.json]`, `[A Classes/BasePawn.json]`.

### 2.2 Événements personnalisés (classe statique `Events`)

Page : `scripting-reference/static-classes/events.mdx`, données `[A StaticClasses/Events.json]`. Signatures complètes en 3.1.

* **Locaux** (même côté, tous les packages) : `Events.Call("Nom", args...)` reçu par `Events.Subscribe("Nom", cb)`.
* **Distants** (réseau) : `Events.CallRemote`, `Events.CallRemotePlayers`, `Events.BroadcastRemote`, etc., reçus par `Events.SubscribeRemote("Nom", cb)`. **Côté serveur, le premier paramètre reçu est toujours le `Player` émetteur**, avant les arguments.
* `Events.Subscribe` ne reçoit **que** les événements locaux, `Events.SubscribeRemote` **que** les distants (depuis la version 1.22).
* Les entités peuvent être passées en arguments (elles arrivent comme la même entité de l'autre côté, si elle y existe). Une entité envoyée à un joueur d'une autre dimension est remplacée par `nil` (avertissement) `[D core-concepts/scripting/dimensions.mdx]`.
* Les `Vector` passés en événement distant sont compressés à **2 décimales** ; pour plus de précision, les passer comme nombres bruts `[D scripting-reference/structs/vector.mdx]`.

### 2.3 Événements de cycle de vie : packages, serveur, client

Pages : `scripting-reference/static-classes/package.mdx`, `server.mdx`, `client.mdx`.

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `Package "Load"` | aucun | S+C | voir 1.7 pour le moment exact |
| `Package "Unload"` | aucun | S+C | décharge de package, changement de map, arrêt serveur, rechargement |
| `Package "FileReload"` | `file_path: string` | C | après `Package.ReloadClientFile()` |
| `Server "Start"` | aucun | S | une fois, quand le serveur est démarré et tous les packages chargés |
| `Server "Stop"` | aucun | S | |
| `Server "Restart"` | aucun | S | |
| `Server "ChangeMap"` | `old_map: string, new_map: string` | S | toujours juste avant `Restart` |
| `Server "PlayerConnect"` | `ip, player_account_id, player_name, player_steam_id` (strings) | S | **avant** que l'entité `Player` existe. Pour refuser : `Server.KickByAccountID()` ou `BanByAccountID()`. « returning false is deprecated » |
| `Server "PlayerDisconnect"` | `ip, player_account_id, player_name, player_steam_id, disconnect_reason` | S | |
| `Server "Tick"` | `delta_time: float` (secondes depuis le dernier tick) | S | toutes les 33 ms par défaut ; « only small operations should be performed here » |
| `Server "ValueChange"` | `key, value` | S | après `Server.SetValue` |
| `Client "Tick"` | `delta_time: float` | C | à chaque image : « Do not abuse » |
| `Client "SpawnLocalPlayer"` | `local_player: Player` | C | le joueur local n'est disponible qu'après |
| `Client "WindowFocusChange"` | `is_focused: boolean` | C | |
| `Client "LanguageChange"` | `language: string` | C | |
| `Client "ValueChange"` | `key, value` | C | `Client.SetValue()` ou `Server.SetValue()` synchronisé |

### 2.4 Événements des entités (classes `Entity`, `Player`, `Character`, etc.)

#### Entity (toutes les classes) — page `scripting-reference/classes/base-classes/entity.mdx`

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `Spawn` | `self` | S+C | entité créée |
| `Destroy` | `self` | S+C | **pour un `Player`, signifie qu'il quitte le serveur** `[D core-concepts/scripting/player-lifecycle.mdx]` |
| `ValueChange` | `self, key, value` | S+C | après `entity:SetValue()` (aussi côté client pour les valeurs synchronisées) |
| `ClassRegister` | `class: table` | S+C | une classe vient d'être créée avec `Inherit` |

#### Player — page `scripting-reference/classes/player.mdx`

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `Spawn` (hérité) | `player` | S+C | un joueur vient de se connecter ; le client charge encore la map |
| `Ready` | `self` | **S** | client entièrement chargé, prêt à jouer. À préférer pour envoyer des événements distants, afficher un message d'accueil `[D core-concepts/scripting/player-lifecycle.mdx]` |
| `Possess` | `self, pawn` | S+C | le joueur contrôle un `Pawn` |
| `UnPossess` | `self, pawn` | S+C | |
| `Destroy` (hérité) | `player` | S+C | le joueur part |
| `DimensionChange` | `self, old_dimension, new_dimension` | S | |
| `VOIP` | `self, is_talking` | S+C (NA d'abord) | retour `false` quand `is_talking` : empêche la lecture de la voix |
| `VOIPGlobalChannelSettingChange` | `self, channel, old_setting, new_setting` | S+C | |
| `VOIPLocalSettingChange` | `self, old_setting, new_setting` | S+C | |

Ordre documenté de connexion `[D core-concepts/scripting/player-lifecycle.mdx]` : (1) `Server "PlayerConnect"` ; (2) `Player "Spawn"` (serveur) ; (3) `Client "SpawnLocalPlayer"` ; (4) `Player "Ready"` (serveur) ; (5) `Possess` / `UnPossess` ; (6) `Destroy` du `Player` ; (7) `Server "PlayerDisconnect"`.

#### Actor — page `.../base-classes/actor.mdx`

`DimensionChange (self, old_dimension, new_dimension)` S ; `NetworkAuthorityChange` S `(self, old_network_authority: Player?, new_network_authority: Player?)` et C `(self, is_network_authority: boolean)` ; `EnterWater (self)` et `LeaveWater (self)` S+C.

#### Damageable (Character, CharacterSimple, VehicleWheeled, ...) — page `.../base-classes/damageable.mdx`

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `HealthChange` | `self, old_health, new_health` | S+C | dégâts, soin, `SetHealth`, respawn |
| `Respawn` | `self` | S+C | |
| `Death` | `self, last_damage_taken, last_bone_damaged, damage_type_reason: DamageType, hit_from_direction: Vector, instigator: Player?, causer: Actor?` | S+C | le `Character` n'est **pas détruit** : il reste en ragdoll |
| `TakeDamage` | `self, damage, bone, type: DamageType, from_direction, instigator: Player, causer` | S+C | **retour** : un nombre = multiplicateur des dégâts finaux ; `0` annule les dégâts (animations et impacts restent) ; défaut `1.0` |

Exemple copié de `[D getting-started/your-first-game-mode.mdx]` :

```lua
Character.Subscribe("Death", function(character, last_damage_taken, last_bone_damaged, damage_type_reason, hit_from_direction, instigator)
    Timer.SetTimeout(function()
        -- The Character may have been destroyed in the meantime (e.g. the Player left)
        if (not character:IsValid()) then return end
        local location, rotation = GetRandomSpawnPoint()
        character:Respawn(location, rotation)
    end, RESPAWN_TIME)
end)
```

#### Pawn (Character, CharacterSimple) — page `.../base-classes/pawn.mdx`

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `Possess` | `self, player` | S+C | **attention à l'ordre inversé** par rapport à `Player "Possess"` (`self, pawn`) |
| `UnPossess` | `self, old_player` | S+C | |
| `MoveComplete` | `self, succeeded: boolean` | S+C | fin (ou échec) d'un `MoveTo`/`Follow` d'IA |
| `AnimationBeginNotify`, `AnimationEndNotify` | `self, notify_name, animation_name, trigger_begin_time, trigger_end_time` | C | |

#### Character — page `scripting-reference/classes/character.mdx`

| Événement | Arguments | Côté | Retour |
|---|---|---|---|
| `Fire` | `self, weapon: Weapon` | S+C (NA d'abord) | |
| `PickUp` | `self, object: Pickable` | S+C | |
| `Drop` | `self, object: Pickable, triggered_by_player: boolean` | S+C | |
| `Interact` | `self, object: Prop\|Pickable` | **S** | `false` empêche l'interaction |
| `Highlight` | `self, is_highlighted, object` | S+C | |
| `EnterVehicle` | `self, vehicle, seat_index` | S+C | |
| `AttemptEnterVehicle` | `self, vehicle, seat_index` | **S** | `false` empêche l'entrée |
| `LeaveVehicle` | `self, vehicle, seat_index` | S+C | |
| `AttemptLeaveVehicle` | `self, vehicle` | **S** | `false` empêche la sortie |
| `GrabProp` / `UnGrabProp` | `self, prop` | S+C | |
| `AttemptReload` | `self, weapon` | S+C | `false` empêche |
| `Reload` | `self, weapon, ammo_to_reload` | S+C | |
| `PullUse` / `ReleaseUse` | `self, pickable` | S+C | |
| `Attack` | `self, melee` | S+C | |
| `Punch` | `self` | S+C | |
| `RagdollModeChange` | `self, old_state, new_state` (booléens) | S+C | |
| `FallingModeChange`, `GaitModeChange`, `StanceModeChange`, `SwimmingModeChange`, `ViewModeChange`, `WeaponAimModeChange` | `self, old_state, new_state` (enums) | S+C (NA d'abord) | |

#### CharacterSimple — page `scripting-reference/classes/charactersimple.mdx`

`Jump`, `StartCrouch`, `EndCrouch`, `Land` `(self)` et `MovementModeChange (self, old_mode, new_mode)` : tous **C seulement**.

#### Pickable (Weapon, Melee, Grenade) — page `.../base-classes/pickable.mdx`

| Événement | Arguments | Côté | Retour |
|---|---|---|---|
| `PickUp` | `self, character` | S+C | |
| `Drop` | `self, character, was_triggered_by_player` | S+C | |
| `Interact` | `self, character` | **S** | `false` empêche le ramassage |
| `PullUse` / `ReleaseUse` | `self, character` | S+C | |
| `Hit` | `self, impact_force, normal_impulse, impact_location, velocity, other_actor?` | S+C | |

#### Weapon — page `scripting-reference/classes/weapon.mdx`

| Événement | Arguments | Côté |
|---|---|---|
| `Fire` | `self, shooter: Character` | S+C (NA d'abord) |
| `Reload` | `self, character, ammo_to_reload` | S+C |
| `AmmoClipChange` | `self, old_ammo_clip, new_ammo_clip` | S+C |
| `AmmoBagChange` | `self, old_ammo_bag, new_ammo_bag` | S+C |
| `BulletHit` | `self, impact_point, impact_normal, damage, actor_hit?` | **C** |

Melee : `Attack (self, handler: Character)` S+C. Grenade : `Explode (self)`, `Throw (self, handler)` S+C.

#### Prop — page `scripting-reference/classes/prop.mdx`

`Grab (self, character)`, `UnGrab (self, character)` S+C ; `Interact (self, character)` **S** (retour `false` : empêche d'être saisi) ; `TakeDamage (self, damage, bone, type, from_direction, instigator?, causer?)` **S** ; `Hit (...)` S+C.

#### Trigger — page `scripting-reference/classes/trigger.mdx`

| Événement | Arguments | Côté |
|---|---|---|
| `BeginOverlap` | `self: Trigger, entity: Actor` | **Auth** (côté qui a créé le Trigger) |
| `EndOverlap` | `self: Trigger, entity: Actor` | **Auth** |

Exemple copié de `[D getting-started/tutorials-and-examples/doors.mdx]` : filtrer avec `actor:IsA(Character)` (« IsA also matches classes inherited from Character »), compter les personnages dans la zone pour ne fermer la porte que quand elle est vide.

#### Vehicle / VehicleWheeled — pages `.../base-classes/vehicle.mdx`, `scripting-reference/classes/vehiclewheeled.mdx`

| Événement | Arguments | Côté | Retour |
|---|---|---|---|
| `CharacterEnter` | `self, character, seat_index` | S+C | |
| `CharacterLeave` | `self, character, seat_index` | S+C | |
| `CharacterAttemptEnter` | `self, character, seat` | **S** | `false` empêche |
| `CharacterAttemptLeave` | `self, character` | **S** | `false` empêche |
| `EngineStart`, `EngineStop` | `self` | S+C | |
| `Hit` | `self, impact_force, normal_impulse, impact_location, velocity, other_actor?` | S+C | |
| `VehicleWheeled "Horn"` | `self, is_honking` | S+C | |

#### WebUI — page `scripting-reference/classes/webui.mdx`

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `Ready` | `self` | **C** | page entièrement chargée |
| `Fail` | `self, error_code: integer, message: string` | **C** | échec de chargement |
| **événement personnalisé** (nom libre) | arguments passés depuis le JavaScript | C | reçu avec `webui:Subscribe("MonEvenement", cb)` ; le JavaScript l'émet avec `Events.Call("MonEvenement", ...)` `[D core-concepts/scripting/user-interface.mdx]` |

Côté JavaScript (dans la page) : `Events.Subscribe(nom, fonction)`, `Events.Call(nom, ...)`, `Events.Unsubscribe(nom)` ; voir section 6.

#### Canvas, Viewport

`Canvas "Update" (self, width, height)` C : le seul endroit où l'on peut dessiner. `Viewport "Resize" (new_size: Vector2D)` C.

### 2.5 Événements des classes statiques `Chat`, `Console`, `Input`, `Timer`

#### Chat — page `scripting-reference/static-classes/chat.mdx`

| Événement | Arguments | Côté | Notes |
|---|---|---|---|
| `Chat "PlayerSubmit"` | `message: string, player: Player` | S+C | **retour `false` : le message n'est pas envoyé**. Côté client, `player` est toujours le joueur local |
| `Chat "ChatEntry"` | `message: string, player: Player?` | C | à chaque nouveau message reçu (aussi ceux envoyés par script) ; pour construire un chat sur mesure |
| `Chat "Open"` / `"Close"` | | C | |

Il n'existe **pas** d'API de commandes de chat : voir 3.6.

#### Console — page `scripting-reference/static-classes/console.mdx`

`Console "PlayerSubmit" (text: string)` S+C : une ligne a été saisie dans la console. `Console "LogEntry" (text: string, type: LogType)` S+C.

#### Input — page `scripting-reference/static-classes/input.mdx` (**tout est client**)

| Événement | Arguments | Retour |
|---|---|---|
| `KeyDown`, `KeyPress`, `KeyUp` | `key_name: string, delta: float?` | `false` bloque l'entrée |
| `MouseDown`, `MouseUp` | `key_name, mouse_x, mouse_y` | `false` bloque |
| `MouseMove` | `cursor_delta_x, cursor_delta_y, mouse_x, mouse_y` | `false` bloque |
| `MouseScroll` | `mouse_x, mouse_y, delta` (positif = haut) | `false` bloque |
| `MouseEnable` | `is_enabled` | |
| `KeyBindingChange` | `binding_name, key, scale` | |

Les « Key Bindings » nommés (`Input.Register` puis `Input.Bind(nom, InputEvent.Pressed|Released, fonction)`) sont la méthode recommandée `[D core-concepts/scripting/input-and-key-bindings.mdx]` : les joueurs peuvent changer la touche dans *Settings -> Controls*. La liste des noms de touches est dans `[D scripting-reference/static-classes/input.mdx]` (par exemple `A`..`Z`, `SpaceBar`, `Enter`, `LeftMouseButton`, `One`..`Zero`, et une section AZERTY : `Ampersand`, `E_AccentAigu`, ...).

#### Timer

`Timer` n'a **aucun événement** (la page contient une balise d'événements, mais le JSON n'en définit pas) `[A StaticClasses/Timer.json]`.

### 2.6 Événements non utiles au parcours (pour mémoire)

`Level` (`StreamLevelLoad`, `StreamLevelUnload`, `StreamLevelShow`, `StreamLevelHide`, `StreamLevelBeginPause`, `StreamLevelEndPause`), `Console "LogEntry"`, événements de `Sound`/`Light`/`Particle` : aucun. `Light`, `Sound`, `Particle`, `StaticMesh`, `Text3D`, `TextRender`, `Billboard` n'ont **aucun événement** propre dans les JSON (hormis ceux hérités d'`Entity` et d'`Actor`).

---

## 3. Méthodes et propriétés (signatures complètes)

Notation : `Classe.Fonction(...)` = fonction statique (point) ; `entite:Methode(...)` = méthode d'instance (deux-points). `param: type = défaut`. `?` après un type = peut être `nil`. `args...` = nombre variable d'arguments. Le côté est celui de la section 0.4.

### 3.1 `Events` (page `scripting-reference/static-classes/events.mdx`, données `[A StaticClasses/Events.json]`)

| Signature | Côté | Retour / comportement documenté |
|---|---|---|
| `Events.Call(event_name: string, args...: any)` | S+C | `boolean` : `false` si **un** écouteur a retourné `false`, sinon `true` ; reçu par `Events.Subscribe` |
| `Events.Subscribe(event_name: string, callback: function)` | S+C | retourne le callback |
| `Events.Unsubscribe(event_name: string, callback: function = nil)` | S+C | sans callback : retire tous les écouteurs **locaux** de ce nom dans le package courant |
| `Events.SubscribeRemote(event_name: string, callback: function)` | S+C | retourne le callback ; côté serveur le callback reçoit d'abord le `Player` émetteur |
| `Events.UnsubscribeRemote(event_name: string, callback: function = nil)` | S+C | |
| `Events.CallRemote(event_name: string, reliability: Reliability = Reliability.Reliable, args...: any)` | **C** | client vers serveur |
| `Events.CallRemote(event_name: string, player: Player, reliability: Reliability = Reliability.Reliable, args...: any)` | **S** | serveur vers un joueur |
| `Events.CallRemotePlayers(event_name: string, players: Player[], reliability = Reliable, args...)` | S | plus efficace qu'une boucle de `CallRemote` |
| `Events.BroadcastRemote(event_name: string, reliability = Reliable, args...)` | S | tous les joueurs connectés |
| `Events.BroadcastRemoteDimension(event_name: string, dimension: integer, reliability = Reliable, args...)` | S | joueurs d'une dimension |
| `Events.BroadcastRemoteInRadius(event_name: string, location: Vector, radius: number, reliability = Reliable, args...)` | S | joueurs dans un rayon |
| `Events.BroadcastRemoteInRadiusDimension(event_name, location, radius, dimension, reliability = Reliable, args...)` | S | |

Enum `Reliability` : `Unreliable = 0` (peut être perdu ou arriver dans le désordre ; moins cher ; pour les événements fréquents et non critiques), `Reliable = 1` (garanti et ordonné ; pour tout ce qui compte) `[A Enums.json]`.

Exemples copiés de `[D scripting-reference/static-classes/events.mdx]` :

```lua
-- Server/Index.lua
Events.SubscribeRemote("MyServerEvent", function(player, my_text)
    Console.Log(player:GetName() .. " sent an event from client! " .. my_text)
    -- sends an "answer" to the player which sent this event
    Events.CallRemote("MyClientEvent", player, Reliability.Reliable, "hello nanos world! message only for you!")
end)
Events.BroadcastRemote("MyClientEvent", Reliability.Reliable, "hello nanos world!")

-- Client/Index.lua
Events.SubscribeRemote("MyClientEvent", function(my_text)
    Console.Log("Event received from server! " .. my_text)
end)
Events.CallRemote("MyServerEvent", Reliability.Reliable, "hello nanos world!")
```

Événements distants **sur une entité** (hérités d'`Entity`) `[A Classes/BaseEntity.json]` :

| Signature | Côté |
|---|---|
| `entity:CallRemoteEvent(event_name: string, player: Player, reliability = Reliable, args...)` | S |
| `entity:CallRemotePlayersEvent(event_name: string, players: Player[], reliability = Reliable, args...)` | S |
| `entity:CallRemoteEvent(event_name: string, reliability = Reliable, args...)` | C |
| `entity:BroadcastRemoteEvent(event_name: string, reliability = Reliable, args...)` | S |
| `entity:BroadcastRemoteInRadiusEvent(event_name: string, radius: float, reliability = Reliable, args...)` | S |
| `Classe.SubscribeRemote(event_name, callback)` / `entity:SubscribeRemote(event_name, callback)` | S+C |

### 3.2 `Timer` (page `scripting-reference/static-classes/timer.mdx`, `[A StaticClasses/Timer.json]`)

Tout est **S+C**. « The shortest interval possible is equal to the local Tick Rate - usually at 33ms. On the Server this can vary depending on the Config.toml setting. »

| Signature | Retour | Documenté |
|---|---|---|
| `Timer.SetTimeout(callback: function, milliseconds: integer = 0, parameters...: any)` | `integer` (timeout_id) | exécute une fois ; `parameters...` sont passés au callback |
| `Timer.SetInterval(callback: function, milliseconds: integer = 0, parameters...: any)` | `integer` (interval_id) | répète ; **le callback peut retourner `false` pour s'arrêter** |
| `Timer.ClearTimeout(timeout_id: integer)` | | |
| `Timer.ClearInterval(interval_id: integer)` | | |
| `Timer.Bind(timer_id: integer, actor: Actor)` | | le timer est **effacé automatiquement** quand l'acteur est détruit |
| `Timer.IsValid(timer_id: integer)` | `boolean` | actif ou en attente |
| `Timer.GetElapsedTime(timer_id)` / `Timer.GetRemainingTime(timer_id)` | `integer` | depuis le dernier tick / jusqu'au prochain |
| `Timer.SetRemainingTime(timer_id, time: integer)` | | millisecondes |
| `Timer.Pause(timer_id)`, `Timer.Resume(timer_id)`, `Timer.ResetElapsedTime(timer_id)` | | |

Exemples copiés de la page :

```lua
local my_interval = Timer.SetInterval(function(param1, param2)
    Console.Log("Triggered each 2 seconds! Param1: " .. param1 .. ". Param2: " .. param2)
end, 2000, "awesome param 1", 456)
Timer.ClearInterval(my_interval)

Timer.SetTimeout(function(my_param)
    Console.Log("nanos " .. my_param)
end, 5000, "world")
```

Est-ce que les timers survivent à un rechargement du package ? **NON DOCUMENTÉ.** `[D core-concepts/server-and-client-lifecycle.mdx]` dit que les timers sont traités dans la boucle serveur (« Tick Entities, Timers and Async Callbacks »).

### 3.3 `Entity` (toutes les classes) — page `scripting-reference/classes/base-classes/entity.mdx`

Fonctions statiques (s'appellent sur la classe : `Player.GetAll()`, `Prop.GetByIndex(1)`), **S+C** :

| Signature | Retour |
|---|---|
| `Classe.GetAll()` | copie d'une table de toutes les entités de la classe |
| `Classe.GetPairs()` | itérateur pour `pairs()`, plus performant (pas de copie) ; **ne pas détruire dans la boucle** : utiliser `GetAll()` pour « boucler et détruire » |
| `Classe.GetByIndex(index: integer)` | l'entité ; `nil` si aucune à cet index (précisé dans `[D getting-started/essential-concepts.mdx]`, pas dans le JSON) |
| `Classe.GetCount()` | `integer` |
| `Classe.Inherit(name: string, custom_values: table = {})` | nouvelle classe (section 3.17) |
| `Classe.GetInheritedClasses(recursively = false)`, `GetParentClass()`, `IsChildOf(class)` | |
| `Classe.Subscribe`, `Classe.Unsubscribe`, `Classe.SubscribeRemote` | voir 2.1 |

Méthodes d'instance :

| Signature | Côté | Retour / notes |
|---|---|---|
| `entity:GetID()` | S+C | identifiant réseau universel (le même côtés serveur et client) |
| `entity:IsValid()` | S+C | `false` si détruite |
| `entity:IsA(class: table)` | S+C | **passer la classe, pas une chaîne** : `entity:IsA(Weapon)` ; vrai aussi pour les classes filles |
| `entity:GetClass()` | S+C | |
| `entity:Destroy()` | **Auth** | détruit ; déclenche `Destroy` ; détache les entités attachées ; **tous sauf `Player`** |
| `entity:SetValue(key: string, value: any, sync_on_clients: boolean = false)` | S+C | voir 4.5 |
| `entity:GetValue(key: string, fallback: any)` | S+C | `value` ou `fallback` |
| `entity:GetAllValuesKeys()` | **S** | `string[]` |
| `entity:Subscribe`, `Unsubscribe`, `SubscribeRemote` | S+C | |
| `entity:HasAuthority()` | **C** | `true` si créée par ce client |
| `entity:IsSpawned()`, `entity:FinishSpawn()`, `entity:SetSpawnMode(mode)`, `entity:IsBeingDestroyed()` | S+C | `SpawnMode` : `Immediate = 0`, `AfterConstructor = 1`, `Manual = 2` : différer l'envoi aux clients pour tout configurer d'abord, puis appeler `FinishSpawn()` |

### 3.4 `Player` — page `scripting-reference/classes/player.mdx`, `[A Classes/Player.json]`

« You cannot spawn or Destroy Players. » Récupérer les joueurs : `Player.GetAll()`, `Player.GetPairs()`, `Player.GetCount()` (hérités d'`Entity`) ou `Player.GetBySteamID(steam_id: string)` **S** (`Player?`).

| Signature | Côté | Retour / notes |
|---|---|---|
| `player:GetName()` | S+C | `string` |
| `player:SetName(player_name: string)` | S | |
| `player:GetSteamID()` | S+C | `string` (SteamID64) |
| `player:GetAccountID()` | S+C | `string` : ID de compte nanos world |
| `player:GetAccountName()` | S+C | `string` |
| `player:GetAccountIconURL()` | S+C | URL utilisable dans une WebUI (avatar Steam 64x64) |
| `player:GetIP()` | S | `string` |
| `player:GetPing()` | S+C | `integer`, ms |
| `player:Kick(reason: string)` | S | |
| `player:Ban(reason: string)` | S (`slow`) | |
| `player:Connect(ip: string, password: string = "")` | S | redirige vers un autre serveur (`IP:PORT`) |
| `player:Possess(new_pawn: Pawn, blend_time: float = 0, exp: float = 0)` | S | |
| `player:UnPossess()` | S | |
| `player:GetControlledCharacter()` | S+C | `Pawn?` : `nil` si le joueur ne possède rien |
| `player:GetDimension()` / `player:SetDimension(dimension: integer)` | S+C / S | |
| `player:SetValue(...)`, `player:GetValue(...)` | | hérités d'`Entity`, voir 4.5 |
| `player:IsLocalPlayer()` | **C** | |
| `player:IsHost()` | **C** | hôte d'un serveur P2P |
| `player:SetCameraLocation`, `SetCameraRotation`, `AttachCameraTo`, `Spectate`, `ResetCamera`, `StartCameraFade`, `SetCameraFOV`, `SetCameraArmLength`, ... | S+C | caméra (non détaillé ici) |
| `player:SetVOIP...`, `GetVOIPListeningChannels`, ... | | VOIP, 63 canaux globaux |
| `player:SetDistanceOptimizationMultiplier(multiplier)` | S | |

**NON DOCUMENTÉ** : une fonction pour récupérer un joueur par son nom ou son ID de compte (seul `GetBySteamID` existe) ; une propriété « argent » ou « admin » (il n'y en a pas : ce sont des `SetValue` à nous).

### 3.5 Personnages : `Character`, `Pawn`, `Damageable`, `Actor`

Pages : `scripting-reference/classes/character.mdx`, `.../base-classes/pawn.mdx`, `damageable.mdx`, `actor.mdx`, `pickable.mdx`. `Character` hérite de `Entity`, `Actor`, `Paintable`, `Damageable`, `Pawn`. Autorité : **classe instanciable côté serveur uniquement**.

Constructeur `[A Classes/Character.json]` :

```lua
Character(location: Vector, rotation: Rotator, skeletal_mesh_asset: SkeletalMeshPath,
          collision_type: CollisionType = CollisionType.Auto, gravity_enabled: boolean = true,
          max_health: integer = 100, death_sound: SoundPath = "nanos-world::A_Male_01_Death",
          pain_sound: SoundPath = "nanos-world::A_Male_01_Pain", spawn_mode: SpawnMode = SpawnMode.Immediate)
```

Exemple copié de `[D getting-started/quick-start.mdx]` : `Character(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Male")`. Maillages d'exemple de la page `character.mdx` : `SK_Male`, `SK_Female`, `SK_Mannequin`, `SK_Mannequin_Female`, `SK_PostApocalyptic`, `SK_ClassicMale` (clés vérifiées dans `[S DefaultAssetPack.toml]`).

**Santé et dégâts (`Damageable`)** :

| Signature | Côté | Retour / notes |
|---|---|---|
| `c:GetHealth()`, `c:GetMaxHealth()`, `c:IsDead()` | S+C | |
| `c:SetHealth(new_health: integer)` | S | **« You can only call it on alive Entities (call Respawn first) »** |
| `c:SetMaxHealth(max_health: integer)` | S | |
| `c:ApplyDamage(damage: integer, bone_name: string = "", damage_type: DamageType = DamageType.Shot, from_direction: Vector = Vector(0,0,0), instigator: Player = nil, causer: any = nil)` | S | retourne les dégâts appliqués ; déclenche les événements liés |
| `c:Respawn(location: Vector = position initiale, rotation: Rotator = Rotator(0,0,0))` | S | remplit la santé et déplace |
| `c:SetDamageMultiplier(bone_name, multiplier)`, `c:GetDamageMultiplier(bone_name)` | S / S+C | |
| `c:SetInvulnerable(is_invulnerable: boolean)`, `c:IsInvulnerable()` | S / S+C | (Character) |

`DamageType` : `Shot = 0`, `Explosion = 1`, `Punch = 2`, `Fall = 3`, `RunOverProp = 4`, `RunOverVehicle = 5`, `Melee = 6`, `Unknown = 7` (« anything else, such as scripted damage »).

**Position, état, lien avec le joueur** :

| Signature | Côté | Retour / notes |
|---|---|---|
| `c:GetPlayer()` | S+C | `Player?` : le joueur qui le possède (méthode de `Pawn`) |
| `c:GetLocation()`, `c:GetRotation()` | S+C | `Vector`, `Rotator` |
| `c:SetLocation(location: Vector)`, `c:SetRotation(rotation: Rotator)` | **Auth** | pas de `TeleportTo` dans l'API (voir ci-dessous) |
| `c:SetVisibility(is_visible)` | S+C | |
| `c:GetVelocity()` | S+C | |
| `c:GetControlRotation()` | S+C | `Rotator` : où le pawn regarde/vise |
| `c:SetDimension(dimension)` | S | |
| `c:GetTeam()` / `c:SetTeam(team: integer)` | S+C / S | 0 = neutre ; « disable damaging same Team Members » |
| `c:SetCameraMode(camera_mode)`, `c:SetViewMode(view_mode)` | S / NetAuth | `CameraMode.FPSTPS=0, FPSOnly=1, TPSOnly=2` ; `ViewMode.FPS=0, TPS1..TPS3, TopDown=4` |
| `c:SetSpeedMultiplier(speed_multiplier: float)` | S | 1 = normal |
| `c:SetInputEnabled(is_enabled: boolean)` | S | active/désactive l'entrée de ce personnage |
| `c:SetCanSprint`, `SetCanPunch`, `SetCanPickupPickables`, `SetCanGrabProps`, `SetCanUsePickables`, `SetCanDrop`, ... | S | autorisations (utilisées dans l'exemple « Play as Prop ») ; `SetCanJump` et `SetCanCrouch` (de `Pawn`) sont **Auth** |
| `c:SetMesh(skeletal_mesh_asset)` | S | change le maillage |
| `c:AddSkeletalMeshAttached(id, skeletal_mesh_path, socket = "", relative_location, relative_rotation, use_parent_bounds, use_base_leader_pose_component, animation_path, attachable_id)` | S+C | vêtements ; **ordre des paramètres changé en 1.144** |
| `c:AddStaticMeshAttached(id, static_mesh_path, socket = "", relative_location, relative_rotation, use_parent_bounds, attachable_id)` | S+C | cheveux, barbe, objets |
| `c:PlayAnimation(animation_path, slot_type = AnimationSlotType.FullBody, loop_indefinitely = false, blend_in_time = 0.25, blend_out_time = 0.25, play_rate = 1.0, stop_all_montages = false)` | S+C | |
| `c:LookAt(location: Vector)`, `c:MoveTo(location, acceptance_radius = 50)`, `c:Follow(actor, acceptance_radius = 50, stop_on_succeed, stop_on_fail, update_rate = 0.25)`, `c:StopMovement(stops_velocity = false)` | S (`LookAt`), Auth | IA : ne marche que si un joueur est connecté (la physique/IA est calculée par un client) |

**Téléportation : NON DOCUMENTÉ comme fonction dédiée.** Aucun fichier JSON ne contient « Teleport ». La seule méthode documentée pour placer un personnage est `SetLocation` (côté qui l'a créé), et `Respawn(location, rotation)` pour un personnage mort ou à remettre à une position `[A Classes/BaseActor.json]`, `[A Classes/BaseDamageable.json]`.

**Objets portés** :

| Signature | Côté | Retour / notes |
|---|---|---|
| `c:PickUp(pickable: Pickable)` | S | donne une arme/mêlée/grenade |
| `c:Drop()` | S | lâche ce qu'il tient |
| `c:GetPicked()` | S+C | `Pickable?` |
| `c:GrabProp(prop)`, `c:UnGrabProp()`, `c:GetGrabbedProp()` | S / S / S+C | |
| `c:EnterVehicle(vehicle: Vehicle, seat: integer = 0)` | S | siège 0 = conducteur |
| `c:LeaveVehicle()` | S | |
| `c:GetVehicle()`, `c:GetVehicleSeat()` | S+C | `Vehicle?` ; index du siège ou `-1` |

Constructeur et méthodes de `CharacterSimple` (personnage plus simple pour des PNJ) : `CharacterSimple(location, rotation, mesh: SkeletalMeshPath|StaticMeshPath, custom_animation_blueprint = "", collision_type = Auto, gravity_enabled = true, spawn_mode = Immediate)`, classe **S+C** ; exemple `CharacterSimple(Vector(100,0,100), Rotator(0,0,0), "nanos-world::SK_StackOBot", "nanos-world::ABP_StackOBot")` puis `stack_o_bot:SetSpeedSettings(275, 150)`.

**Paramètres d'`Actor` utiles** (page `actor.mdx`) : `AttachTo(other: Actor, attachment_rule = AttachmentRule.SnapToTarget, bone_name = "", lifespan_when_detached = -1, use_absolute_rotation = false)` (Auth, retourne `boolean`), `Detach()`, `SetLifeSpan(seconds: float)` (Auth), `SetScale(scale: Vector)`, `SetRelativeLocation(...)`, `TranslateTo(location, time, exp = 0)`, `RotateTo(rotation, time, exp = 0)` (NetAuth, déplacement progressif), `AddImpulse(impulse: Vector, velocity_change = false)` (NetAuth), `SetGravityEnabled(bool)`, `SetCollision(collision_type)`, `GetBounds()` (C), `SetNetworkAuthority(player = nil)` (S). La doc prévient : « Some of the following methods may not work on certain Actor classes. »

### 3.6 `Chat` — page `scripting-reference/static-classes/chat.mdx`, `[A StaticClasses/Chat.json]`

| Signature | Côté | Notes |
|---|---|---|
| `Chat.BroadcastMessage(message: string)` | S | à tous les joueurs ; exemple `Chat.BroadcastMessage("Welcome to the server!")` |
| `Chat.SendMessage(player: Player, message: string)` | S | à un seul joueur |
| `Chat.AddMessage(message: string)` | **C** | message local |
| `Chat.SetConfiguration(screen_location, size, anchors_min, anchors_max, alignment, justify, show_scrollbar)` | C | position et aspect |
| `Chat.SetVisibility(is_visible: boolean)`, `Chat.Clear()` | C | |
| `Chat.Subscribe(event_name, callback)`, `Chat.Unsubscribe(...)` | S+C | |

Texte enrichi : entourer le texte d'une balise `<TAG>mon texte</>` ; balises : `<cyan>`, `<green>`, `<blue>`, `<purple>`, `<marengo>`, `<yellow>`, `<orange>`, `<red>`, `<grey>`, `<bold>`, `<italic>` ; **impossible de combiner** deux styles (exemple : `Chat.BroadcastMessage("Hello with <cyan>Cyan</> text message!")`).

**Commandes de chat : NON DOCUMENTÉ comme fonctionnalité native.** La seule brique documentée est `Chat.Subscribe("PlayerSubmit", function(message, player) ... end)` (retour `false` = ne pas diffuser le message) : un parseur de commandes (par exemple messages commençant par `/`) est à écrire soi-même. Pour des commandes saisies dans la console du serveur : `Console.RegisterCommand` (3.7).

### 3.7 `Server`, `Console`, `Debug` — pages `scripting-reference/static-classes/server.mdx`, `console.mdx`, `debug.mdx`

Tous les appels de `Server` sont **S**.

| Signature | Retour / notes |
|---|---|
| `Server.GetTime()` | `integer` : temps Unix en **millisecondes** |
| `Server.GetTickRate()` | `integer` |
| `Server.GetCustomSettings()` | table des réglages personnalisés (`settings.max_props`) |
| `Server.SetValue(key: string, value: any, sync_on_client: boolean = false)`, `Server.GetValue(key, fallback)`, `Server.GetAllValuesKeys()` | valeurs globales ; lues côté client par `Client.GetValue` |
| `Server.GetMapSpawnPoints()` | liste de tables `{ location: Vector, rotation: Rotator }` |
| `Server.AddMapSpawnPoint(location, rotation = Rotator())` | |
| `Server.GetMapConfig()` | section `[custom_data]` de la map |
| `Server.GetMap()` / `Server.GetMapAsset()` | nom du package de map / référence de l'asset |
| `Server.GetPlayersInRadius(location, radius, dimension = 0)` | `Player[]` |
| `Server.GetActorsInRadius(location, radius, only_classes: string[] = [], dimension = 0)` | `Actor[]` (0 = toutes dimensions) |
| `Server.GetEntityByID(entity_id: integer)` | `Entity?` |
| `Server.KickByAccountID(player_account_id: string, reason: string)` | idéal dans `PlayerConnect` |
| `Server.BanByAccountID(player_account_id, reason)`, `Server.Unban(account_id)` | |
| `Server.GetConnectionCount()` | joueurs connectés (ou en cours de connexion) |
| `Server.GetName()`, `GetDescription()`, `GetMaxPlayers()`, `GetIP()`, `GetPort()`, `GetVersion()` | informations ; leurs `Set...(valeur, persist_to_config_file = false)` existent pour `Name`, `Description`, `MaxPlayers`, `Password`, `Logo` |
| `Server.LoadPackage(name)`, `ReloadPackage(name)`, `UnloadPackage(name)`, `IsPackageLoaded(name)`, `GetPackages(only_loaded = true, package_type_filter = PackageType.All)` | `boolean` ; rechargements effectifs au tick suivant |
| `Server.ChangeMap(map_path)`, `Server.Restart()`, `Server.Stop()` | |
| `Server.SetDefaultPlayerDimension(d)`, `SetDefaultEntityDimension(d)`, `GetDefault...` | |
| `Server.Subscribe(event_name, callback)`, `Server.Unsubscribe(...)` | événements 2.3 |

Il n'y a **pas** de `Server.GetPlayers()` : utiliser `Player.GetAll()` ou `Player.GetPairs()`.

`Console` (S+C) `[A StaticClasses/Console.json]` :

| Signature | Notes |
|---|---|
| `Console.Log(message: string, args...: any)` | formate avec `string.format` : `Console.Log("Player health: %d/%d", health, max_health)` |
| `Console.Warn(message, args...)` | orange, avec trace de pile |
| `Console.Error(message, args...)` | rouge, avec trace de pile |
| `Console.Debug(message, args...)` | affiché seulement aux niveaux de log Debug/Verbose |
| `Console.RegisterCommand(command: string, callback: function, description: string = "", parameters: string[] = {})` | commande de console ; exemple : `Console.RegisterCommand("hello", function(text) Chat.BroadcastMessage("Hello " .. text) end, "says a message to everyone", { "my_text" })` ; type exact des arguments reçus : **NON DOCUMENTÉ** |
| `Console.RunCommand(command: string)` | seulement les commandes **enregistrées par script** |

Il n'existe **pas** de `Package.Log` : les journaux passent par `Console.*` ou `print`. `NanosTable.Dump(table)` (3.14) affiche une table.

`Debug` (**C seulement**) dessine dans le monde : `Debug.DrawLine(start, end, color = Color.RED, life_time = 5, thickness = 0)`, `DrawPoint`, `DrawSphere`, `DrawBox`, `DrawString(location, text, color, life_time, draw_shadow, font_scale)`, etc. Exemple copié : `Debug.DrawSphere(my_character:GetLocation(), 50, 12, Color.RED, 10)`.

### 3.8 `Prop`, `StaticMesh`, `Trigger`, `Light`, `Sound`, `Particle`, textes

**Prop** (S+C ; page `prop.mdx`) :

```lua
Prop(location: Vector, rotation: Rotator, asset: StaticMeshPath, collision_type = CollisionType.Auto,
     gravity_enabled = true, grab_mode: GrabMode = GrabMode.Auto, ccd_mode: CCDMode = CCDMode.Auto,
     spawn_mode = SpawnMode.Immediate)
```

Exemple copié : `Prop(Vector(200, 0, 0), Rotator(0, 0, 0), "nanos-world::SM_WoodenTable")`. Si un `Prop` est créé **côté client**, toutes ses interactions sont désactivées. Méthodes : `SetGrabMode(grab_mode)` S, `SetMesh(asset)` Auth, `GetMesh()`, `GetHandler()` (`Character?`), `SetMassOverride(mass)`, `SetPhysicsDamping`, ... Hérite de `Actor` (`SetLifeSpan`, `AddImpulse`, ...) et de `Paintable` (`SetMaterial`, `SetMaterialColorParameter("Tint", Color)`...).

**StaticMesh** (S+C) : `StaticMesh(location, rotation, static_mesh_asset, collision_type = Auto, spawn_mode = Immediate)` ; ne bouge pas, plus léger qu'un `Prop` ; `SetMesh(asset)`, `GetMesh()`.

**Trigger** (S+C ; page `trigger.mdx`) :

```lua
Trigger(location: Vector, rotation: Rotator, extent: Vector|float, trigger_type: TriggerType = TriggerType.Sphere,
        is_visible: boolean = false, color: Color = Color.RED, overlap_only_classes: string[] = {})
```

`extent` = rayon pour une sphère, sinon demi-dimensions (`Vector`). `TriggerType.Sphere = 0`, `Box = 1`. Méthodes : `SetExtent(extent)` Auth, `SetColor(color)`, `SetOverlapOnlyClasses(classes: string[])` Auth (exemple : `my_trigger:SetOverlapOnlyClasses({ "Character", "CharacterSimple" })`), `ForceOverlapChecking()` Auth. Exemples copiés : `Trigger(Vector(0, 0, 100), Rotator(), 150)` (porte) ; `Trigger(Vector(-200, 100, 500), Rotator(), Vector(100), TriggerType.Sphere, true, Color(1, 0, 0))`. `Vector(100)` = `Vector(100, 100, 100)` (les composantes manquantes valent X).

**Light** (S+C) : `Light(location, rotation = Rotator(0,0,0), color = Color(1,1,1), light_type = LightType.Point, intensity = 30, attenuation_radius = 250, cone_angle = 44, inner_cone_angle_percent = 0, max_draw_distance = 10000, use_inverse_squared_falloff = true, cast_shadows = true, visible = true, source_radius = 2, spawn_mode = Immediate)`. `LightType.Point=0, Spot=1, Rect=2`. « All lights are Dynamic and because of that, very expensive! ». Méthodes : `SetColor`, `SetIntensity`, `SetAttenuationRadius`, `SetCastShadows`, `SetVisibility` (hérité d'`Actor`).

**Sound** (**C seulement**) : `Sound(location, asset: SoundPath, is_2d_sound = false, auto_destroy = true, sound_type = SoundType.SFX, volume = 1, pitch = 1, inner_radius = 400, falloff_distance = 3600, attenuation_function = AttenuationFunction.Linear, keep_playing_when_silent = false, loop_mode = SoundLoopMode.Default, auto_play = true)`. Méthodes `Play`, `Stop`, `SetVolume`, `SetPitch`, `FadeIn`, `FadeOut`... Un fichier `.ogg` brut est lisible : `Sound(Vector(), "package://my-package/Client/awesome_beep.ogg", true)`. Pour faire entendre un son à tous depuis le serveur : événement distant (voir exemple Fireworks de `[D getting-started/tutorials-and-examples/fireworks.mdx]`).

**Particle** (S+C) : `Particle(location, rotation, asset: ParticlePath, auto_destroy = true, auto_activate = true, spawn_mode = Immediate)` ; paramètres `SetParameterFloat/Int/Bool/Vector/Color(parameter, value)`. Cascade et Niagara sont pris en charge.

**Textes dans le monde** : `TextRender(location, rotation, text, word_size = 26, color = Color.WHITE, rendering_type = TextRenderRenderingType.Lit, horizontal_alignment, vertical_alignment, font_asset = "", cast_shadow = false)` (S+C ; méthodes `SetText`, `SetColor`, `SetWordSize`, ...) ; `Text3D(location, rotation, text, scale = Vector(1,1,1), color = Color(1,1,1,1), font_type = FontType.Roboto, align_camera = Text3DAlignCamera.Unaligned)` (S+C, **expérimental**, plus lourd, `SetText`, ...). `TextRender` correspond à la nouvelle classe depuis la version 1.103 (voir 9.1). Exemple de « name tag » copié de `[D getting-started/tutorials-and-examples/name-tags.mdx]` (Client) : un `TextRender` attaché au personnage avec `nametag:AttachTo(character)` et `nametag:SetRelativeLocation(Vector(0, 0, 250))`, stocké avec `player:SetValue("Nametag", nametag)`, créé sur `Character.Subscribe("Possess", function(character, player) ... end)`, détruit sur `"UnPossess"`.

**Billboard** (**C seulement**) : `Billboard(location, material_asset, size = Vector2D(32,32), size_in_screen_space = false)`.

### 3.9 `Weapon`, `Melee`, `Grenade`

**Weapon** (classe **S**, page `weapon.mdx`) :

```lua
Weapon(location: Vector, rotation: Rotator, asset: SkeletalMeshPath, collision_type = CollisionType.Auto,
       gravity_enabled = true, spawn_mode = SpawnMode.Immediate)
```

Exemple copié de la page : `Weapon(Vector(-900, 185, 215), Rotator(0, 0, 0), "nanos-world::SK_AK47")`, puis `SetAmmoSettings(30, 1000)`, `SetDamage(30)`, `SetSpread(30)`, `SetRecoil(0.25)`, `SetBulletSettings(1, 20000, 20000, Color(100, 58, 0))`, `SetCadence(0.1)`, `SetHandlingMode(HandlingMode.DoubleHandedWeapon)`... Méthodes de lecture S+C : `GetAmmoClip()`, `GetAmmoBag()`, `GetDamage()`, `GetCadence()`, ... Écriture S : `SetAmmoClip(n)`, `SetAmmoBag(n)`, `SetAmmoSettings(ammo_clip, ammo_bag, ammo_to_reload = ammo_clip, clip_capacity = ammo_clip)`, `SetDamage(damage: integer)`, `Reload()`, `SetAutoReload(bool)`. Hérite de `Pickable` : `PullUse(release_use_after = -1)`, `ReleaseUse()`, `SetPickable(bool)`, `SetCanUse(bool)`, `GetHandler()` (`Character?`).

Armes **prêtes à l'emploi** : le package du Vault `default-weapons` définit des classes globales (`AR4`, `AK47`, `Glock` apparaissent dans les tutoriels) ; l'ajouter à `packages_requirements` ; classes disponibles « both as globals and in the NanosWorldWeapons table » `[D getting-started/tutorials-and-examples/weapon-scope.mdx]`. La liste complète des classes de `default-weapons` : **NON DOCUMENTÉ dans ce clone** (renvoi vers `https://github.com/nanos-world/default-weapons`, cité par `[D explore/game-modes-and-packages.mdx]`).

**Melee** (S) : `Melee(location, rotation, asset: StaticMeshPath, collision_type, gravity_enabled, handling_mode = HandlingMode.Torch, crosshair_material = "", can_use = true, spawn_mode)` ; `SetBaseDamage`, `SetCooldown`, `AddAnimationCharacterUse(asset_path, play_rate, slot_type)`, `SetDamageSettings(damage_start_time, damage_duration_time)`.

**Grenade** (S) : `Grenade(location, rotation, static_mesh_asset = "nanos-world::SM_Grenade_G67", explosion_particles = "nanos-world::P_Grenade_Special", explosion_sound = "nanos-world::A_Explosion_Large", ...)` ; `Explode()`, `SetDamage(base_damage = 90, minimum_damage = 0, damage_inner_radius = 200, damage_outer_radius = 1000, damage_falloff = 1)`, `SetTimeToExplode(time)`.

### 3.10 Véhicules : `VehicleWheeled` et base `Vehicle`

Pages `scripting-reference/classes/vehiclewheeled.mdx`, `.../base-classes/vehicle.mdx`, `[A Classes/VehicleWheeled.json]`, `[A Classes/BaseVehicle.json]`. Classe **S**.

Constructeur :

```lua
VehicleWheeled(location: Vector, rotation: Rotator, asset: SkeletalMeshPath, collision_type = CollisionType.Auto,
    gravity_enabled = true, auto_unflip = true, engine_sound = "nanos-world::A_Vehicle_Engine_01",
    horn_sound = "nanos-world::A_Vehicle_Horn_Toyota", brake_sound = "nanos-world::A_Vehicle_Brake",
    engine_start_sound = "nanos-world::A_Car_Engine_Start", vehicle_door_sound = "nanos-world::A_Vehicle_Door",
    auto_start_engine = true, custom_animation_blueprint = "", spawn_mode = SpawnMode.Immediate)
```

Les exemples de la doc configurent un véhicule **entièrement par code** : roues, sièges et portes, volant, phares (la doc renvoie vers le package `default-vehicles` pour des véhicules « already properly configured and ready to use »). Exemple complet (« Monster Truck ») copié de `[D getting-started/tutorials-and-examples/monster-truck.mdx]` :

```lua
local vehicle = VehicleWheeled(Vector(0, 0, 100), Rotator(), "nanos-world::SK_Pickup", CollisionType.Normal, true, false,
    "nanos-world::A_Vehicle_Engine_10", "nanos-world::A_Vehicle_Horn_Toyota", "nanos-world::A_Vehicle_Brake",
    "nanos-world::A_Car_Engine_Start", "nanos-world::A_Vehicle_Door", true, "", SpawnMode.AfterConstructor)

vehicle:SetEngineSetup(4500)
vehicle:SetSteeringWheelSetup(Vector(0, 27, 120), 24)
vehicle:SetHeadlightsSetup(Vector(250, 0, 70))
vehicle:SetWheel(0, "Wheel_Front_Left",  80, 60, 30, Vector(0, -80, 0))
vehicle:SetWheel(1, "Wheel_Front_Right", 80, 60, 30, Vector(0,  90, 0))
vehicle:SetWheel(2, "Wheel_Rear_Left",   80, 60,  0, Vector(0, -80, 0))
vehicle:SetWheel(3, "Wheel_Rear_Right",  80, 60,  0, Vector(0,  90, 0))
-- Parameters: seat index, door trigger location, seat location, seat rotation, trigger radius, leave lateral offset
vehicle:SetDoor(0, Vector(50, -75, 105), Vector( 8, -32.5,  95), Rotator(0, 0, 10), 70, -150)
vehicle:SetDoor(1, Vector(50,  75, 105), Vector(25,    50,  90), Rotator(0, 0,  0), 70,  150)
vehicle:FinishSpawn()
```

Méthodes de configuration (S) : `SetEngineSetup(max_torque = 700, max_rpm = 5700, idle_rpm = 1200, ...)`, `SetAerodynamicsSetup(mass = 1500, ...)`, `SetTransmissionSetup(...)`, `SetSteeringSetup(steering_type, angle_ratio = 0.7, steering_curve)`, `SetDifferentialSetup(differential_type, front_rear_split = 0.5)`, `SetWheel(index, bone_name, radius = 32, width = 20, max_steer_angle = 50, offset, ...)` (beaucoup de paramètres facultatifs de suspension et de frein), `SetDoor(seat_index, offset_location, seat_location, seat_rotation, trigger_radius, leave_lateral_offset)`, `SetHeadlightsSetup`, `SetTaillightsSetup`, `SetSteeringWheelSetup`.

Méthodes d'exécution : `v:Horn(enable_horn: boolean)` S, `v:SetEngineStarted(started: boolean)` S, `v:SetAutoStartEngine(bool)` S, `v:SetHeadlightsEnabled(bool)` S, `v:IsEngineStarted()` S+C, `v:GetPassenger(seat: integer)` (`Character?`), `v:GetPassengers()` (`Character[]`), `v:GetDoors()`, `v:SetTireFlat(wheel_index, is_flat)`, `v:GetRPM()` / `GetGear()` (C). `Damageable` : un véhicule a santé et explosion (`SetExplosionSettings(...)`). Entrée/sortie : `character:EnterVehicle(vehicle, seat)` (S) ; événements en 2.4.

Le package officiel `default-vehicles` (Vault) contient des véhicules « already properly configured and ready to use » ; classes et noms : **NON DOCUMENTÉ dans ce clone**. Maillages de véhicules de base, clés vérifiées dans `[S DefaultAssetPack.toml]` : `SK_Pickup`, `SK_Sedan`, `SK_Hatchback`, `SK_Van`, `SK_SportsCar`, `SK_CamperVan`, `SK_Offroad`, `SK_Truck_Box`, `SK_Truck_Chassis`.

### 3.11 Vecteurs et couleurs (structs) — pages `scripting-reference/structs/*.mdx`

Aucun côté n'est précisé pour les structs et bibliothèques utilitaires (pas de champ `authority` dans leurs JSON). Interprétation (non écrite dans la doc) : ce sont des outils de calcul disponibles des deux côtés.

**Vector** `[A Structs/Vector.json]` : `Vector(X: float = 0, Y: float = X, Z: float = X)`, propriétés `X`, `Y`, `Z`. Opérateurs : `+ - * /` (avec `Vector` ou nombre), `^`, `==`, `-` unaire, `tostring`. Méthodes : `Distance(other)`, `DistanceSquared(other)`, `Size()`, `SizeSquared()`, `Dot(other)`, `Cross(other)`, `Equals(other, tolerance = 0.000001)`, `GetSafeNormal(tolerance)`, `GetUnsafeNormal()`, `Normalize(tolerance)` (en place, retourne si modifié), `IsNear(other, radius)`, `IsNearlyZero(tolerance)`, `IsZero()`, `ToOrientationRotator()`, `ToOrientationQuat()`. Exemples des tutoriels : `forward_vector * Vector(200)`, `shooter:GetLocation() + Vector(0, 0, 40)`, `character:GetLocation():Distance(target:GetLocation()) > 1000` (1000 unités = 10 m) `[D core-concepts/scripting/security-remote-events.mdx]`.

**Rotator** `[A Structs/Rotator.json]` : `Rotator(pitch: float = 0, yaw: float = pitch, roll: float = pitch)` (degrés). Opérateurs `+ - *`, `tostring`. `Rotator.Random(roll = false, min = -180, max = 180)`, `GetForwardVector()`, `GetRightVector()`, `GetUpVector()`, `RotateVector(v)`, `UnrotateVector(v)`, `Normalize()`, `GetNormalized()`, `Quaternion()`, `Equals`, `IsZero`, `IsNearlyZero`.

**Color** `[A Structs/Color.json]` : `Color(R, G, B, A = 1)`, composantes **0 à 1** (la page d'API écrit « G: float = X, B: float = X » : coquille de la doc, voir section 11). Constantes : `Color.WHITE, BLACK, TRANSPARENT, RED, GREEN, BLUE, YELLOW, CYAN, MAGENTA, ORANGE, CHARTREUSE, AQUAMARINE, AZURE, VIOLET, ROSE`. `Color.FromRGBA(r, g, b, a)` (plage 0-255), `FromHEX(hex)`, `FromHSV`, `FromHSL`, `FromCYMK`, `Color.Random()`, `Color.RandomPalette(includes_black = true)`, `color:ToHex(appends_transparency = true)`.

**Vector2D** : `Vector2D(X = 0, Y = X)`, utilisé pour le HUD et le dessin à l'écran ; `Quat`, `Matrix` existent (non détaillés ici).

### 3.12 Bibliothèques standard (étendues par nanos)

**math** (natif) `[A StandardLibraries/math.json]` : `pi`, `huge`, `ceil`, `floor`, `abs`, `min`, `max`, `fmod`, `modf`, `sqrt`, `exp`, `log(x, base)`, `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `rad`, `deg`, `random(m, n)`, `randomseed(seed)`. `math.random()` : flottant entre 0 et 1 ; `math.random(m, n)` : entier dans l'intervalle.

**string** `[A StandardLibraries/string.json]` : fonctions Lua (`format`, `sub`, `find`, `match`, `gmatch`, `gsub`, `lower`, `upper`, `len`, `rep`, `reverse`, `byte`, `char`, `dump`) **plus** extensions nanos utilisables en `s:Methode()` ou `string.Methode(s)` : `StartsWith(other_string)`, `EndsWith(other_string)`, `Trim()`, `FormatArgs(args...)` (remplace `{1}`, `{2}`... : `("Hello {2} I'm {1}"):FormatArgs("a noob", "world!")`), `ToTable()` (tableau de caractères).

**table** `[A StandardLibraries/table.json]` : `insert(tbl, position, value)`, `remove(tbl, index)`, `sort(tbl, sorter)` (instable), `concat(tbl, separator = "", start_pos = 1, end_pos = #tbl)`, `move(...)`.

### 3.13 `NanosMath`, `NanosUtils`, `NanosTable`

Bibliothèques utilitaires open source (dépôt `nanos-world/nanos-world-lua-lib` d'après `[D core-concepts/scripting/classes-guide.mdx]`).

| Signature | Retour |
|---|---|
| `NanosTable.Dump(table: table)` | `string` lisible (exemple : `Console.Log(NanosTable.Dump(tbl))`) |
| `NanosTable.ShallowCopy(table)` | copie superficielle |
| `NanosUtils.IsEntityValid(entity: any)` | `boolean` |
| `NanosUtils.Benchmark(name: string, amount: number, func: function, args...)` | millisecondes ; écrit en console : `Benchmark 'My Heavy Operation' (x1000) took 1.5ms` |
| `NanosMath.Round(value, decimals = 0)`, `Clamp(value, min, max)`, `ClampAxis(value)` (0 à 360), `NormalizeAxis(value)` (-180 à 180), `RandomFloat(min, max)` | nombres |
| `NanosMath.FInterpTo`, `VInterpTo`, `RInterpTo`, `VInterpConstantTo`, `RInterpConstantTo`, `RelativeTo`, `LocalToWorld` | interpolations et repères (non détaillés) |
| `JSON.stringify(value: table)` / `JSON.parse(value: string)` | section 4.4 |
| `TOML.Dump(value: table)` / `TOML.Parse(value: string)` | section 4.4 |

### 3.14 `Input` (C seulement) — page `scripting-reference/static-classes/input.mdx`

| Signature | Notes |
|---|---|
| `Input.Register(binding_name: string, key_name: string, description: string?)` | crée un Key Binding (avec touche par défaut) visible dans les réglages |
| `Input.Bind(binding_name: string, input_event: InputEvent, callback: function)` | `InputEvent.Pressed = 0`, `Released = 1` ; peut aussi lier les bindings **natifs** (`"MoveForward"`, `"Jump"`, `"Crouch"`...) |
| `Input.Unbind(binding_name, input_event, callback = nil)`, `Input.Unregister(binding_name)`, `Input.ResetBindings()` | |
| `Input.IsKeyDown(key_name)`, `Input.IsBindingDown(binding_name)` | |
| `Input.GetMappedKeys(binding_name)` (`string[]`), `Input.GetKeyIcon(key_name, dark_mode = false)` (chemin d'icône) | pour afficher la touche dans l'UI |
| `Input.SetMouseEnabled(is_enabled: boolean)`, `Input.IsMouseEnabled()` | montrer/cacher le curseur |
| `Input.SetInputEnabled(enable_input: boolean)` | bloque/débloque l'entrée du joueur local |
| `Input.GetKeyboardLayout()` | `KeyboardLayout.Unknown=0, QWERTY=1, AZERTY=2, QWERTZ=3` |

Exemple copié de `[D core-concepts/scripting/input-and-key-bindings.mdx]` :

```lua
Input.Register("OpenShop", "B", "Opens the Shop")
Input.Bind("OpenShop", InputEvent.Pressed, function()
    Console.Log("Opening the shop!")
end)
```

« Remember to always restore the mouse and the input when the menu closes, otherwise the player will be stuck! »

### 3.15 Traces (C seulement)

`Trace.LineSingle(start_location, end_location, collision_channel = CollisionChannel.WorldStatic, trace_mode = 0, ignored_actors = {})` retourne une table : `Success`, `Location`, `ImpactPoint`, `Normal`, `Entity` (**seulement si** `TraceMode.ReturnEntity`), `BoneName`/`ActorName`/`ComponentName` (`ReturnNames`), `SurfaceType` (`ReturnPhysicalMaterial`), `UV`, `Item`. Variantes `LineMulti`, `SphereSingle/Multi`, `BoxSingle/Multi`, `CapsuleSingle/Multi`. Combiner les canaux et modes avec `|`. Le serveur ne fait pas la physique : « If the server needs the result, send it through a Remote Event (and validate it, as the client could send anything) » `[D core-concepts/scripting/traces-and-raycasting.mdx]`.

### 3.16 `Client` (C seulement) — page `scripting-reference/static-classes/client.mdx`

`Client.GetLocalPlayer()` (`Player`, disponible après `SpawnLocalPlayer`), `Client.ShowNotification(text, notification_type = NotificationType.Info, add_to_notification_list = true, duration = 10)` (`NotificationType.Info=0, Warning=1, Error=2, Fatal=3, Success=4`), `Client.SetValue(key, value)`, `Client.GetValue(key, fallback)`, `Client.GetTime()`, `Client.GetEntityByID(id)`, `Client.GetActorsInRadius(...)`, `Client.GetMap()`, `Client.Disconnect()`, `Client.SetHighlightColor(color, index, mode)`, `Client.SetOutlineColor(...)`, `Client.CopyToClipboard(text)`, `Client.GetSettings()`...

### 3.17 Héritage et extension de classes (**expérimental**)

Pages `[D core-concepts/scripting/inheriting-classes.mdx]` et `[D core-concepts/scripting/extending-classes.mdx]` : les deux portent l'avertissement « This feature is still **experimental** ».

```lua
-- classe fille
MyNewClass = Prop.Inherit("MyNewClass")
function MyNewClass:Constructor(location, rotation)
    -- ... logique ...
    self.Super:Constructor(location, rotation, "nanos-world::SM_Cube")   -- obligatoire
    self:SetMaterialColorParameter("Tint", Color.RED)
end
function MyNewClass:Explode() self:Destroy() end
```

* `self.Super:Methode(...)` appelle la méthode native ; pour appeler une méthode d'un parent intermédiaire : `MyNewClass.SetScale(self, scale)`.
* Étendre une classe native (ajouter une méthode) : `function Player:AddScore(score) self:SetValue("score", self:GetValue("score", 0) + score) end` ; surcharger : redéfinir, puis `self:Super(...)` (forme **différente** de `self.Super:Methode`).
* `Classe:newindex(key, value)` et `Classe:index(key)` (et **non** `__newindex`) redirigent l'écriture/lecture de champs vers `SetValue/GetValue`.
* Pour définir la classe des deux côtés, appeler `Inherit` dans un fichier `Shared/`.
* Événement `ClassRegister` et valeurs par défaut : `Prop.Inherit("MyNewClass", { name = "My Name", category = "breakable" })`.

---

## 4. Sauvegarde de données : tout ce que la doc propose

Cinq mécanismes sont documentés : les **données persistantes de package** (4.1), la classe **`Database`** (4.2), la classe **`File`** (4.3), les bibliothèques **`JSON`/`TOML`** pour (dé)sérialiser (4.4) et les **valeurs d'entité** (4.5, **en mémoire seulement**). Tableau de décision en 4.6, lacunes en 4.7.

### 4.1 Données persistantes de package (`Package.SetPersistentData`)

Sources : `[D core-concepts/scripting/persistent-data.mdx]`, `[A StaticClasses/Package.json]`.

Faits documentés :

* Format **TOML**, dans un fichier au nom du package : `Packages/.data/mon-package.toml`, **côté serveur et côté client**. Le fichier n'est créé que si on appelle `SetPersistentData`.
* Les données sont chargées automatiquement au chargement du package et gardées en mémoire.
* `Package.GetPersistentData(key: string = "")` (S+C, `slow`) : sans paramètre, retourne **toute** la table ; avec une clé, la valeur correspondante.
* `Package.SetPersistentData(key: string, value: any)` (S+C) : « Key to index data into. It can be separated by '.' to set a child element. » Mettre la valeur à **`nil` supprime**.
* `Package.FlushPersistentData()` (S+C, `slow`) : écrit immédiatement ; chaque appel réécrit **tout le fichier** : à éviter souvent.
* **Quand est-ce écrit sur le disque** : `SetPersistentData` ne modifie que la mémoire et marque « à sauvegarder » ; l'écriture se fait automatiquement « après un court délai » et **quand le package se décharge**. Le modèle de la doc : `Package.Subscribe("Unload", function() -- Save your data here, e.g. with Package.SetPersistentData end)` `[D core-concepts/packages/package-loading-and-lua-environment.mdx]`.
* Conseil officiel : « great for small amounts of data, such as settings or a small leaderboard. To store a lot of data or data which changes very often (like the inventory of every player), prefer using a Database ».

Exemples **copiés** de la page :

```lua
local my_table = {
    my_id = 123,
    my_data_02 = "data"
}
Package.SetPersistentData("awesome_table", my_table)
-- Packages/.data/my-package.toml will be:
-- awesome_table = { my_id = 123, my_data_02 = "data" }

Package.SetPersistentData("awesome_table.my_data_02", "another data")
-- awesome_table = { my_id = 123, my_data_02 = "another data" }

local my_table = Package.GetPersistentData("awesome_table")
Console.Log(my_table.my_id)   -- 123

Package.SetPersistentData("awesome_table", nil)   -- supprime
```

NON DOCUMENTÉ : taille maximale ; types acceptés au-delà des tables, nombres et chaînes (la sérialisation d'un `Vector` en texte est montrée par `TOML.Dump`, voir 4.4) ; comportement en cas de plantage du serveur avant l'écriture différée ; ce qui arrive si deux packages utilisent la même clé (le fichier est « named after your Package » : un fichier par package).

### 4.2 Classe `Database` (SQL) — page `scripting-reference/classes/database.mdx`, `[A Classes/Database.json]`

Classe **S** (serveur uniquement). Moteurs pris en charge « out of the box » : **SQLite (3.50), MySQL (8.1), PostgreSQL (17.5)**. Enum `DatabaseEngine` : `SQLite = 0`, `MySQL = 1`, `PostgreSQL = 2`.

Constructeur : `Database(database_engine: DatabaseEngine, connection_string: string, pool_size: integer = 10)`.

* « The initial connection to the Database (when it's being constructed) is made on the main thread, so expect the server hanging for a few seconds during that. »
* « If the Database fails to connect, it will spit an error on console and will return `nil`. » → tester le résultat avant de l'utiliser.
* « All requests are thread safe! »
* Placeholders de paramètres : `:0`, `:1`, ... (« use the following syntax: `:?` where ? is the placeholder argument (i.e. :0) passed into the function »). Les paramètres sont « Sequence of parameters to escape into the Query ».

Méthodes (S) :

| Signature | Retour | Notes |
|---|---|---|
| `db:Execute(query: string, parameters...: any)` | `integer, string` : lignes affectées, erreur éventuelle | **synchrone, `blocking`** : « Prefer ExecuteAsync to avoid freezing the server » |
| `db:ExecuteAsync(query: string, callback: function = nil, parameters...: any)` | | callback `(rows_affected: integer, error: string?)` |
| `db:Select(query: string, parameters...: any)` | `table[], string` : lignes, erreur éventuelle | synchrone, `blocking` |
| `db:SelectAsync(query: string, callback: function = nil, parameters...: any)` | | callback `(rows: table[], error: string?)` |
| `db:Close()` | | `slow` |

Depuis la version 1.29, `Select` et `Execute` sont synchrones (avant : asynchrones avec callback) ; les versions asynchrones sont `SelectAsync` et `ExecuteAsync` `[D core-concepts/packages/compatibility-versions.mdx]`. L'option de ligne de commande `--thread_pool_count` règle le nombre de threads des opérations asynchrones (HTTP, Database, File) `[D core-concepts/server-manual/server-configuration.mdx]`.

Exemple **copié** de la page (SQLite, fichier local) :

```lua
-- Creates a SQLite connection, using a local file called 'database_filename.db'
local sqlite_db = Database(DatabaseEngine.SQLite, "db=database_filename.db timeout=2")

-- Creates a table
sqlite_db:Execute([[
	CREATE TABLE IF NOT EXISTS test (
		id INTEGER,
		name VARCHAR(100)
	)
]])

-- Insert values in the table
local affected_rows = sqlite_db:Execute("INSERT INTO test VALUES (1, 'amazing')")
Console.Log("Affected Rows: " .. tostring(affected_rows))   -- Will output: 1

-- Selects the data
local rows = sqlite_db:Select("SELECT * FROM test")
Console.Log(NanosTable.Dump(rows))

-- Selects the data with filter
local rows_filter = sqlite_db:Select("SELECT * FROM test WHERE name = :0", "amazing")
```

Autres exemples du JSON : `my_database:Execute("INSERT INTO MyTable VALUES (:0, :1)", 123, "MyValue")` ; `my_database:SelectAsync("SELECT * FROM MyTable WHERE name = :0 AND title = :1", function(rows) Console.Log(NanosTable.Dump(rows)) end, "Val", "AnotherVal")`.

**Chaîne de connexion** : paramètres `param1=value1 param2=value2` séparés par des espaces, transmis tels quels au moteur.

| Moteur | Paramètres documentés |
|---|---|
| SQLite | `db` ou `dbname` (nom ; **le fichier `.db` est créé automatiquement s'il n'existe pas**), `timeout` (défaut `0`, secondes), `readonly` (défaut `false` ; le fichier doit déjà exister), `synchronous`, `shared_cache`, `vfs`. Chaîne spéciale **`:memory:`** : base en mémoire, **détruite à l'arrêt du serveur** |
| MySQL | `db`/`dbname`, `user`, `password`/`pass`, `host`, `port`, `unix_socket`, `sslca`, `sslcert`, `local_infile`, `charset`, `reconnect` (défaut `0`), `connect_timeout`, `read_timeout`, `write_timeout` |
| PostgreSQL | `host`, `hostaddr`, `port`, `user`, `dbname`, `password`, `connect_timeout` (défaut `0`), `options` |

NON DOCUMENTÉ : le **dossier** où est créé le fichier SQLite (la doc dit « a local file called ... ») ; le **format exact des lignes** retournées (le JSON dit seulement `table[]` ; les exemples n'accèdent pas aux champs) ; transactions ; récupération du dernier identifiant inséré ; comportement de `Close()` ; gestion des `NULL`.

### 4.3 Classe `File` — page `scripting-reference/classes/file.mdx`, `[A Classes/File.json]`

Classe S+C. Constructeur : `File(file_path: string, truncate: boolean = false)` (`truncate` vide le fichier à l'ouverture).

Règles d'accès « sandboxées » (documentées) :

* Extensions autorisées (lecture et écriture) : `.txt .dat .json .toml .xml .csv .log .png .jpg .jpeg .webp .webm .mp3 .wav .ogg .mp4`.
* **Serveur** : seulement dans le dossier du serveur (où se trouve l'exécutable), chemins relatifs à l'exécutable ; **`Config.toml` interdit**. Exemple de chemin dans un package : `Packages/My-Package/Server/MyFile.json`.
* **Client** : lecture seule dans le cache `Packages/` (exemple `../my-package/Client/MyFile.json`) ; écriture seulement dans `Packages/.transient/` (exemple d'écriture : `MyFile.json`).
* Tous les fichiers sont ouverts en **binaire** par défaut.

| Signature | Retour / notes |
|---|---|
| `f:Read(length: integer = 0)` | `string` ; 0 = tout ; `blocking` |
| `f:ReadAsync(length: integer = 0, callback: function)` | callback `(file_content: string)` |
| `f:ReadLine()` | `string` (ligne suivante) |
| `f:ReadJSON()` / `f:ReadJSONAsync(callback)` | table analysée |
| `f:Write(data: string)` | écrit à la position courante du fichier |
| `f:Seek(position)`, `f:Skip(amount)`, `f:Tell()`, `f:Size()`, `f:IsEOF()`, `f:IsBad()`, `f:IsGood()`, `f:HasFailed()` | positionnement et état |
| `f:Flush()`, `f:Close()` | `blocking` ; `Close` « closes the file and destroys the entity » |
| `File.Exists(path)`, `File.IsDirectory(path)`, `File.IsRegularFile(path)` | `boolean` |
| `File.CreateDirectory(path)` (`boolean`), `File.Remove(path)` (nombre de fichiers supprimés), `File.Rename(old_path, new_path)` (`boolean`) | |
| `File.GetFiles(path_filter, extension_filter, max_depth = -1)`, `File.GetDirectories(path_filter, max_depth = -1)` | `string[]` ; « results may differ between Linux and Windows » |
| `File.Time(path)` | dernière modification, temps Unix |

Exemple **copié** de la page :

```lua
local configuration_file = File("my_awesome_configuration.json")
local configuration_file_json = JSON.parse(configuration_file:Read())
```

NON DOCUMENTÉ : si `File(path)` **crée** le fichier absent ; comment écrire un JSON complet proprement (réécriture : `truncate = true` puis `Write(JSON.stringify(t))` est une **composition** de fonctions documentées, pas un exemple de la doc).

### 4.4 `JSON` et `TOML` — pages `scripting-reference/utility-libraries/json.mdx`, `toml.mdx`

| Signature | Retour | Exemple copié |
|---|---|---|
| `JSON.stringify(value: table)` | `string` | `JSON.stringify({ 1, 2, 3, { x = 10, y = Vector(1, 2, 3) }, "he" })` donne `[1,2,3,{"x":10,"y":"Vector(1.0, 2.0, 3.0)"},"he"]` |
| `JSON.parse(value: string)` | `any` | `JSON.parse('[1,2,3,{"x":10,"y":"Vector(1.0, 2.0, 3.0)"},"he"]')` redonne `{ 1, 2, 3, { x = 10, y = Vector(1, 2, 3) }, "he" }` |
| `TOML.Dump(value: table)` | `string` | `TOML.Dump({ 1, 2, 3, { x = 10, y = Vector(1, 2, 3) }, "he" })` donne `[ 1, 2, 3, { y = "Vector(1.000000, 2.000000, 3.000000)", x = 10 }, "he" ]` |
| `TOML.Parse(value: string)` | `any` | `TOML.Parse("my_table = [ 1, 2, 3 ]")` donne `{ my_table = { 1, 2, 3 } }` |

Avertissement officiel (JSON) : « custom classes (e.g. **Vehicle**, **Character**, **Prop**... etc) or **functions** are not supported to be stringified and will be nullified. **Structs** (Vector, Rotator, Color...) are supported ». La page décrit `JSON` comme « useful for sending data from Client's Package to WebUI environment ».

### 4.5 Valeurs d'entité et valeurs globales — `[D core-concepts/scripting/entity-values.mdx]`, `[A Classes/BaseEntity.json]`

* `entity:SetValue(key: string, value: any, sync_on_clients: boolean = false)` (S+C) et `entity:GetValue(key: string, fallback: any)`. Sur le **serveur**, `sync_on_clients = true` envoie la valeur à tous les clients, **y compris ceux qui se connectent plus tard**. Lisible depuis **n'importe quel package**.
* **Les valeurs sont sérialisées** : tout type sauf les `function` ; les références Lua ne sont pas conservées et les **tables sont copiées**. « Changing a table after setting it will not affect the stored value, call `SetValue()` again to update it. »
* Stocker une **entité** dans une valeur est possible, mais la valeur n'est **pas mise à `nil`** si l'entité est détruite : valider avec `IsValid()` après lecture (exemple name tags : `player:SetValue("Nametag", nametag)`).
* Toujours donner un repli : `player:GetValue("score", 0)` (sinon `nil` et erreur « attempt to perform arithmetic on a nil value »).
* Chaque changement d'une valeur synchronisée est envoyé à **tous** les clients : pour des valeurs qui changent très souvent (chaque tick), préférer des événements distants `Reliability.Unreliable`.
* Événement `ValueChange (self, key, value)` sur l'entité (aussi côté client pour les valeurs synchronisées) ; `entity:GetAllValuesKeys()` (S).
* **Valeurs globales** : `Server.SetValue(key, value, sync_on_client = false)` / `Server.GetValue(key, fallback)` (S) ; `Client.SetValue(key, value)` / `Client.GetValue(key, fallback)` (C ; ne vit que chez ce client). Événements `Server "ValueChange"`, `Client "ValueChange"`.

Exemples **copiés** :

```lua
-- Sets a synchronized 'score' value
my_player:SetValue("score", 100, true)
local score = my_player:GetValue("score", 0)
Server.SetValue("round_number", 1, true)

-- Client
Player.Subscribe("ValueChange", function(player, key, value)
    if (key == "score") then
        Console.Log("%s now has %d points!", player:GetName(), value)
    end
end)
```

Usage dans la doc : le score d'un joueur, `instigator:SetValue("kills", kills, true)` (exemple « Your First Game-Mode »). **Aucune persistance sur disque** n'est documentée pour ces valeurs : elles vivent avec l'entité (en mémoire) ; un `Player` qui se reconnecte est une **nouvelle** entité.

### 4.6 Quel mécanisme pour quoi (d'après les avertissements de la doc)

| Besoin | Mécanisme conseillé par la doc |
|---|---|
| État vivant, partagé avec les clients (argent affiché, score) | `SetValue(..., true)` sur le joueur |
| Réglages, petit classement | `Package.SetPersistentData` |
| Beaucoup de données ou données qui changent souvent (inventaire de chaque joueur) | `Database` |
| Importer/exporter un fichier de configuration | `File` + `JSON.parse` |
| Envoyer des données vers une WebUI | `JSON.stringify` (description de la bibliothèque) |
| Données qui changent chaque tick | **pas** une valeur synchronisée : événement distant `Unreliable` |

### 4.7 Ce que la doc ne propose pas

* Aucune sauvegarde **automatique** des joueurs : à écrire (par exemple sur `Player "Destroy"`, `Server "PlayerDisconnect"` et `Package "Unload"`). C'est une déduction du fait qu'aucune page ne décrit un tel mécanisme.
* Aucune clé « joueur » automatique : les clés à choisir sont `player:GetAccountID()` ou `player:GetSteamID()` (chaînes). Le nom n'est pas présenté comme identifiant ; `player:SetName(...)` existe, donc il peut changer.
* Aucun mécanisme de migration de schéma, de sauvegarde en cas de crash, de verrou : NON DOCUMENTÉ.

---

## 5. Sécurité : tout ce que disent « Never Trust the Client » et « Authority Concepts »

Sources : `[D core-concepts/scripting/security-remote-events.mdx]`, `[D core-concepts/scripting/authority-concepts.mdx]`, `[D core-concepts/scripting/events-guide.mdx]`, `[D core-concepts/scripting/player-lifecycle.mdx]`.

### 5.1 Le principe

« Everything which runs on the client can be changed by a malicious player: they can call any Remote Event, at any time, with any parameters, as many times as they want. Client scripts are downloaded to their computer, so they can also read them to know which events your server listens to. »

Donc le **serveur ne fait jamais confiance** à `Events.SubscribeRemote` ni à `Entity.SubscribeRemote`.

Mauvais exemple de la doc (à montrer comme **contre-exemple**) :

```lua
-- DON'T: any player can give themselves any amount of money, or damage anyone from anywhere
Events.SubscribeRemote("BuyItem", function(player, item_name, price)
    player:SetValue("money", player:GetValue("money", 0) - price)
    GiveItem(player, item_name)
end)

Events.SubscribeRemote("HitEnemy", function(player, enemy, damage)
    enemy:ApplyDamage(damage)
end)
```

(« A cheater could call `BuyItem` with a negative `price` to earn money, or `HitEnemy` with `damage = 99999` to kill everyone. »)

### 5.2 La règle d'or

Le client n'envoie que **l'intention** ; le serveur décide **si c'est permis** et **ce qui se passe**, avec des données qu'il connaît déjà. Exemple **copié** :

```lua
-- The prices are defined on the server, the client can't change them
local ITEM_PRICES = {
    medkit = 100,
    armor = 250,
}

-- DO: the client only says which item it wants
Events.SubscribeRemote("BuyItem", function(player, item_name)
    -- Validates the type and if the item exists
    if (type(item_name) ~= "string") then return end
    local price = ITEM_PRICES[item_name]
    if (not price) then return end

    -- Validates if the player can afford it
    local money = player:GetValue("money", 0)
    if (money < price) then return end

    player:SetValue("money", money - price, true)
    GiveItem(player, item_name)
end)
```

### 5.3 Quoi valider (liste de la doc)

| Contrôle | Détail documenté |
|---|---|
| **Types** | chaque paramètre est du type attendu ; un tricheur peut envoyer une table à la place d'un nombre ; `type(value)` ; pour les entités `value:IsValid()` et `value:IsA(SomeClass)` |
| **Plages** | pas de montants négatifs, pas de valeurs énormes, pas de `NaN` |
| **Propriété** | ce joueur peut-il agir sur cette entité (son personnage, un prop qu'il a créé) ? |
| **Distance** | assez près de la cible ? comparer la position de son personnage |
| **État** | action possible maintenant ? vivant, manche en cours, outil en main |
| **Cadence** | limiter le nombre d'actions par seconde |

Exemple **copié** (état, type, distance, cadence, nettoyage) :

```lua
-- Remembers the last time each player used the action
local last_use = {}

Events.SubscribeRemote("UseAbility", function(player, target)
    -- State: must be controlling a living Character
    local character = player:GetControlledCharacter()
    if (not character or character:IsDead()) then return end

    -- Types: the target must be a valid Character
    if (not target or not target:IsValid() or not target:IsA(Character)) then return end

    -- Distance: must be closer than 10 meters (1000 units)
    if (character:GetLocation():Distance(target:GetLocation()) > 1000) then return end

    -- Rate: once every 2 seconds
    local now = Server.GetTime() -- milliseconds
    if (last_use[player] and now - last_use[player] < 2000) then return end
    last_use[player] = now

    -- The server decides the damage
    target:ApplyDamage(25, "", DamageType.Unknown, Vector(), player, character)
end)

-- Cleans up when the player leaves
Player.Subscribe("Destroy", function(player)
    last_use[player] = nil
end)
```

Même schéma dans `[D getting-started/your-first-game-mode.mdx]` (étape « Taunt ») : le premier paramètre d'un événement distant côté serveur est le `Player` émetteur ; vérifier qu'il a un personnage vivant ; limiter à une fois toutes les 3 secondes avec `Server.GetTime()` ; nettoyer sur `Player "Destroy"`.

### 5.4 Autres conseils de la page

* **Secrets sur le serveur** : clés d'API, identifiants de base de données, logique à cacher, dans `Server/` (jamais envoyé). Tout `Client/` et `Shared/` est téléchargé par les joueurs.
* **Préférer les événements serveur** quand le jeu en déclenche déjà un (`Death`, `PickUp`, `EnterVehicle`) plutôt que d'attendre que le client le dise.
* **Utiliser les événements `Attempt*`** (retour `false`) pour bloquer une action côté serveur ; liste complète en 2.4 : `Character "AttemptEnterVehicle"`, `"AttemptLeaveVehicle"`, `"AttemptReload"`, `Vehicle "CharacterAttemptEnter"`, `"CharacterAttemptLeave"`, plus `Interact` (Character, Pickable, Prop), `Chat "PlayerSubmit"`, `Damageable "TakeDamage"` (multiplicateur) et `Server "PlayerConnect"` (par `KickByAccountID`).
* **Network Authority** : le client qui est Network Authority d'une entité en simule la physique, donc sa position peut être influencée par ce client : « Don't use physics positions alone to decide important things like who won a race. »
* **Kick/ban** : `player:Kick(reason)`, `player:Ban(reason)`, avec prudence (faux positifs dus au lag).
* **Refus de connexion** (liste blanche, exemple copié de `player-lifecycle.mdx`) :

```lua
local whitelist = {
    ["123456789"] = true,
}
Server.Subscribe("PlayerConnect", function(ip, player_account_id, player_name, player_steam_id)
    if (not whitelist[player_account_id]) then
        Server.KickByAccountID(player_account_id, "You are not in the whitelist!")
    end
end)
```

* `Config.toml` `banned_ids` : liste d'IDs de comptes nanos bannis, rejetés à la connexion.

### 5.5 Autorité (rappel utile à la sécurité)

* Entités créées **sur le serveur** : synchronisées partout. Entités créées **sur le client** : n'existent que pour ce client ; « trying to send those entities to the server will cause errors » `[D core-concepts/scripting/authority-concepts.mdx]`.
* Le code de `Shared/` s'exécute **des deux côtés** : si on y crée une entité, le serveur en crée une (synchronisée) **et** chaque client crée sa copie locale `[D getting-started/essential-concepts.mdx]`. Ne créer d'entités réseau que dans `Server/`.
* Un `Trigger` ne déclenche `BeginOverlap` que **chez celui qui l'a créé** : pour une logique serveur, le créer côté serveur.

### 5.6 Piège repéré dans les tutoriels

L'exemple **Gravity Gun** `[D getting-started/tutorials-and-examples/gravity-gun.mdx]` reçoit côté serveur `(player, object, is_grabbing)` et `(player, object, location)` et les applique **sans validation** (alors que la liste `tutorials-and-examples.mdx` annonce « validating the client input on the server »). À ne pas copier tel quel : l'encadré de la page renvoie vers « Never Trust the Client ».

Messages de chat : le `message` reçu par `Chat "PlayerSubmit"` côté serveur vient du client ; lui appliquer les mêmes validations (type, longueur, cadence) est l'application de la règle générale (non écrit tel quel dans la doc).

---

## 6. WebUI : créer, charger du HTML, échanger Lua et JavaScript

Sources : `[D scripting-reference/classes/webui.mdx]`, `[A Classes/WebUI.json]`, `[D core-concepts/scripting/user-interface.mdx]`, `[D getting-started/tutorials-and-examples/basic-hud-html.mdx]`, `[D getting-started/tutorials-and-examples/basic-hud-react.mdx]`, `[D core-concepts/scripting/debugging-and-logging.mdx]`, `[D core-concepts/scripting/input-and-key-bindings.mdx]`.

### 6.1 Nature

* `WebUI` est une classe **client uniquement** (`authority: client`) : un vrai navigateur **Chromium** (Chromium Embedded Framework, dernières versions). Le serveur ne peut ni la créer ni l'appeler : le serveur envoie un événement distant au client, qui appelle `webui:CallEvent`.
* Trois façons de faire une interface : `WebUI`, `Widget` (widgets Unreal), `Canvas` (dessin) `[D core-concepts/scripting/user-interface.mdx]`. Pour un HUD HTML/JS, c'est `WebUI`.

### 6.2 Création

```lua
WebUI(name: string, path: HTMLPath, visibility: WidgetVisibility = WidgetVisibility.Visible,
      is_transparent: boolean = true, auto_resize: boolean = true, width: integer = 0, height: integer = 0)
```

* `name` : nom pour les journaux de debug.
* `path` : « Web URL or HTML File Path as `file://my_file.html` ».
* `WidgetVisibility.Hidden = 0` (pas rendu, pas interactif), `Visible = 1` (rendu et interactif), `VisibleNotHitTestable = 2` (rendu mais **ignore la souris** : le choix naturel d'un HUD ; utilisé dans l'exemple React).

### 6.3 Chemins `file://` : ce qui est documenté

Exemples **copiés** de `webui.mdx` :

```lua
-- Loading a local file
local my_ui = WebUI("Awesome UI", "file://UI/index.html", WidgetVisibility.Visible)  -- relatif à ce package (Client/)

-- Loading a Web URL
local my_browser = WebUI("Awesome Site", "https://nanos-world.com", WidgetVisibility.Visible)

-- Loading a local file from other package
local my_ui = WebUI("Awesome Other UI", "file://other-package/Client/UI/index.html", WidgetVisibility.Visible)
```

Les recherches de fichier HTML, dans l'ordre : relatif au fichier courant ; relatif à `current-package/Client/` ; relatif à `current-package/` ; relatif à `Packages/`. Donc `file://UI/index.html` désigne `mon-package/Client/UI/index.html`.

Autres méthodes : `webui:LoadURL(url)` (par exemple `file://UI/index.html` ou `https://...`), `webui:LoadHTML(html: string)` (HTML brut), `webui:SetVisibility(visibility)`, `webui:BringToFront()`, `webui:SetLayout(location, size, anchors_min, anchors_max, alignment)`, `webui:SetFreeze(freeze)`, `webui:IsReady()`, `webui:GetName()`, `webui:Destroy()` (hérité d'`Entity`).

**`package://`** : n'est **pas** documenté comme chemin du constructeur `WebUI`. C'est un « SpecialPath » (`package://[PACKAGE_PATH]/[PATH/TO/FILE.jpg]`, `assets://[ASSET_PACK_PATH]/[PATH]`) documenté pour charger des **textures (.jpg, .png)**, des **sons (.ogg)** et pour « referencing files from **WebUI** » : c'est-à-dire pour qu'une page ou un package accède aux fichiers d'un autre package ou Asset Pack `[D scripting-reference/glossary/basic-types.mdx]`. Autre URL spéciale : `steam-avatar://player_steam_id` (images d'avatar, obtenue avec `player:GetAccountIconURL()`). Pour une WebUI, utiliser `file://` (documenté). Une page web chargée par `https://` : documenté ; accès réseau depuis la page : NON DOCUMENTÉ.

### 6.4 Échange Lua vers JavaScript et JavaScript vers Lua

Exemple **copié** de `user-interface.mdx` :

```lua
-- Client/Index.lua
MyUI = WebUI("My UI", "file://UI/index.html")

-- When the HTML is ready, triggers an Event in there
MyUI:Subscribe("Ready", function()
    MyUI:CallEvent("MyAwesomeEvent", "Hello! You are ready!")
end)

MyUI:Subscribe("MyAwesomeAnswer", function(param1)
    Console.Log("Received an answer! Message: " .. param1)
end)
```

```html
<!-- Client/UI/index.html -->
<html>
    <head>
        <script>
            // Register for "MyAwesomeEvent" from Lua
            Events.Subscribe("MyAwesomeEvent", function(param1) {
                console.log("Triggered! " + param1);
                // Triggers "MyAwesomeAnswer" on Lua
                Events.Call("MyAwesomeAnswer", "Hey there!");
            })
        </script>
    </head>
    <body>Hello World!</body>
</html>
```

Résultat documenté en console : `[WebUI]  Triggered! Hello! You are ready!` puis `[Script] Received an answer! Message: Hey there!`.

Récapitulatif de l'API des deux côtés :

| Direction | Lua | JavaScript |
|---|---|---|
| Lua vers page | `webui:CallEvent(event_name: string, args...: any)` | `Events.Subscribe(nom, function(a, b, c) {...})` |
| Page vers Lua | `webui:Subscribe("Nom", function(a) ... end)` | `Events.Call("Nom", args...)` |
| Désabonner | `webui:Unsubscribe("Nom")` | `Events.Unsubscribe("Nom")` |
| Page prête | `webui:Subscribe("Ready", fn)` | |

« Each argument after the event name arrives as a separate parameter in JavaScript » `[D getting-started/tutorials-and-examples/basic-hud-html.mdx]`. Passer des **tables** de Lua à JavaScript : NON DOCUMENTÉ explicitement ; la page `json.mdx` présente `JSON` comme utile pour envoyer des données du package client vers la WebUI. `webui:ExecuteJavaScript(javascript_code: string)` existe mais est « experimental and should be used cautiously. Events are still the preferred way ».

HUD complet de la doc (vie et munitions, à copier dans le cours) : voir le tutoriel `[D getting-started/tutorials-and-examples/basic-hud-html.mdx]` : `Client/UI/index.html` + `style.css` + `index.js` (jQuery 3.7.1 à télécharger dans `UI/`), puis dans `Client/Index.lua` :

```lua
main_hud = WebUI("Main HUD", "file://UI/index.html")

Client.Subscribe("SpawnLocalPlayer", function(local_player)
    local_player:Subscribe("Possess", function(player, character)
        UpdateLocalCharacter(character)
    end)
end)

Package.Subscribe("Load", function()
    local local_player = Client.GetLocalPlayer()
    if (local_player ~= nil) then
        UpdateLocalCharacter(local_player:GetControlledCharacter())
    end
end)

function UpdateHealth(health)
    main_hud:CallEvent("UpdateHealth", health)
end
-- ... character:Subscribe("HealthChange", function(charac, old_health, new_health) UpdateHealth(new_health) end)
```

```javascript
// Client/UI/index.js
Events.Subscribe("UpdateHealth", function(health) {
    $("#health_current").html(health);
    if (health <= 25)
        $("#health_container").css("background-image", "linear-gradient(to left, #0000, #d00c)");
});
```

Assemblage (non copié de la doc, composé de fonctions documentées) pour un HUD d'argent : côté serveur `player:SetValue("money", n, true)` ; côté client `Player.Subscribe("ValueChange", function(player, key, value) if (key == "money" and player == Client.GetLocalPlayer()) then main_hud:CallEvent("UpdateMoney", value) end end)` (même schéma que l'exemple Canvas de `your-first-game-mode.mdx` qui relit `kills`).

### 6.5 Clavier et souris dans une WebUI

Exemple **copié** de `input-and-key-bindings.mdx` :

```lua
function SetMenuOpen(is_open)
    Input.SetMouseEnabled(is_open)       -- shows the mouse cursor
    Input.SetInputEnabled(not is_open)   -- stops the Local Player input (moving, shooting...)
    if (is_open) then
        my_menu_ui:SetFocus()            -- Makes the WebUI receive keyboard input (e.g. to type in text fields)
    else
        my_menu_ui:RemoveFocus()
    end
end
```

`SetFocus()` : un seul navigateur peut avoir le focus à la fois ; `RemoveFocus()` : « You MUST call this after you don't need keyboard input anymore ». `webui:HasNodeFocus()`. « Remember to always restore the mouse and the input when the menu closes, otherwise the player will be stuck! »

### 6.6 Débogage et limites

* `webui:OpenDevTools()` ouvre les outils de développement Chromium (« only works if the Client.SetDebugEnabled() was not disabled ») ; `CloseDevTools()`. Débogage distant : **`http://localhost:9222`** quand on est connecté à un serveur. Les `console.log` de la page apparaissent dans la console du jeu avec le type de log `WebUI` (`LogType.WebUI = 9`).
* Codecs propriétaires (**MPEG-4 .mp4, H.264, H.265, AAC**) non pris en charge : convertir en **WEBM** ou **OGG**.
* Ancienne barre de défilement : un extrait CSS `::-webkit-scrollbar` est fourni dans `webui.mdx`.
* Tester une page **hors du jeu** : le tutoriel React teste dans un navigateur normal (`npm run dev`, adresse `http://localhost:5173`) avec une enveloppe qui ne fait rien si `window.Events` n'existe pas (`if (typeof (window.Events) == "undefined") return;`) ; en jeu, on peut pointer la WebUI sur ce serveur de développement (`WebUI("Main HUD", "http://localhost:5173")`) « to get hot reload in-game ». Pour un build : mettre `base: './'` dans `vite.config.js` car la WebUI charge en `file://` ; copier le dossier `dist` dans `Client/UI/`.
* Mettre la WebUI dans `Client/UI/` : le dossier est envoyé aux joueurs (ne jamais y mettre de secret).
* Une WebUI peut aussi servir de **matériau** sur un mesh : `static_mesh:SetMaterialFromWebUI(my_ui)` avec un `WebUI` créé `WidgetVisibility.Hidden, false, false, 500, 500` (exemple de `webui.mdx`).
* Écran de chargement personnalisé : package de type `loading-screen` avec un `index.html` à la racine, événement JavaScript `UpdateScreen(message, message_secondary, progress_small, progress_small_total, progress, progress_total, current_stage)`, variable globale `LoadingScreen` (`server.ip/port/name/description`, `player.nanos_id/nanos_username/steam_id`) ; fonctionne **seulement sur serveur dédié** (`dedicated_server = true`) `[D core-concepts/packages/loading-screen.mdx]`.

---

## 7. Ce qu'on peut simuler : sous-ensemble minimal pour un simulateur pédagogique en Lua pur

Objectif : permettre d'exécuter, **sans le jeu**, des fichiers `Server/Index.lua` et `Client/Index.lua` écrits avec les mêmes noms d'API que dans le vrai serveur. La colonne « comportement à reproduire » ne contient que du **documenté** ; la colonne « à décider » liste ce que la doc laisse libre (le cours devra le choisir et le dire).

Principe d'architecture suggéré par la doc : deux « mondes » (serveur et client) qui exécutent chacun `Shared/Index.lua` puis leur `Index.lua`, avec des `Events.*` locaux séparés et un faux réseau entre `CallRemote`/`BroadcastRemote` et `SubscribeRemote`. Une classe absente d'un côté doit provoquer l'erreur Lua que montre la doc : `attempt to call a nil value (global 'Sound')` quand `Sound` est utilisé côté serveur.

| Brique | Noms exacts à fournir | Comportement documenté à reproduire | À décider (NON DOCUMENTÉ) |
|---|---|---|---|
| Package | `Package.Subscribe("Load"/"Unload", fn)`, `Package.Require(path, force_load)`, `Package.Export(name, value)`, `Package.GetName()`, `GetTitle()`, `GetVersion()` | `Load` après exécution des `Index.lua` ; `Require` met le résultat en **cache** et n'exécute un fichier qu'une fois (`force_load` force) ; 5 chemins de recherche ; `Export` rend la variable visible aux autres packages | isolation stricte des environnements entre packages (la doc la décrit, un simulateur peut la simplifier) |
| Console | `Console.Log/Warn/Error/Debug(msg, ...)`, `Console.RegisterCommand(cmd, cb, description, params)`, `Console.RunCommand(cmd)` | formatage `string.format` ; `Warn`/`Error` avec pile ; `Debug` caché par défaut ; `RunCommand` n'exécute que les commandes **enregistrées par script** | type des arguments reçus par le callback d'une commande |
| Événements locaux | `Events.Subscribe`, `Events.Call`, `Events.Unsubscribe` | `Call` déclenche tous les écouteurs de **tous les packages** du même côté ; retourne `false` si un écouteur a retourné `false` ; `Subscribe` retourne le callback ; `Unsubscribe` sans callback retire ceux du package courant | ordre d'appel des écouteurs |
| Événements distants | `Events.SubscribeRemote`, `Events.CallRemote(name, [player,] reliability, ...)`, `Events.CallRemotePlayers`, `Events.BroadcastRemote`, `Reliability.Reliable/Unreliable` | côté serveur, le callback reçoit d'abord le `Player` émetteur ; `Events.Subscribe` ne reçoit pas le distant et inversement ; les entités passées arrivent comme la même entité | perte/réordonnancement pour `Unreliable` (peut être ignoré) |
| Minuteries | `Timer.SetTimeout`, `SetInterval`, `ClearTimeout`, `ClearInterval`, `Bind`, `IsValid`, `Pause`, `Resume` | millisecondes ; `parameters...` passés au callback ; `SetInterval` s'arrête si le callback retourne `false` ; retourne un identifiant entier ; `Bind` efface le timer à la destruction de l'acteur ; granularité minimale = un tick (33 ms à 30 Hz) | horloge simulée (avancer de N ms) ; survie au rechargement |
| Serveur | `Server.GetTime()`, `Server.GetCustomSettings()`, `Server.Subscribe("Start"/"Tick"/"Stop"/"PlayerConnect"/"PlayerDisconnect")`, `Server.KickByAccountID` | `GetTime` en **millisecondes** (temps Unix) ; `Tick(delta_time)` en secondes ; `PlayerConnect` avant l'existence du `Player` | |
| Chat | `Chat.BroadcastMessage`, `Chat.SendMessage(player, msg)`, `Chat.Subscribe("PlayerSubmit", fn(message, player))` | `PlayerSubmit` retourne `false` : message **non** diffusé ; balises `<red>...</>` (pas de combinaison) | affichage (texte brut suffit) |
| Joueurs | `Player.GetAll/GetPairs/GetCount`, `player:GetName()`, `GetAccountID()`, `GetSteamID()`, `GetPing()`, `Kick(reason)`, `Ban(reason)`, `Possess(pawn)`, `UnPossess()`, `GetControlledCharacter()`, `IsValid()`, événements `Spawn`, `Ready`, `Possess`, `UnPossess`, `Destroy` | ordre de connexion : `PlayerConnect`, `Spawn`, (client `SpawnLocalPlayer`), `Ready`, `Possess`, `Destroy`, `PlayerDisconnect` ; `GetControlledCharacter` vaut `nil` sans pawn | formats des ID de compte ; commandes d'un joueur « fictif » (le simulateur crée les joueurs à la demande) |
| Entités | `Entity.GetAll/GetPairs/GetCount/GetByIndex`, `entity:GetID()`, `IsValid()`, `IsA(Class)`, `Destroy()`, `Subscribe` (classe et instance), événements `Spawn`/`Destroy`/`ValueChange` | `GetAll` retourne une **copie**, `GetPairs` itère directement ; abonnements d'instance supprimés à la destruction ; `IsA` récursif | |
| Valeurs | `entity:SetValue(key, value, sync)`, `GetValue(key, fallback)`, `GetAllValuesKeys()`, `Server.SetValue/GetValue` | **sérialisation** : fonctions refusées, tables **copiées** ; `fallback` si absente ; événement `ValueChange(self, key, value)` ; `sync` seulement utile côté serveur | |
| Personnages | `Character(location, rotation, mesh, collision_type, gravity_enabled, max_health, ...)`, `GetHealth/SetHealth/GetMaxHealth/IsDead`, `ApplyDamage(damage, bone, type, direction, instigator, causer)`, `Respawn(location, rotation)`, `GetPlayer()`, `GetLocation/SetLocation`, `PickUp/Drop/GetPicked`, événements `Death`, `TakeDamage`, `HealthChange`, `Respawn`, `Possess`, `UnPossess` | santé par défaut `max_health = 100` ; `Death` quand la santé tombe à 0 (le personnage **n'est pas détruit**) ; `SetHealth` interdit sur un mort ; `TakeDamage` : un retour numérique multiplie les dégâts, `0` annule ; `Respawn` remplit la santé et déplace ; `DamageType` valeurs 0 à 7 | arithmétique exacte des dégâts par os (ignorable) |
| Zones | `Trigger(location, rotation, extent, trigger_type, is_visible, color, overlap_only_classes)`, événements `BeginOverlap(self, entity)`, `EndOverlap(self, entity)`, `SetOverlapOnlyClasses` | `extent` = rayon pour une sphère ; filtrage par classes ; les deux événements sont déclenchés côté qui a créé le Trigger | le simulateur doit **déplacer** les entités à la main (`sim.move(character, Vector(...))`) et calculer l'intersection |
| Véhicules (partiel) | `VehicleWheeled(...)`, `SetDoor`, `character:EnterVehicle(vehicle, seat)`, `LeaveVehicle()`, `GetPassenger(seat)`, événements `Character "AttemptEnterVehicle"`, `Vehicle "CharacterEnter/CharacterLeave/CharacterAttemptEnter"` | siège 0 = conducteur ; `Attempt*` retourne `false` pour empêcher | physique, roues, moteur : **non simulables** (ignorer ou stubs) |
| Maths | `Vector(X, Y, Z)`, `Rotator(pitch, yaw, roll)`, `Color(R, G, B, A)` | `Vector(100)` = `(100,100,100)` ; opérateurs `+ - * /` avec nombre ou vecteur ; `Distance`, `Size`, `Dot`, `Cross`, `Normalize` ; `Rotator:GetForwardVector()` ; `Color` 0-1 | format de `tostring` (la doc dit seulement « string representation ») |
| Données | `Package.SetPersistentData/GetPersistentData/FlushPersistentData`, `JSON.stringify/parse`, `NanosTable.Dump`, `TOML.Dump/Parse` | clé avec `.` = chemin ; `nil` supprime ; `Dump` retourne une **chaîne** ; `JSON.stringify` annule fonctions et classes d'entités | format fichier (TOML dans la vraie vie) |
| Base de données (réduite) | `Database(DatabaseEngine.SQLite, "db=x.db")` (ou `":memory:"`), `db:Execute(q, ...)`, `db:Select(q, ...)`, `ExecuteAsync`, `SelectAsync`, `Close` | `Execute` retourne `(lignes affectées, erreur)` ; `Select` retourne `(lignes, erreur)` ; placeholders `:0`, `:1` ; callbacks asynchrones `(rows_affected, error)` / `(rows, error)` | **sous-ensemble SQL** (le cours doit en choisir un : `CREATE TABLE IF NOT EXISTS`, `INSERT`, `SELECT ... WHERE`, `UPDATE`, `DELETE`) ; forme des lignes (clés = noms de colonnes ?) |
| Fichiers | `File(path, truncate)`, `:Read(length)`, `:Write(data)`, `:ReadJSON()`, `:Close()`, `File.Exists(path)` | extensions autorisées uniquement (`.txt .dat .json .toml .xml .csv .log ...`) ; chemins relatifs au dossier du serveur ; `Config.toml` interdit | création du fichier absent |
| Client / entrée | `Client.GetLocalPlayer()`, `Client.Subscribe("SpawnLocalPlayer")`, `Input.Register(name, key, description)`, `Input.Bind(name, InputEvent.Pressed/Released, fn)` | `Register` crée le binding avec touche par défaut ; `Bind` branche une fonction | le simulateur déclenche `sim.press("OpenShop")` à la place du clavier |
| WebUI (stub) | `WebUI(name, path, visibility)`, `webui:CallEvent(name, ...)`, `webui:Subscribe(name, fn)`, événement `Ready` | `CallEvent` envoie vers le JavaScript ; `Subscribe` reçoit les `Events.Call` de la page ; `Ready` quand la page est chargée | le **JavaScript ne tourne pas** dans le simulateur : stub qui journalise les `CallEvent` et permet de déclencher à la main les `Subscribe` |

**Non simulable** (à dire clairement aux apprenants) : physique, collisions réelles, IA et navigation (`MoveTo`, `NavMesh`), traces (`Trace.*`), rendu (sons, particules, lumières), VOIP, réseau réel et perte de paquets, authority réseau (`NetAuth`), vrai chargement d'assets (`nanos-world::SK_Male` : le simulateur peut accepter n'importe quelle chaîne), WebUI réelle. Aucune de ces briques n'est nécessaire pour apprendre la logique de jeu (événements, états, validation, sauvegarde).

---

## 8. Lexique anglais / français (40 termes principaux)

Définitions résumées d'après la doc.

| # | Anglais | Français proposé | Sens |
|---|---|---|---|
| 1 | Package | paquet | dossier de scripts chargé par le serveur (script, game-mode, map, loading-screen, c-module) |
| 2 | Script (package) | script | type de package le plus courant, plusieurs possibles |
| 3 | Game-mode | mode de jeu | package « principal », un seul à la fois |
| 4 | Map / Level | carte / niveau | monde chargé ; package de type `map` |
| 5 | Loading screen | écran de chargement | page HTML affichée pendant la connexion |
| 6 | Asset Pack | pack de ressources | ensemble d'assets Unreal exportés, avec `Assets.toml` |
| 7 | Entity | entité | tout objet créé par un constructeur de classe |
| 8 | Actor | acteur | entité qui existe dans le monde (position, rotation, échelle) |
| 9 | Pawn | pion | corps contrôlable (`Character`, `CharacterSimple`) |
| 10 | Character | personnage | corps humain par défaut de nanos world |
| 11 | Player | joueur | la personne connectée ; entité distincte de son personnage |
| 12 | Prop | objet physique | maillage dynamique, saisissable, avec physique |
| 13 | Pickable | objet ramassable | `Weapon`, `Melee`, `Grenade` |
| 14 | Trigger | déclencheur / zone | volume qui signale l'entrée et la sortie d'acteurs |
| 15 | Vehicle | véhicule | `VehicleWheeled` ; sièges numérotés, 0 = conducteur |
| 16 | Event | événement | message déclenché par le jeu ou par un script |
| 17 | Callback | fonction de rappel | fonction passée à `Subscribe`, `SetTimeout`... |
| 18 | Subscribe / Unsubscribe | s'abonner / se désabonner | écouter / arrêter d'écouter un événement |
| 19 | Remote Event | événement distant | événement qui traverse le réseau (client vers serveur ou l'inverse) |
| 20 | Reliable / Unreliable | fiable / non fiable | garanti et ordonné / peut être perdu |
| 21 | Authority | autorité | côté (serveur ou client) qui a créé l'entité |
| 22 | Network Authority | autorité réseau | joueur dont l'ordinateur calcule la physique d'une entité |
| 23 | Dimension | dimension | monde séparé côté client (1 par défaut, 65 535 max) |
| 24 | Spawn | apparaître / créer | création d'une entité |
| 25 | Destroy | détruire | suppression d'une entité |
| 26 | Possess | posséder | un joueur prend le contrôle d'un pawn |
| 27 | Respawn | réapparaître | remettre un mort en vie et le déplacer |
| 28 | Tick | tic | un tour de la boucle (33 ms à 30 Hz côté serveur) |
| 29 | Timer (Timeout / Interval) | minuterie (délai / intervalle) | exécuter du code plus tard, une fois ou en boucle |
| 30 | Entity Value | valeur d'entité | donnée attachée à une entité, optionnellement synchronisée |
| 31 | Persistent Data | données persistantes | fichier TOML du package dans `Packages/.data/` |
| 32 | Database | base de données | accès SQL (SQLite, MySQL, PostgreSQL) côté serveur |
| 33 | Placeholder | paramètre de requête | `:0`, `:1` dans une requête SQL |
| 34 | WebUI | interface web | page HTML/CSS/JS affichée par le client (Chromium) |
| 35 | HUD | affichage tête haute | informations affichées à l'écran (vie, argent) |
| 36 | Key Binding | liaison de touche | action nommée à laquelle le joueur peut réaffecter une touche |
| 37 | Trace / Raycast | tracé de rayon | test de collision le long d'un segment (client seulement) |
| 38 | Vector / Rotator | vecteur / rotation | position (X, Y, Z en cm) / orientation (pitch, yaw, roll en degrés) |
| 39 | Static Class | classe statique | bibliothèque appelée avec un point (`Timer.SetTimeout`), non instanciable |
| 40 | Requirement | dépendance | `packages_requirements` / `assets_requirements`, chargées **avant** |

Autres termes utiles : Vault (dépôt en ligne de packages et assets), CLI (interface en ligne de commande du serveur), Sandbox (game-mode officiel « bac à sable »), Compatibility version (version de compatibilité), Whitelist (liste blanche), Rate limit (limitation de cadence).

---

## 9. Pièges et nouveautés

### 9.1 Changements d'API par « version de compatibilité » `[D core-concepts/packages/compatibility-versions.mdx]`

Principe : le champ `compatibility_version` de `Package.toml` force un mode de compatibilité qui garde l'ancien comportement après un changement cassant. « From time to time all the deprecated compatibility modes will be removed » : garder ses packages à jour. Pour utiliser une nouveauté, il faut un `compatibility_version` **supérieur ou égal** à la version indiquée.

**Piège majeur pour le cours.** Le modèle `[S _script.toml]` (et `_game_mode.toml`, `_map.toml`) contient `compatibility_version = "1.25"`. Avec cette valeur, d'après la règle ci-dessus, **tous les exemples modernes de la doc cesseraient de marcher** : `Events.BroadcastRemote("MyEvent", Reliability.Reliable, "hello")` passerait `Reliability.Reliable` comme premier argument de l'événement (changement 1.139), `Database:Select`/`Execute` seraient **asynchrones avec callback** (avant 1.29), `Package.GetName()` renverrait le **titre** (avant 1.49), `TextRender` désignerait l'ancienne classe `Text3D` (avant 1.103), `Assets.GetX()` renverrait des chaînes (avant 1.55). On ignore ce que le CLI (`add package`) écrit comme valeur (la page Quick Start dit seulement « keep the other settings generated by the CLI ») : **NON DOCUMENTÉ**. À vérifier dès l'accès au jeu, et à fixer explicitement dans les `Package.toml` du cours, avec la version actuelle du jeu (valeur exacte NON DOCUMENTÉE ; les mises à jour citées vont jusqu'à `1.144`).

| Version | Changement | Effet si `compatibility_version` est plus bas |
|---|---|---|
| **1.144** | `AddSkeletalMeshAttached` (Pawn, Vehicle, Pickable) : 4 nouveaux paramètres (`socket`, `relative_location`, `relative_rotation`, `animation_path`) et ordre changé. Les JSON marquent aussi `Pawn:SetCapsuleSize` et `CharacterSimple:SetMesh` avec `last_compatibility_version = 1.144` (détail du changement NON DOCUMENTÉ) | ancien ordre des paramètres |
| **1.139** | **Paramètre `reliability` inséré avant les arguments** pour `Events.CallRemote`, `CallRemotePlayers`, `BroadcastRemote`, `BroadcastRemoteDimension`, et `CallRemoteEvent`/`BroadcastRemoteEvent` d'`Entity`. Nouveautés : `Events.BroadcastRemoteInRadius`, `BroadcastRemoteInRadiusDimension`, `Entity:CallRemotePlayersEvent`, `BroadcastRemoteInRadiusEvent`. `BroadcastRemoteDimension` : `dimension` passe juste après `event_name` | sans `reliability` : `Events.BroadcastRemote("MyEvent", "hello", 123)` marche ; avec : `Events.BroadcastRemote("MyEvent", Reliability.Reliable, "hello", 123)`. **Ne jamais mélanger** : l'ancien code passerait `"hello"` comme fiabilité |
| 1.103 | `TextRender` renommé `Text3D` ; une **nouvelle** classe `TextRender` créée | `TextRender` désigne l'ancien (`Text3D`) |
| 1.65 | `Events.Unsubscribe` ne désabonne plus que les événements **locaux** ; `Events.UnsubscribeRemote` pour les distants | `Unsubscribe` retire les deux |
| 1.55 | `Assets.GetX()` retourne des **tables** avec au moins `key` (avant : chaînes) | |
| 1.54 | `Level.CallLevelBlueprintEvent()` : arguments variadiques et valeur de retour ; `Client.GetPackages()` : filtre et plus d'informations | |
| 1.49 | `Package.GetName()` retourne le **nom du dossier** (avant : le titre) ; **`Package.GetPath()` dépréciée** ; `Server.GetMap()` retourne le nom du package de map (nouveau `Server.GetMapAsset()` pour l'asset) ; `Server.GetPackages(only_loaded, package_type_filter)` retourne des tables `{ title, name, type, version, author }` | |
| 1.33 | `Input.GetScriptingKeyBindings()` / `GetGameKeyBindings()` : `{ Jump = { "SpaceBar", "O" }, ... }` (listes de touches) | |
| 1.29 | `Database:Select` et `Execute` deviennent **synchrones** ; `SelectAsync` / `ExecuteAsync` pour l'asynchrone | |
| 1.22 | `Events.Subscribe` ne reçoit plus que les événements **locaux** ; `Events.SubscribeRemote` pour les distants | |

### 9.2 Dépréciations et fonctionnalités instables signalées

| Élément | Signalement | Source |
|---|---|---|
| `return false` dans `Server "PlayerConnect"` | « deprecated » : utiliser `Server.KickByAccountID` / `BanByAccountID` | `[A StaticClasses/Server.json]` |
| `Package.GetPath()` | dépréciée (1.49), absente de l'API actuelle | `[D .../compatibility-versions.mdx]` |
| Héritage de classes (`Inherit`) et extension de classes natives | « still **experimental** » ; l'extension « will start using non-documented methods and accessors » | `[D core-concepts/scripting/inheriting-classes.mdx]`, `extending-classes.mdx` |
| `Text3D` | « experimental », plus lourd ; préférer `TextRender` | `[D scripting-reference/classes/text3d.mdx]` |
| `webui:ExecuteJavaScript` | « experimental and should be used cautiously » | `[A Classes/WebUI.json]` |
| C Module | « work in progress and may change at any time », « instabilities and even crashes may occur » | `[D core-concepts/packages/c-module.mdx]` |
| Réglages WebUI `CEFSharedTexture`, `CEFUseHardwareAcceleration` | « experimental » | `[A StaticClasses/Client.json]` |
| Docker, Game Panels, Linux ARM | maintenus par la communauté, parfois « EXPERIMENTAL » | `[D core-concepts/server-manual/*.mdx]` |
| Le jeu lui-même | « Closed Testing » ; la Store est « still under development » | `[D welcome.mdx]`, `[D vault-and-store/store.mdx]` |

### 9.3 Différences client / serveur à enseigner

| Sujet | Serveur | Client |
|---|---|---|
| Classes instanciables | `Character`, `Weapon`, `Melee`, `Grenade`, `VehicleWheeled`, `Database` : **serveur seulement** | `Sound`, `WebUI`, `Canvas`, `Billboard` : **client seulement** |
| Classes des deux côtés | `Prop`, `StaticMesh`, `Trigger`, `Light`, `Particle`, `Text3D`, `TextRender`, `CharacterSimple`, `File` | (idem) ; une entité créée côté client n'existe que pour ce client |
| Classes statiques | `Server.*` (S) | `Client.*`, `Input.*`, `Trace.*`, `Debug.*`, `Viewport.*`, `Level.*` (C) ; `Events`, `Timer`, `Package`, `Console`, `Chat`, `HTTP`, `Assets` (S+C, `Chat.AddMessage` C, `Chat.BroadcastMessage` S) |
| Événement distant | reçoit le `Player` d'abord ; `Events.CallRemote(name, player, reliability, ...)` | `Events.CallRemote(name, reliability, ...)` |
| Connexion | `Player "Spawn"` puis `Player "Ready"` (S seulement) | `Client "SpawnLocalPlayer"` (C seulement) |
| Heure | `Server.GetTime()` (ms Unix) | `Client.GetTime()` (ms Unix) |
| Valeurs | `GetAllValuesKeys()` (S) ; `SetValue(..., true)` synchronise | lit les valeurs synchronisées ; `SetValue` local |
| Physique, traces, IA | non simulées par le serveur ; calculées par un client « Network Authority » | `Trace.*` seulement ici ; le résultat doit être renvoyé et **validé** |
| Fichiers | relatifs à l'exécutable, `Config.toml` interdit | cache `Packages/`, écriture dans `Packages/.transient/` |
| Persistance de package | `Packages/.data/<package>.toml` | `Packages/.data/<package>.toml` (cache client) |
| Setters | souvent **S** (`SetHealth`, `Possess`, `SetCanPunch`...) ou **Auth** (`SetLocation`, `SetLifeSpan`, `Destroy`) | la plupart des getters sont S+C |
| `Weapon "Fire"`, `Character "Fire"` | S+C, appelé d'abord chez le client Network Authority | idem |

### 9.4 Pièges de code

1. **Recharger = rejouer `Load` avec des joueurs déjà connectés** : gérer `Package "Load"` en plus de `Player "Spawn"`.
2. Le `Character` n'est **pas détruit** quand le `Player` part : le détruire dans `Player "Destroy"`. Il n'est pas détruit non plus à sa mort (ragdoll) : `Respawn` plus tard, en vérifiant `character:IsValid()` dans le timer (il a pu être détruit entre-temps).
3. `SetHealth` sur un mort échoue : `Respawn` d'abord.
4. `entity:IsA(Weapon)` prend la **classe**, pas la chaîne (« Expected a class as parameter »).
5. `GetPairs()` : ne pas détruire dans la boucle ; `GetAll()` retourne une copie.
6. Les **timers** ne savent pas qu'une entité a disparu : utiliser `Timer.Bind(timer, actor)` ou `IsValid()`.
7. Une entité stockée dans une valeur n'est **pas** mise à `nil` à sa destruction ; une **table** stockée est **copiée** (re-`SetValue` après modification).
8. Ne pas créer d'entité dans `Shared/` (doublon serveur + clients).
9. `Vector(100)` = `(100,100,100)`, `Rotator(10)` = `(10,10,10)` ; `Color` est en **0 à 1** (utiliser `Color.FromRGBA` pour 0-255).
10. `Events.Subscribe` n'entend pas les événements distants ; `Events.Unsubscribe` ne retire pas les distants (`UnsubscribeRemote`).
11. Ordre d'arguments **inversé** : `Player "Possess"` donne `(self, pawn)`, `Character "Possess"` donne `(self, player)`.
12. `Trigger` : événements chez le créateur seulement ; filtrer avec `actor:IsA(Character)` ou `SetOverlapOnlyClasses` ; compter les entrées/sorties pour les zones partagées.
13. `Database:Select/Execute` et `HTTP.Request` **gèlent le serveur** (`blocking`) : préférer `...Async` ; la connexion initiale d'une `Database` bloque aussi quelques secondes ; une connexion ratée retourne `nil`.
14. `Server "Tick"` : « only small operations » ; `Client "Tick"` : « Do not abuse ». Un tick serveur est de 33 ms (30 Hz) : du code long provoque « Server Tick too/extreme high ».
15. `Timer` : la granularité minimale est un tick ; un timer plus rapide n'a pas de sens.
16. `Config.toml` est **réécrit** à chaque démarrage : commentaires et clés inconnues perdus ; passer les réglages en ligne de commande avec `--save` pour les conserver.
17. Un package qui exporte (`Package.Export`) doit être chargé **avant** celui qui l'utilise : `packages_requirements`. Éviter `Server.LoadPackage()` en exécution pour une dépendance.
18. Nom de package : minuscules, chiffres, `-`, 64 caractères max.
19. `auto_cleanup = true` (défaut) : les entités du package disparaissent à son déchargement.
20. L'IA ne bouge que si un joueur est connecté.
21. Un `Vector` dans un événement distant perd de la précision (2 décimales).
22. `Package "Load"` au **démarrage** du serveur arrive après TOUS les packages : un package ne peut pas supposer l'ordre des `Load` des autres au démarrage (mais `Index.lua` suit l'ordre de chargement).
23. À **vérifier en conditions réelles** (non documenté) : utiliser un texte de joueur comme premier argument de `Console.Log` alors que celui-ci formate avec `string.format` (risque d'erreur si le texte contient `%`) ; survie des `Timer` à `package reload`.

---

## 10. Plan conseillé du parcours E : 10 modules, environ 34 h

Hypothèses : apprenant débutant, qui connaît déjà les bases de Lua (fonctions, tables, fermetures, `string.format`) grâce aux parcours précédents ; **aucun accès au jeu au départ**. Chaque module a donc deux modes :

* **Mode A (simulateur)** : le code est exécuté dans le simulateur en Lua pur du cours (section 7), avec les **mêmes noms d'API** que le vrai serveur.
* **Mode B (jeu réel)** : quand l'accès arrive, les mêmes fichiers `Server/Index.lua` et `Client/Index.lua` sont copiés dans un vrai package. Le serveur se télécharge avec SteamCMD (`login anonymous`, app `1936830`) et ses exigences sont minimes (1.1) ; un **client** du jeu est nécessaire dès qu'il faut un joueur connecté (événements `Player`, personnages, physique, IA, WebUI).

Les renvois « § » pointent vers les sections de cette fiche. Le fil rouge est un mini jeu de rôle (ville, argent, métiers, magasin, véhicules, administration). Les exemples d'assets sont des clés vérifiées de la doc (section 11.5).

| # | Module | Durée |
|---|---|---|
| E1 | Premier package et console du serveur | 2 h 30 |
| E2 | Événements, callbacks et minuteries | 3 h |
| E3 | Joueurs et personnages | 3 h 30 |
| E4 | Argent et inventaire | 3 h 30 |
| E5 | Métiers, salaires et commandes de chat | 3 h 30 |
| E6 | Zones et déclencheurs | 3 h |
| E7 | Véhicules, permissions et administration | 4 h |
| E8 | Sécurité : ne jamais faire confiance au client | 3 h |
| E9 | Sauvegarde des données | 4 h |
| E10 | Interface HUD (WebUI), architecture et performances | 4 h |
| | **Total** | **34 h** |

### E1. Premier package et console du serveur (2 h 30)

* **Objectifs** : comprendre `Server/`, `Client/`, `Shared/` et `Index.lua` ; lire/écrire un `Package.toml` ; ordre de chargement ; `Console.Log` ; recharger ; lire une erreur Lua.
* **API** : § 1.2 à 1.9 ; `Console.Log/Warn/Error/Debug`, `Console.RegisterCommand` (§ 3.7) ; `Package.Subscribe("Load")` (§ 1.7).
* **Mini-projet « Bienvenue en ville »** : un package `ville-rp` qui affiche son titre et sa version (`Package.GetTitle()`, `Package.GetVersion()`) au `Load` et enregistre une commande console `status` qui affiche le nombre de joueurs (`Player.GetCount()`).
* **À ne pas promettre** : une vraie map ou des véhicules ; la valeur de `compatibility_version` à utiliser (§ 9.1, piège majeur : NON DOCUMENTÉ, à vérifier avec le jeu).
* **Mode B** : `./NanosWorldServer.exe --cli add package ville-rp`, ajout dans `Config.toml` ou `--packages ville-rp`, `package reload ville-rp`.

### E2. Événements, callbacks et minuteries (3 h)

* **Objectifs** : s'abonner et se désabonner ; événements locaux personnalisés ; arguments et valeurs de retour ; `Timer.SetTimeout/SetInterval` ; arrêter un timer ; événements annulables (retour `false`).
* **API** : § 2.1, 2.2, 3.1 (`Events.Call/Subscribe/Unsubscribe`), 3.2 (`Timer.*`).
* **Mini-projet « Cloche de la mairie »** : un `SetInterval` annonce l'heure du serveur (`Server.GetTime()`) toutes les N secondes via un événement local `Events.Call("ClocheDeLaMairie", ...)` reçu par un autre fichier ; le timer s'arrête de lui-même (callback qui retourne `false`) après 5 annonces.
* **À ne pas promettre** : la précision des timers (granularité = 1 tick, 33 ms) ; la survie des timers à `package reload` (NON DOCUMENTÉ).
* **Mode A suffit** (aucun besoin du jeu).

### E3. Joueurs et personnages (3 h 30)

* **Objectifs** : différencier `Player` et `Character` ; cycle de vie (`Spawn`, `Ready`, `Possess`, `Destroy`) ; créer, posséder, détruire et réanimer un personnage ; santé et dégâts.
* **API** : § 2.4 (Player, Damageable, Pawn, Character), § 3.4, 3.5, § 1.6 (cycle de vie), `Server.GetMapSpawnPoints()` (§ 3.7).
* **Mini-projet « Arrivée à l'aéroport »** : à `Player "Spawn"`, créer un `Character` (`"nanos-world::SK_Male"` ou `"nanos-world::SK_Female"`) à un point d'apparition de la map et le faire posséder ; message d'accueil sur `Player "Ready"` ; à la mort, réapparition à l'« hôpital » après 5 s avec `Respawn(location, rotation)` ; détruire le personnage à `Player "Destroy"`.
* **À ne pas promettre** : un « téléport » (aucune fonction dédiée : `SetLocation` ou `Respawn`, § 3.5) ; la gestion d'un point d'apparition **par métier** (rien de natif).
* **Mode A** : joueurs fictifs créés par le simulateur. **Mode B** : indispensable pour voir réellement un personnage ; exemple « Your First Game-Mode » (§ 1.6) à reproduire.

### E4. Argent et inventaire (3 h 30)

* **Objectifs** : stocker l'état d'un joueur avec `SetValue/GetValue` ; comprendre la sérialisation (copie des tables) ; fonctions `AddMoney`/`RemoveMoney`/`GiveItem` ; réagir à `ValueChange`.
* **API** : § 4.5, § 3.3 (valeurs), § 5.2 (le serveur décide), § 2.4 (`ValueChange`), extension de classe `Player` (§ 3.17, *expérimental*, à présenter comme option).
* **Mini-projet « Portefeuille et sac à dos »** : `money` (nombre) et `inventory` (table `{ [item_id] = quantité }`) sur le joueur ; définitions d'objets (nom, prix) dans un fichier `Shared/` lu par le serveur ; l'inventaire se modifie par **copie puis `SetValue`** (la table stockée est copiée) ; refus des montants négatifs.
* **À ne pas promettre** : un inventaire ou une économie natifs (aucun) ; la persistance (module E9).
* **Mode A suffit**.

### E5. Métiers, salaires et commandes de chat (3 h 30)

* **Objectifs** : un métier est une valeur de joueur ; salaire périodique avec `SetInterval` ; recevoir et analyser un message de chat ; commandes console ; messages colorés.
* **API** : `Timer.SetInterval/Bind/IsValid` (§ 3.2), `Chat.Subscribe("PlayerSubmit")`, `Chat.SendMessage`, balises `<cyan>...</>` (§ 3.6), `Console.RegisterCommand` (§ 3.7), méthodes `string` (`StartsWith`, `Trim`, `match`, `gmatch`, § 3.12).
* **Mini-projet « Pôle emploi »** : `/metier taxi` (message analysé dans `PlayerSubmit`, retour `false` pour ne pas l'afficher), table `JOBS = { taxi = { salaire = 50 }, ... }`, salaire toutes les 60 s pour chaque joueur présent, message `Chat.SendMessage(player, "<green>Salaire reçu</>")`.
* **À ne pas promettre** : une API native de **commandes de chat** (NON DOCUMENTÉ ; on écrit le parseur) ; un nettoyage automatique de la table du timer quand le joueur part (à gérer avec `Player "Destroy"`).
* **Mode A suffit** ; le rendu des balises de couleur ne se voit qu'en jeu réel.

### E6. Zones et déclencheurs (3 h)

* **Objectifs** : `Trigger` sphère/boîte ; `BeginOverlap`/`EndOverlap` ; filtrer par classe ; compter les occupants ; distances avec `Vector`.
* **API** : § 3.8 (`Trigger`), § 2.4 (événements du `Trigger`), § 3.11 (`Vector:Distance`, `Vector(100)`), `Server.GetPlayersInRadius` (§ 3.7).
* **Mini-projet « Magasin »** : un `Trigger(Vector(...), Rotator(), 300)` à l'entrée du magasin ; à l'entrée d'un `Character`, message « Bienvenue » ; l'achat n'est accepté que si le personnage est dans la zone (compteur d'occupants, règle copiée de l'exemple « Doors » : fermer seulement quand le compteur retombe à 0).
* **À ne pas promettre** : la porte animée (`RotateTo`, `AttachTo`) sans le jeu réel ; l'exactitude de la détection des chevauchements dans le simulateur (le simulateur déplace les personnages à la main).
* **Mode B** : exemple « Doors » et « Prop Rain » de la doc (§ 2.4). Créer le `Trigger` **côté serveur** (événements chez le créateur).

### E7. Véhicules, permissions et administration (4 h)

* **Objectifs** : créer et configurer un `VehicleWheeled` (d'après l'exemple officiel) ; entrer/sortir ; bloquer l'entrée avec un événement `Attempt*` ; administrateurs et listes blanches ; expulsion et bannissement.
* **API** : § 3.10 (véhicules), § 2.4 (`AttemptEnterVehicle`, `CharacterAttemptEnter`, `CharacterEnter`), `character:EnterVehicle(vehicle, seat)` (§ 3.5), `player:GetAccountID()`, `player:Kick/Ban`, `Server.KickByAccountID/BanByAccountID/Unban`, `banned_ids` (§ 1.4), liste blanche dans `Server "PlayerConnect"` (§ 5.4).
* **Mini-projet « Garage de la police »** : un véhicule réservé aux joueurs dont `job == "police"` (`Character.Subscribe("AttemptEnterVehicle", ...)` qui retourne `false` sinon) ; table `ADMINS = { ["id-de-compte"] = true }` ; commande console `expulser <nom> <raison>` (la console intégrée a déjà une commande `kick <player_id> <reason>`, voir 1.5.2 ; le type exact des arguments d'une commande de script est NON DOCUMENTÉ : retrouver le joueur dans `Player.GetAll()` par `GetName()`) ; liste blanche dans `PlayerConnect`.
* **À ne pas promettre** : un système de **permissions/rôles natif** (aucun) ; les classes de `default-vehicles` (NON DOCUMENTÉ ici) ; la physique, les roues et le moteur dans le simulateur ; une fonction « retrouver un joueur par son nom » (NON DOCUMENTÉ ; seul `GetBySteamID` existe).
* **Mode B** : vérifier visuellement le véhicule de l'exemple « Monster Truck » (maillage `SK_Pickup`).

### E8. Sécurité : ne jamais faire confiance au client (3 h)

* **Objectifs** : tout ce que le client envoie est un mensonge possible ; valider type, plage, propriété, distance, état, cadence ; garder les secrets côté serveur.
* **API** : § 5 en entier ; `Events.SubscribeRemote/CallRemote/BroadcastRemote` (§ 3.1), `type()`, `IsValid()`, `IsA()`, `Server.GetTime()`, `Player "Destroy"` pour le nettoyage.
* **Mini-projet « Boutique blindée »** : une première version **volontairement vulnérable** (celle de § 5.1), un script « tricheur » du simulateur qui envoie un prix négatif, un item inexistant et 1000 requêtes par seconde ; puis la version corrigée de § 5.2 + § 5.3 (prix côté serveur, type, plage, solde, cadence).
* **À ne pas promettre** : une détection fiable de triche (la doc recommande seulement de kick/ban « with care » à cause du lag) ; les effets de la Network Authority sur la physique dans le simulateur.
* **Mode A suffit** (c'est même le mode idéal : le faux réseau du simulateur rejoue des attaques).

### E9. Sauvegarde des données (4 h)

* **Objectifs** : choisir le bon mécanisme ; sauvegarder à la déconnexion et au déchargement ; clé de joueur stable ; SQLite avec paramètres ; JSON.
* **API** : § 4.1 (`Package.SetPersistentData/GetPersistentData/FlushPersistentData`), § 4.2 (`Database`, `DatabaseEngine.SQLite`, `Execute`, `Select`, `ExecuteAsync`, `SelectAsync`), § 4.3 (`File`), § 4.4 (`JSON`, `TOML`), `Package.Subscribe("Unload")`, `Player "Destroy"`, `Server "PlayerDisconnect"`, `player:GetAccountID()`.
* **Mini-projet « Banque »** : version 1 avec `SetPersistentData("comptes." .. account_id, { argent = ..., metier = ... })`, relue à la connexion (`Player "Spawn"`) ; version 2 avec `Database(DatabaseEngine.SQLite, "db=banque.db")`, `CREATE TABLE IF NOT EXISTS`, `INSERT`/`SELECT ... WHERE id = :0` ; comparaison des deux (quantité, fréquence d'écriture, blocage du serveur).
* **À ne pas promettre** : le dossier du fichier SQLite et le format exact des lignes retournées (NON DOCUMENTÉ : les vérifier avec le jeu avant d'écrire un cours détaillé) ; une sauvegarde automatique ; des transactions.
* **Mode A** : le simulateur implémente un sous-ensemble minimal de SQL (à définir dans le cours, § 7). **Mode B** : à valider impérativement (SQLite réel).

### E10. Interface HUD (WebUI), architecture et performances (4 h)

* **Objectifs** : un HUD HTML/JS (argent, métier) alimenté par des événements ; ouvrir/fermer un menu en gérant souris et focus ; découper le code en fichiers ; points de performance documentés.
* **API** : § 6 (`WebUI`, `CallEvent`, `Subscribe`, JavaScript `Events.Subscribe/Call`), `Input.Register/Bind/SetMouseEnabled/SetInputEnabled` (§ 3.14), `Package.Require`, `Package.Export`, événements locaux entre packages (§ 1.7), `Reliability` (§ 3.1), outils de mesure (`--profiling`, `profiling = true`, Tracy, `NanosUtils.Benchmark`, § 3.13), `Classe.GetPairs()` (§ 3.3).
* **Mini-projet « HUD du citoyen »** : page `Client/UI/index.html` (argent et métier) testée **dans un navigateur normal** avec une enveloppe qui ignore `Events` s'il n'existe pas (technique du tutoriel React) ; côté Lua `WebUI("HUD", "file://UI/index.html", WidgetVisibility.VisibleNotHitTestable)` et `Player "ValueChange"` qui appelle `CallEvent("UpdateMoney", value)` ; puis refonte du jeu en fichiers (`Shared/Config.lua`, `Server/Economie.lua`, `Server/Metiers.lua`, `Server/Index.lua` avec `Package.Require`) ; liste de contrôle performance : pas de travail lourd dans `Server "Tick"`, `GetPairs` plutôt que `GetAll` pour parcourir, événements distants ciblés (`CallRemote`, `BroadcastRemoteInRadius`) et `Unreliable` pour les messages fréquents, lumières « very expensive ».
* **À ne pas promettre** : voir la WebUI sans le jeu (client uniquement) ; le passage de **tables** Lua vers JavaScript (NON DOCUMENTÉ explicitement ; envoyer des nombres/chaînes, ou du JSON) ; des chiffres de performance (la doc ne donne que les étiquettes `fast/moderate/slow/blocking` et le budget de tick de 33 ms).
* **Mode A** : stub `WebUI` du simulateur + test du HTML dans un navigateur avec simulation d'`Events`. **Mode B** : indispensable pour valider le rendu (ancres, transparence, focus).

### Briques que la doc ne permet pas (à ne pas inventer dans le cours)

* Fonction de téléportation ; permissions/rôles ; économie, inventaire, métiers ; **commandes de chat natives** ; sauvegarde automatique des joueurs ; recherche de joueur par nom ou par ID de compte ; liste des classes de `default-weapons` et `default-vehicles` (la doc cite seulement les packages et leurs dépôts GitHub) ; envoi de tables vers une WebUI ; lecture de `Config.toml` par script (fichier interdit à `File`) ; chemin du fichier SQLite ; survie des timers au rechargement.

---

## 11. Contradictions, lacunes, pages lues

### 11.1 Contradictions et incohérences repérées

1. **Valeurs par défaut de `max_send_rate` et `max_file_transfer_rate`** : `1024` Ko/s dans `[D core-concepts/server-manual/server-configuration.mdx]` (tableau « Settings Detailed » et paramètres), `512` Ko/s dans le modèle `[S Config.toml]` (branche `main`, non figé). Même page : « `max_file_transfer_rate`... Range 128 - max_send_rate ».
2. **Numéro de version** : la sortie console d'exemple du Quick Start affiche « Version: 1.9.0 » `[D getting-started/quick-start.mdx]`, alors que le guide des versions cite des mises à jour numérotées 1.139 et 1.144 pour le même produit `[D core-concepts/packages/compatibility-versions.mdx]`. La doc ne dit pas quelle est la version actuelle ; vérifier avec le jeu.
3. **Modèle `Package.toml` vs exemples** : `compatibility_version = "1.25"` dans les modèles `[S _script.toml]`, `_game_mode.toml`, `_map.toml`, alors que tous les exemples de la doc utilisent des API postérieures (voir 9.1 : piège majeur).
4. **Types de package proposés par le CLI** : le Quick Start montre l'invite `('script', 'game-mode', 'map' or 'loading-screen')` (4 types) alors que `packages-guide.mdx` en décrit 5 (avec `c-module`). Le CLI sait peut-être créer un `c-module` : NON DOCUMENTÉ.
5. **Moment de l'événement `Package "Load"`** : `package-loading-and-lua-environment.mdx` : « after all the Index.lua files of this Package ran » ; `[A StaticClasses/Package.json]` précise qu'au démarrage et sur `package reload all` il n'arrive qu'après le chargement de **tous** les packages. Les deux se complètent, la version du JSON est la plus précise.
6. **Gravity Gun** : la liste `tutorials-and-examples.mdx` annonce « validating the client input on the server », mais le code de `gravity-gun.mdx` ne valide rien (voir 5.6).
7. **Coquille dans la page `Color`** : le constructeur est documenté `Color(R, G = X, B = X, A = 1)` alors qu'aucun paramètre n'est nommé `X` `[A Structs/Color.json]`. Valeurs par défaut réelles de `G` et `B` : NON DOCUMENTÉ.
8. **Type de retour imprécis** : `Server.GetCustomSettings()` est annoncé `table[]` dans le JSON, mais l'exemple de la doc l'utilise comme une table clé-valeur (`settings.max_props`). `Classe.GetByIndex` est annoncé `Entity` (sans `?`) mais la page Essential Concepts précise qu'il retourne `nil` s'il n'y a rien à cet index.
9. **Étiquette `[?]`** : les JSON des structs et des bibliothèques utilitaires n'ont pas de champ `authority` : la doc ne précise pas le côté.

### 11.2 Ce qui manque dans la documentation (NON DOCUMENTÉ)

* Version actuelle du jeu et valeur écrite par `--cli add package` dans `compatibility_version`.
* Si le serveur démarre et exécute normalement ses scripts sans aucun client (seul est documenté : la physique et l'IA sont calculées par des clients).
* Fonction de téléportation ; recherche d'un joueur par nom ou ID de compte ; commandes de chat natives ; permissions/rôles.
* Persistance des timers à travers `package reload` ; ordre d'appel des écouteurs d'un même événement.
* Dossier du fichier SQLite, structure d'une ligne retournée par `Select`, transactions, dernier identifiant inséré.
* `File(path)` : création du fichier s'il n'existe pas.
* Type exact des arguments reçus par le callback de `Console.RegisterCommand` ; format de `tostring` des structs.
* Passage de tables de Lua vers JavaScript par `CallEvent` ; accès réseau depuis la page d'une WebUI ; `package://` comme chemin du constructeur `WebUI`.
* Classes de `default-weapons` et de `default-vehicles` ; liste complète des fonctions de `table`/`string`/`math`/`os` de Lua 5.4 réellement disponibles (le site liste un sous-ensemble).
* Taille maximale de `SetPersistentData` ; comportement en cas de plantage avant l'écriture différée ; validité d'une clé commençant par un chiffre ou contenant des caractères spéciaux dans `SetPersistentData("comptes." .. id, ...)` (la clé est séparée par `.`) ; signification du paramètre `<player_id>` de la commande console `kick` (ID d'entité ? de compte ?).
* Ce que fait précisément le champ `last_compatibility_version` des JSON (non expliqué dans la doc ; sert ici d'indice).

### 11.3 Pages et fichiers lus

Lus **en entier** (D) : `getting-started/` (quick-start, essential-concepts, your-first-game-mode, editor-setup, tutorials-and-examples/* : tutorials-and-examples, basic-hud-html, basic-hud-canvas, basic-hud-react, doors, name-tags, prop-rain, prop-shooter, play-as-prop, weapon-flashlight, weapon-scope, x-ray-and-highlight, gravity-gun, monster-truck, fireworks, blueprint-communication, painting-meshes) ; `core-concepts/` (assets, server-and-client-lifecycle, `packages/*` : packages-guide, package-loading-and-lua-environment, compatibility-versions, loading-screen, c-module ; `scripting/*` : toutes, y compris artificial-intelligence, discord-integration, profiling, voip ; `server-manual/` : server-configuration, command-line-interface, server-installation, server-docker) ; `scripting-reference/` : glossary/basic-types, glossary/enums, `static-classes/*` et `classes/*` et `structs/*`, `standard-libraries/*`, `utility-libraries/*` (pages squelettes, voir 0.2) ; `explore/game-modes-and-packages`, `explore/sandbox-game-mode/sandbox-game-mode`, `extra-features` ; `vault-and-store/vault`, `store` ; `welcome`, `signing-up-alpha`, `troubleshooting`.

Lus **partiellement** : `server-manual/game-panels`, `server-linux-arm` (titres seulement), `explore/sandbox-game-mode/spawn-menu`, `context-menu`, `tool-guns` (titres seulement), `assets-modding/default-asset-pack/default-weapons` (début), `default-assets-list` (renvoie vers `[S DefaultAssetPack.toml]`, lu pour vérifier les clés d'asset), `roadmap`, `contributing-to-the-docs` (section API Reference). Non lus : `assets-modding/**` hors ci-dessus, `blog/`, `versioned_docs/` (copie de `docs/` : un seul fichier diffère, `assets-modding/whitelisted-ue-plugins.mdx`).

API (A, JSON, commit `dd415c8`) : les 71 fichiers listés dans `APIFiles.json` ont été téléchargés et rendus en texte ; **lus** pour `Events`, `Timer`, `Package`, `Chat`, `Server`, `Client`, `Console`, `Debug`, `Input`, `HTTP`, `Level`, `Trace` (début), `Assets`, `Viewport`, `Entity`, `Actor`, `Damageable`, `Pawn`, `Pickable`, `Vehicle`, `Paintable` (début), `Player`, `Character`, `CharacterSimple`, `Prop`, `Trigger`, `Weapon`, `VehicleWheeled`, `Melee`, `Grenade`, `Light`, `Sound`, `Particle`, `StaticMesh`, `Text3D`, `TextRender`, `Billboard`, `Database`, `File`, `WebUI`, `Canvas` (résumé), `Vector`, `Rotator`, `Color`, `Vector2D`, `JSON`, `TOML`, `NanosTable`, `NanosUtils`, `NanosMath`, `math`, `string`, `table`, `Enums`. **Téléchargés mais non lus** (hors périmètre du parcours E) : `Blueprint`, `Cable`, `Decal`, `Gizmo`, `InstancedStaticMesh`, `SceneCapture`, `VehicleWater`, `Widget`, `Widget3D`, `Discord`, `Navigation`, `PostProcess`, `Sky`, `Steam`, `Matrix`, `Quat` (seules leurs pages `.mdx` ont été lues pour `Quat` et `Matrix`).

### 11.4 Opérations réalisées pour produire cette fiche (transparence)

* Lecture seule du clone `/home/user/nanos-world/docs` ; trois invocations Git de **lecture** exécutées hors du dépôt du cours pour vérifier le commit et le sous-module (`git log -1` dans `/home/user/nanos-world`, qui n'est pas un dépôt, puis `git log -1` et `git submodule status` dans `/home/user/nanos-world/docs`) ; aucune commande Git dans le dépôt du cours.
* Un appel à l'outil `add_repo` pour `nanos-world/api` : la réponse est que la lecture publique est déjà possible, **rien n'a été attaché ni cloné**.
* Téléchargements de lecture seule depuis `raw.githubusercontent.com` (les tentatives sur `codeload.github.com` et `api.github.com` ont été refusées par le proxy) : les 71 JSON de `nanos-world/api` au commit épinglé, et 9 fichiers `.toml` de `nanos-world/nanos-world-server` (branche `main`, dont `Assets.toml`, téléchargé mais non lu) ; stockés dans le dossier temporaire de la session, pas dans le dépôt.
* Aucun autre fichier du dépôt du cours n'a été modifié ; seul ce fichier a été créé.

### 11.5 Clés d'asset réellement présentes dans `[S DefaultAssetPack.toml]` (utilisables dans les exemples)

Personnages : `SK_Male`, `SK_Female`, `SK_Mannequin`, `SK_Mannequin_Female`, `SK_PostApocalyptic`, `SK_ClassicMale`, `SK_StackOBot`, `SK_None` (invisible). Véhicules : `SK_Pickup`, `SK_Sedan`, `SK_Hatchback`, `SK_Van`, `SK_SportsCar`, `SK_CamperVan`, `SK_Offroad`, `SK_Truck_Box`, `SK_Truck_Chassis`. Objets : `SM_Cube`, `SM_Sphere`, `SM_Plane`, `SM_None` (invisible), `SM_WoodenTable`, `SM_WoodenChair`, `SM_Crate_01`, `SM_Crate_07`, `SM_Barrel_01`, `SM_TireLarge`, `SM_Tire_01`, `SM_MoneyStack`, `SM_MoneyRoll`, `SM_House_01` à `SM_House_05`, `SM_Bench`, `SM_Sign`, `SM_Crowbar_01`, `SM_Grenade_G67`. Armes : `SK_AK47`. Animations : `A_Mannequin_Taunt_Bow` (utilisée par « Your First Game-Mode »), `AM_Mannequin_DoorOpen_01` (exemple Doors). Particules : `P_Explosion`, `P_Fire`. Sons de véhicule : `A_Vehicle_Engine_01`, `A_Vehicle_Engine_10`, `A_Vehicle_Horn_Toyota`, `A_Vehicle_Brake`, `A_Vehicle_Door`, `A_Car_Engine_Start`. Maps (clés d'asset ; les packages de map intégrés s'appellent `default-blank-map`, `default-empty-map`, `default-ocean-map`, `default-testing-map`) : `BlankMap`, `EmptyMap`, `OceanMap`, `TestingMap`. Référence d'asset : `"nanos-world::SK_Male"` (`[nom-du-pack]::[clé]`).

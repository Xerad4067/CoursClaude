# Sources vérifiées : Python et SQLite pour Windows (06/10/2026)

Méthode : dépôt officiel des manifestes winget `microsoft/winget-pkgs` (clone partiel), lu le 06/10/2026.

| Paquet | Identifiant winget vérifié | Dernière version vue | Remarques |
|---|---|---|---|
| Python 3.13 | `Python.Python.3.13` | 3.13.15 (publiée le 2026-08-05) | Commandes déclarées par le manifeste : `py`, `python`, `pythonw`, `pyw`. Installeur `burn` de python.org. Option d'installation pour l'utilisateur courant avec ajout au PATH (`PrependPath=1`). |
| Python 3.14 | `Python.Python.3.14` | 3.14.7 | Existe aussi ; le cours recommande 3.13 (version stable largement répandue) mais tout fonctionne en 3.14. |
| SQLite (outils en ligne de commande) | `SQLite.SQLite` | 3.53.4 | Optionnel : le cours utilise surtout le module `sqlite3` livré avec Python. |
| DB Browser for SQLite | `DBBrowserForSQLite.DBBrowserForSQLite` | voir manifeste | Optionnel, interface graphique pour regarder une base. |

Commande testée dans le conteneur Linux : `python3 -m sqlite3 --help` (interface en ligne de commande du module `sqlite3`, présente depuis Python 3.12).
Les commandes `winget install` ci-dessus restent **non testées sur Windows**.

## Compléments (06/10/2026)

| Source | Méthode d'accès | Ce que ça a permis de vérifier |
|---|---|---|
| `python/cpython`, `Doc/using/windows.rst` (branche main) | raw.githubusercontent.com | Recommandation actuelle de l'équipe Python pour Windows : le **Python Install Manager** (Microsoft Store ou python.org) ; commandes `python`, `py`, `pymanager` ; avertissement sur les anciennes installations et le PATH ; dépannage « Manage app execution aliases » ; `py -0` / `py --list` conservés pour compatibilité |
| `microsoft/winget-pkgs`, `manifests/p/Python/PythonInstallManager` | clone partiel | `Python.PythonInstallManager`, version 26.3.240.0, MSIX, commandes `py`, `python`, `python3`, `pymanager`… |
| `microsoft/vscode-docs`, `docs/python/python-tutorial.md` | raw.githubusercontent.com | Extension Python `ms-python.python` (page Marketplace citée par la doc VS Code) ; l'extension n'inclut pas Python ; l'extension Python Debugger `ms-python.debugpy` s'installe avec elle |
| `microsoft/winget-pkgs`, `manifests/d/DBBrowserForSQLite/DBBrowserForSQLite` | clone partiel | `DBBrowserForSQLite.DBBrowserForSQLite`, version 3.13.1, site https://sqlitebrowser.org/ |
| Test dans le conteneur : `python3 -m sqlite3`, commandes `.help`, `.quit` | exécution réelle (Python 3.13.16 sous Linux) | L'interface en ligne de commande existe et `.quit` quitte |

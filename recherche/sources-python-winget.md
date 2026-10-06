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

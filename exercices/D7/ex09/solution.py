import sqlite3

# 1) Se connecter : ":memory:" crée une base temporaire, qui disparaît à la fin du programme.
connexion = sqlite3.connect(":memory:")
curseur = connexion.cursor()

# 2) Créer la table.
curseur.execute("""
    CREATE TABLE joueurs (
        id INTEGER PRIMARY KEY,
        pseudo TEXT NOT NULL,
        argent INTEGER NOT NULL DEFAULT 0
    )
""")

# 3) Ajouter trois joueurs. Les ? réservent la place des valeurs, données dans un tuple.
for pseudo, argent in [("Sam", 1500), ("Kim", 8200), ("Alex", 3100)]:
    curseur.execute("INSERT INTO joueurs (pseudo, argent) VALUES (?, ?)", (pseudo, argent))
connexion.commit()   # sans commit, les ajouts ne seraient pas enregistrés pour de bon

# 4) Lire : les joueurs qui ont au moins 2000, du plus riche au moins riche.
curseur.execute("SELECT pseudo, argent FROM joueurs WHERE argent >= ? ORDER BY argent DESC", (2000,))
for pseudo, argent in curseur.fetchall():
    print(f"{pseudo} : {argent}")

connexion.close()

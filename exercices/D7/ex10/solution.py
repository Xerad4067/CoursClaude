import sqlite3

connexion = sqlite3.connect(":memory:")
curseur = connexion.cursor()
curseur.execute("CREATE TABLE joueurs (pseudo TEXT, argent INTEGER)")
curseur.executemany("INSERT INTO joueurs VALUES (?, ?)", [("Sam", 1500), ("Kim", 8200), ("Alex", 3100)])
connexion.commit()


def chercher(pseudo):
    """Renvoie les lignes (pseudo, argent) du joueur demandé."""
    # Le ? réserve la place de la valeur : SQLite la reçoit à part, jamais mélangée au SQL.
    curseur.execute("SELECT pseudo, argent FROM joueurs WHERE pseudo = ?", (pseudo,))
    return curseur.fetchall()


for saisie in ["Sam", "x' OR '1'='1", "D'Artagnan"]:
    resultats = chercher(saisie)
    print(f"{saisie} -> {len(resultats)} résultat(s)")

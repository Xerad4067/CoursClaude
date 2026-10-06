import sqlite3

connexion = sqlite3.connect(":memory:")
curseur = connexion.cursor()
curseur.execute("CREATE TABLE comptes (pseudo TEXT PRIMARY KEY, argent INTEGER NOT NULL)")
curseur.executemany("INSERT INTO comptes VALUES (?, ?)", [("Sam", 500), ("Kim", 200)])
connexion.commit()


def solde(pseudo):
    """Renvoie l'argent du compte, ou None si le compte n'existe pas."""
    raise NotImplementedError("à toi d'écrire cette fonction")


def virement(de, vers, montant):
    """Envoie montant de 'de' vers 'vers'. Renvoie True si le virement a eu lieu, False sinon.
    Si quelque chose échoue, aucun des deux comptes ne doit avoir changé."""
    raise NotImplementedError("à toi d'écrire cette fonction")


print("Sam -> Kim, 150 :", virement("Sam", "Kim", 150))
print("Sam -> Kim, 1000 :", virement("Sam", "Kim", 1000))
print("Sam -> Fantome, 50 :", virement("Sam", "Fantome", 50))
print("Sam :", solde("Sam"))
print("Kim :", solde("Kim"))

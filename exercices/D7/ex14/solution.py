import sqlite3

connexion = sqlite3.connect(":memory:")
curseur = connexion.cursor()
curseur.execute("CREATE TABLE comptes (pseudo TEXT PRIMARY KEY, argent INTEGER NOT NULL)")
curseur.executemany("INSERT INTO comptes VALUES (?, ?)", [("Sam", 500), ("Kim", 200)])
connexion.commit()


def solde(pseudo):
    """Renvoie l'argent du compte, ou None si le compte n'existe pas."""
    curseur.execute("SELECT argent FROM comptes WHERE pseudo = ?", (pseudo,))
    ligne = curseur.fetchone()          # une ligne (un tuple), ou None s'il n'y en a aucune
    if ligne is None:
        return None
    return ligne[0]


def virement(de, vers, montant):
    """Envoie montant de 'de' vers 'vers'. Renvoie True si le virement a eu lieu, False sinon.
    Si quelque chose échoue, aucun des deux comptes ne doit avoir changé."""
    argent = solde(de)
    if argent is None or argent < montant:
        return False                    # compte inconnu ou solde insuffisant : rien n'a encore été modifié

    # Les deux UPDATE forment une seule opération : les deux réussissent, ou aucun.
    curseur.execute("UPDATE comptes SET argent = argent - ? WHERE pseudo = ?", (montant, de))
    curseur.execute("UPDATE comptes SET argent = argent + ? WHERE pseudo = ?", (montant, vers))
    if curseur.rowcount != 1:           # le destinataire n'existe pas : l'argent serait perdu !
        connexion.rollback()            # on annule aussi le retrait déjà fait
        return False
    connexion.commit()                  # tout s'est bien passé : on enregistre pour de bon
    return True


print("Sam -> Kim, 150 :", virement("Sam", "Kim", 150))
print("Sam -> Kim, 1000 :", virement("Sam", "Kim", 1000))
print("Sam -> Fantome, 50 :", virement("Sam", "Fantome", 50))
print("Sam :", solde("Sam"))
print("Kim :", solde("Kim"))

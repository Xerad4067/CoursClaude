# Fichier : inventaire.py : mini-projet du module D2
import os

FICHIER = "inventaire.txt"
inventaire = {}   # objet -> quantité


def ajouter(objet, quantite):
    inventaire[objet] = inventaire.get(objet, 0) + quantite
    print(f"+ {quantite} {objet}")


def retirer(objet, quantite):
    actuel = inventaire.get(objet, 0)
    if actuel < quantite:
        print(f"Impossible : il n'y a que {actuel} {objet}")
        return False
    inventaire[objet] = actuel - quantite
    if inventaire[objet] == 0:
        del inventaire[objet]          # on supprime les objets épuisés
    print(f"- {quantite} {objet}")
    return True


def afficher():
    print("Inventaire :")
    for objet in sorted(inventaire):   # ordre alphabétique
        print(f"  {objet} x{inventaire[objet]}")


def sauvegarder(chemin):
    with open(chemin, "w", encoding="utf-8") as fichier:
        for objet in sorted(inventaire):
            fichier.write(f"{objet};{inventaire[objet]}\n")
    print("Sauvegarde faite.")


def charger(chemin):
    inventaire.clear()
    try:
        with open(chemin, encoding="utf-8") as fichier:
            for ligne in fichier:
                objet, quantite = ligne.strip().split(";")
                inventaire[objet] = int(quantite)
    except FileNotFoundError:
        print("Aucune sauvegarde trouvée.")
        return False
    print("Sauvegarde chargée.")
    return True


if __name__ == "__main__":
    charger(FICHIER)               # première fois : pas encore de fichier
    ajouter("pain", 2)
    ajouter("eau", 3)
    ajouter("pain", 1)
    retirer("eau", 1)
    retirer("lampe", 1)
    afficher()
    sauvegarder(FICHIER)
    inventaire.clear()             # on « éteint le serveur »…
    afficher()
    charger(FICHIER)               # … et on le rallume : tout est revenu
    afficher()
    os.remove(FICHIER)             # ménage du fichier de test (à retirer dans ton vrai programme)

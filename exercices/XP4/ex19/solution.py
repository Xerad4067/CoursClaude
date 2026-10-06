# Fichier : inventaire_json.py
import json
import os

CHEMIN = "sac_joueur.json"


def charger():
    try:
        with open(CHEMIN, "r", encoding="utf-8") as fichier:
            return json.load(fichier)
    except FileNotFoundError:
        return {}


def sauvegarder(inventaire):
    with open(CHEMIN, "w", encoding="utf-8") as fichier:
        json.dump(inventaire, fichier, ensure_ascii=False, indent=2)


def lire_quantite(texte):
    try:
        quantite = int(texte)
    except ValueError:
        raise ValueError("« " + texte + " » n'est pas un nombre entier")
    if quantite < 1:
        raise ValueError("la quantité doit être au moins 1")
    return quantite


def ajouter(inventaire, objet, quantite):
    inventaire[objet] = inventaire.get(objet, 0) + quantite


def retirer(inventaire, objet, quantite):
    if inventaire.get(objet, 0) < quantite:
        raise ValueError("pas assez de " + objet)
    inventaire[objet] -= quantite
    if inventaire[objet] == 0:
        del inventaire[objet]                  # un objet à zéro disparaît du sac


def afficher(inventaire):
    if not inventaire:
        print("  (sac vide)")
    for objet in sorted(inventaire):
        print(f"  {objet:<8}{inventaire[objet]:>3}")


# Analyse une ligne tapée par le joueur et lève ValueError si elle est invalide.
def executer(inventaire, ligne):
    morceaux = ligne.strip().lower().split()
    if not morceaux:
        raise ValueError("commande vide")
    commande = morceaux[0]
    if commande == "/liste":
        afficher(inventaire)
    elif commande in ("/ajouter", "/retirer"):
        if len(morceaux) != 3:
            raise ValueError("usage : " + commande + " objet quantité")
        quantite = lire_quantite(morceaux[2])
        if commande == "/ajouter":
            ajouter(inventaire, morceaux[1], quantite)
        else:
            retirer(inventaire, morceaux[1], quantite)
    else:
        raise ValueError("commande inconnue : " + commande)


inventaire = charger()
print("Sac chargé :", inventaire)

while True:
    ligne = input("> ")
    if ligne.strip().lower() == "/quitter":
        break
    try:
        executer(inventaire, ligne)
    except ValueError as erreur:
        print("Refusé :", erreur)

sauvegarder(inventaire)
print("--- redémarrage ---")
inventaire = charger()
afficher(inventaire)

os.remove(CHEMIN)

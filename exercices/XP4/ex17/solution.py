# Fichier : sauvegarde.py
import json
import os

CHEMIN = "inventaire.json"


# Lit l'inventaire ; s'il n'y a pas encore de fichier, on part d'un inventaire vide.
def charger(chemin):
    try:
        with open(chemin, "r", encoding="utf-8") as fichier:
            return json.load(fichier)
    except FileNotFoundError:
        return {}


def sauvegarder(chemin, inventaire):
    with open(chemin, "w", encoding="utf-8") as fichier:
        json.dump(inventaire, fichier, ensure_ascii=False, indent=2)


inventaire = charger(CHEMIN)
print("Premier lancement :", inventaire)

inventaire["pain"] = 3
inventaire["épée"] = 1
sauvegarder(CHEMIN, inventaire)

print("--- le serveur redémarre ---")
inventaire = charger(CHEMIN)
print("Après redémarrage :", inventaire)

with open(CHEMIN, "r", encoding="utf-8") as fichier:
    print(fichier.read())

os.remove(CHEMIN)
